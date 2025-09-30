# ScaleRDB
ScaleRDB: A Scalable Relational Database for Manycore Systems. (Submitted in VLDB'26) 


## Introduction
ScaleRDB is a scalable relational database system designed to exploit the parallelism of manycore hardware by restructuring a monolithic database into a multi-instance shared-memory architecture. Traditional relational databases such as MySQL and PostgreSQL suffer from limited scalability on modern manycore platforms due to global contention in concurrency control, shared data structures, and synchronization overhead. These issues prevent efficient utilization of cores and severely restrict throughput under high concurrency.

ScaleRDB addresses these limitations by deploying multiple independent yet cooperative database instances, a single master, and multiple slaves on a single manycore machine. The master coordinates transaction distribution and global consistency, while each slave executes transactions, manages write-ahead logging, and performs checkpointing independently. This design eliminates global bottlenecks and enables parallel execution without contention on shared structures.

To maintain consistency with minimal overhead, ScaleRDB introduces a two-level asynchronous checkpointing mechanism: each slave periodically creates a local checkpoint to persist its state, and the master aggregates these into a global checkpoint representing the full database state. Additionally, a localized I/O approach allows each instance to manage its own logging and storage operations in parallel, significantly reducing I/O stalls.

## How to run ScaleRDB

First, Build and Install 
     
```
cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/kcj_cluster/mysql -DMYSQL_DATADIR=/mnt_ssd/jsm1/mysql-cluster_2/data -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=all -DENABLED_LOCAL_INFILE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1-DENABLE_DOWNLOADS=1 -DWITH_CLASSPATH=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.372.b07-1.el7_9.x86_64/-DMYSQL_UNIX_ADDR=/tmp/mysql_3306.sock -DSYSCONFDIR=/etc -DMYSQL_TCP_PORT=3306 -DCMAKE_CXX_STANDARD=11 && make -j N(core) && make install
```


Second, Initialize Database
    
```
./scripts/mysql_install_db --defaults-file=/usr/local/kcj_cluster/mysql/my.cnf --user=mysql --basedir=/usr/local/kcj_cluster/mysql --datadir=/nvme_ssd/jsm1/mysql-cluster_2/data
```


Third, Create and Modify Configuration files (NDB Cluster - Config.ini / MySQL - my.cnf)

### NDB_Cluster_Config file (config.ini)

-  Example (Config.ini)
     * DataMemory / IndexMemory: Set uniformly based on the available memory size and the number of instances. (DataMemory / IndexMemory)
     * DiskPageBufferMemory: Setting the DiskPageBufferMemory value for disk page buffering
     * [NDBD] List
     The following list of NDBD items manages the ID information for master-slave instances:
     The first NDBD entry is designated as the Master Instance.
     All subsequent NDBD entries are designated as Slave Instances.
     * [MYSQLD]: Set up the interface instance to use the MySQL Database interface.
```bash
$ vim config.ini
```
```bash
[NDBD DEFAULT]
NoOfReplicas=1
# Set uniformly based on the available memory size and the number of instances. (DataMemory / IndexMemory)
DataMemory=2000M 
IndexMemory=500M

# Setting the DiskPageBufferMemory value for disk page buffering
DiskPageBufferMemory=2000M

DataDir=/mnt_ssd/jsm1/var/mysql-cluster/mysql-cluster
MaxNoOfConcurrentOperations=100000
MaxNoOfLocalOperations=130000
NoOfFragmentLogFiles=3000
MaxDiskWriteSpeed=5000M
MinDiskWriteSpeed=250M

[NDB_MGMD DEFAULT]
DataDir=/mnt_ssd/jsm1/var/mysql-cluster/mysql-cluster



[NDB_MGMD]
NodeId=1
HostName=localhost (IP address)



[NDBD]
NodeId=10
HostName=localhost (IP address)

[NDBD]
NodeId=11
HostName=localhost (IP address)

[NDBD]
NodeId=12
HostName=localhost (IP address)

[NDBD]
NodeId=13
HostName=localhost (IP address)

... Number of Node (Instance) 

[MYSQLD]
NodeId=90
HostName=localhost (IP address)



[API]
```
### MySQL Config file (my.cnf)

-  Example (my.cnf)
     * The ndb-connectstring parameter in the existing MySQL my.cnf file needs to be updated to connect with the NDB engine. Refer to the ndbcluster line below for guidance.
```bash
$ vim my.cnf
```
```bash
[mysqld]

# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M

# Remove leading # to turn on a very important data integrity option: logging
# changes to the binary log between backups.
# log_bin



# These are commonly set, remove the # and set as required.
basedir = /usr/local/kcj_cluster/mysql
datadir = /nvme_ssd/jsm1/mysql-cluster_2/data
port = 3306
socket = /tmp/mysql_3306.sock


**ndbcluster
ndb-connectstring=localhost(IP address)       # IP address for server management node
default_storage_engine=ndbcluster             # Define default Storage Engine used by MySQL

[mysql_cluster]
ndb-connectstring=localhost(IP address)       # IP address for server management node**

```
Finally, Start ScaleRDB 

```
# Run ScaleRDB
$ ndb_run='/usr/local/kcj_cluster/mysql/bin/ndb_mgmd --skip-config-cache -f /etc/config.ini' 
     
# Run each instance in ScaleRDB  
$ ndbd 
     
# Run MySQL Server
$ ./bin/mysqld_safe --defaults-file=/usr/local/kcj_single_mysql/mysql/my_single.cnf --basedir=/usr/local/kcj_single_mysql/mysql &

```

## How to run ScaleRDB with TPC-C Benchmark.

First, Connect to the MySQL server and create a logfile and datafile to enable the NDB engine to utilize storage.
```            
$ ./bin/mysql -u root -p
   
CREATE LOGFILE GROUP lg_1 ADD UNDOFILE 'undo_1.log' INITIAL_SIZE 5000M UNDO_BUFFER_SIZE 100M ENGINE NDBCLUSTER;
CREATE TABLESPACE ts_1 ADD DATAFILE 'data_1.dat' USE LOGFILE GROUP lg_1 INITIAL_SIZE 30000M ENGINE NDBCLUSTER;

```
   
Second, Modify the table creation for the TPC-C benchmark to use the NDB engine.

```
# Install TPC-C Benchmark. 
$ git clone https://github.com/Percona-Lab/tpcc-mysql.git
$ cd src ; make
$ vim create_table.sql 
```

-  Example (TPC-C - create_table.sql)
```bash

create table district (
d_id tinyint not null,
d_w_id smallint not null,
d_name varchar(10),
d_street_1 varchar(20),
d_street_2 varchar(20),
d_city varchar(20),
d_state char(2),
d_zip char(9),
d_tax decimal(4,2),
d_ytd decimal(12,2),
d_next_o_id int,
primary key (d_w_id, d_id) ) **Engine=NDB;**

create table history (
h_c_id int,
h_c_d_id tinyint,
h_c_w_id smallint,
h_d_id tinyint,
h_w_id smallint,
h_date datetime,
h_amount decimal(6,2),
h_data varchar(24) ) **Engine=NDB;**

drop table if exists new_orders;

create table new_orders (
no_o_id int not null,
no_d_id tinyint not null,
no_w_id smallint not null,
PRIMARY KEY(no_w_id, no_d_id, no_o_id)) **Engine=NDB;**
```

Third, Load the TPC-C dataset and run the benchmark.
```
# Create databases
$ mysqladmin create tpcc1000
     
# Create tables and indexes.
$ mysql -u -p tpcc1000 < create_table.sql
$ mysql tpcc1000 < add_fkey_idx.sql

# Load Data
./tpcc_load -h127.0.0.1 -d tpcc1000 -u root -p "pw" -w [warehouse]
     
# Run Benchmark.
./tpcc_start -h127.0.0.1 -P3306 -dtpcc1000 -uroot -w[warehouse] -c[connection] -r[rampup time] -l[Measure runtime]

```


