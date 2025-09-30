#
# SQL commands for creating the tables in MySQL Server which
# are used by the NDBINFO storage engine to access system
# information and statistics from MySQL Cluster
#
# Only create objects if NDBINFO is supported
SELECT @have_ndbinfo:= COUNT(*) FROM information_schema.engines WHERE engine='NDBINFO' AND support IN ('YES', 'DEFAULT');

# Only create objects if version >= 7.1
SET @str=IF(@have_ndbinfo,'SELECT @have_ndbinfo:= (@@ndbinfo_version >= (7 << 16) | (1 << 8)) || @ndbinfo_skip_version_check','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE DATABASE IF NOT EXISTS `ndbinfo`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# Set NDBINFO in offline mode during (re)create of tables
# and views to avoid errors caused by no such table or
# different table definition in NDB
SET @str=IF(@have_ndbinfo,'SET @@global.ndbinfo_offline=TRUE','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# Drop any old views in ndbinfo
SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`transporters`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`logspaces`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`logbuffers`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`resources`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`counters`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`nodes`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`memoryusage`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`diskpagebuffer`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`diskpagebuffer`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`threadblocks`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`threadstat`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`disk_write_speed_base`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`disk_write_speed_aggregate`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`cluster_transactions`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`server_transactions`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`cluster_operations`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`server_operations`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`membership`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`arbitrator_validity_detail`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`arbitrator_validity_summary`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`memory_per_fragment`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP VIEW IF EXISTS `ndbinfo`.`operations_per_fragment`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# Drop any old lookup tables in ndbinfo
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`blocks`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`dict_obj_types`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`config_params`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$dbtc_apiconnect_state`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$dblqh_tcconnect_state`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$tables
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$tables`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$tables` (`table_id` INT UNSIGNED,`table_name` VARCHAR(512),`comment` VARCHAR(512)) COMMENT="metadata for tables available through ndbinfo" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$columns
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$columns`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$columns` (`table_id` INT UNSIGNED,`column_id` INT UNSIGNED,`column_name` VARCHAR(512),`column_type` INT UNSIGNED,`comment` VARCHAR(512)) COMMENT="metadata for columns available through ndbinfo " ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$test
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$test`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$test` (`node_id` INT UNSIGNED,`block_number` INT UNSIGNED,`block_instance` INT UNSIGNED,`counter` INT UNSIGNED,`counter2` BIGINT UNSIGNED) COMMENT="for testing" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$pools
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$pools`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$pools` (`node_id` INT UNSIGNED,`block_number` INT UNSIGNED,`block_instance` INT UNSIGNED,`pool_name` VARCHAR(512),`used` BIGINT UNSIGNED COMMENT "currently in use",`total` BIGINT UNSIGNED COMMENT "total allocated",`high` BIGINT UNSIGNED COMMENT "in use high water mark",`entry_size` BIGINT UNSIGNED COMMENT "size in bytes of each object",`config_param1` INT UNSIGNED COMMENT "config param 1 affecting pool",`config_param2` INT UNSIGNED COMMENT "config param 2 affecting pool",`config_param3` INT UNSIGNED COMMENT "config param 3 affecting pool",`config_param4` INT UNSIGNED COMMENT "config param 4 affecting pool") COMMENT="pool usage" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$transporters
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$transporters`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$transporters` (`node_id` INT UNSIGNED COMMENT "Node id reporting",`remote_node_id` INT UNSIGNED COMMENT "Node id at other end of link",`connection_status` INT UNSIGNED COMMENT "State of inter-node link",`remote_address` VARCHAR(512) COMMENT "Address of remote node",`bytes_sent` BIGINT UNSIGNED COMMENT "Bytes sent to remote node",`bytes_received` BIGINT UNSIGNED COMMENT "Bytes received from remote node",`connect_count` INT UNSIGNED COMMENT "Number of times connected",`overloaded` INT UNSIGNED COMMENT "Is link reporting overload",`overload_count` INT UNSIGNED COMMENT "Number of overload onsets since connect",`slowdown` INT UNSIGNED COMMENT "Is link requesting slowdown",`slowdown_count` INT UNSIGNED COMMENT "Number of slowdown onsets since connect") COMMENT="transporter status" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$logspaces
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$logspaces`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$logspaces` (`node_id` INT UNSIGNED,`log_type` INT UNSIGNED COMMENT "0 = REDO, 1 = DD-UNDO",`log_id` INT UNSIGNED,`log_part` INT UNSIGNED,`total` BIGINT UNSIGNED COMMENT "total allocated",`used` BIGINT UNSIGNED COMMENT "currently in use",`high` BIGINT UNSIGNED COMMENT "in use high water mark") COMMENT="logspace usage" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$logbuffers
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$logbuffers`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$logbuffers` (`node_id` INT UNSIGNED,`log_type` INT UNSIGNED COMMENT "0 = REDO, 1 = DD-UNDO",`log_id` INT UNSIGNED,`log_part` INT UNSIGNED,`total` BIGINT UNSIGNED COMMENT "total allocated",`used` BIGINT UNSIGNED COMMENT "currently in use",`high` BIGINT UNSIGNED COMMENT "in use high water mark") COMMENT="logbuffer usage" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$resources
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$resources`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$resources` (`node_id` INT UNSIGNED,`resource_id` INT UNSIGNED,`reserved` INT UNSIGNED COMMENT "reserved for this resource",`used` INT UNSIGNED COMMENT "currently in use",`max` INT UNSIGNED COMMENT "max available",`high` INT UNSIGNED COMMENT "in use high water mark") COMMENT="resources usage (a.k.a superpool)" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$counters
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$counters`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$counters` (`node_id` INT UNSIGNED,`block_number` INT UNSIGNED,`block_instance` INT UNSIGNED,`counter_id` INT UNSIGNED,`val` BIGINT UNSIGNED COMMENT "monotonically increasing since process start") COMMENT="monotonic counters" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$nodes
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$nodes`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$nodes` (`node_id` INT UNSIGNED,`uptime` BIGINT UNSIGNED COMMENT "time in seconds that node has been running",`status` INT UNSIGNED COMMENT "starting/started/stopped etc.",`start_phase` INT UNSIGNED COMMENT "start phase if node is starting",`config_generation` INT UNSIGNED COMMENT "configuration generation number") COMMENT="node status" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$diskpagebuffer
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$diskpagebuffer`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$diskpagebuffer` (`node_id` INT UNSIGNED,`block_instance` INT UNSIGNED,`pages_written` BIGINT UNSIGNED COMMENT "Pages written to disk",`pages_written_lcp` BIGINT UNSIGNED COMMENT "Pages written by local checkpoint",`pages_read` BIGINT UNSIGNED COMMENT "Pages read from disk",`log_waits` BIGINT UNSIGNED COMMENT "Page writes waiting for log to be written to disk",`page_requests_direct_return` BIGINT UNSIGNED COMMENT "Page in buffer and no requests waiting for it",`page_requests_wait_queue` BIGINT UNSIGNED COMMENT "Page in buffer, but some requests are already waiting for it",`page_requests_wait_io` BIGINT UNSIGNED COMMENT "Page not in buffer, waiting to be read from disk") COMMENT="disk page buffer info" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$threadblocks
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$threadblocks`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$threadblocks` (`node_id` INT UNSIGNED COMMENT "node id",`thr_no` INT UNSIGNED COMMENT "thread number",`block_number` INT UNSIGNED COMMENT "block number",`block_instance` INT UNSIGNED COMMENT "block instance") COMMENT="which blocks are run in which threads" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$threadstat
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$threadstat`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$threadstat` (`node_id` INT UNSIGNED COMMENT "node id",`thr_no` INT UNSIGNED COMMENT "thread number",`thr_nm` VARCHAR(512) COMMENT "thread name",`c_loop` BIGINT UNSIGNED COMMENT "No of loops in main loop",`c_exec` BIGINT UNSIGNED COMMENT "No of signals executed",`c_wait` BIGINT UNSIGNED COMMENT "No of times waited for more input",`c_l_sent_prioa` BIGINT UNSIGNED COMMENT "No of prio A signals sent to own node",`c_l_sent_priob` BIGINT UNSIGNED COMMENT "No of prio B signals sent to own node",`c_r_sent_prioa` BIGINT UNSIGNED COMMENT "No of prio A signals sent to remote node",`c_r_sent_priob` BIGINT UNSIGNED COMMENT "No of prio B signals sent to remote node",`os_tid` BIGINT UNSIGNED COMMENT "OS thread id",`os_now` BIGINT UNSIGNED COMMENT "OS gettimeofday (millis)",`os_ru_utime` BIGINT UNSIGNED COMMENT "OS user CPU time (micros)",`os_ru_stime` BIGINT UNSIGNED COMMENT "OS system CPU time (micros)",`os_ru_minflt` BIGINT UNSIGNED COMMENT "OS page reclaims (soft page faults",`os_ru_majflt` BIGINT UNSIGNED COMMENT "OS page faults (hard page faults)",`os_ru_nvcsw` BIGINT UNSIGNED COMMENT "OS voluntary context switches",`os_ru_nivcsw` BIGINT UNSIGNED COMMENT "OS involuntary context switches") COMMENT="Statistics on execution threads" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$transactions
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$transactions`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$transactions` (`node_id` INT UNSIGNED COMMENT "node id",`block_instance` INT UNSIGNED COMMENT "TC instance no",`objid` INT UNSIGNED COMMENT "Object id of transaction object",`apiref` INT UNSIGNED COMMENT "API reference",`transid0` INT UNSIGNED COMMENT "Transaction id",`transid1` INT UNSIGNED COMMENT "Transaction id",`state` INT UNSIGNED COMMENT "Transaction state",`flags` INT UNSIGNED COMMENT "Transaction flags",`c_ops` INT UNSIGNED COMMENT "No of operations in transaction",`outstanding` INT UNSIGNED COMMENT "Currently outstanding request",`timer` INT UNSIGNED COMMENT "Timer (seconds)") COMMENT="transactions" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$operations
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$operations`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$operations` (`node_id` INT UNSIGNED COMMENT "node id",`block_instance` INT UNSIGNED COMMENT "LQH instance no",`objid` INT UNSIGNED COMMENT "Object id of operation object",`tcref` INT UNSIGNED COMMENT "TC reference",`apiref` INT UNSIGNED COMMENT "API reference",`transid0` INT UNSIGNED COMMENT "Transaction id",`transid1` INT UNSIGNED COMMENT "Transaction id",`tableid` INT UNSIGNED COMMENT "Table id",`fragmentid` INT UNSIGNED COMMENT "Fragment id",`op` INT UNSIGNED COMMENT "Operation type",`state` INT UNSIGNED COMMENT "Operation state",`flags` INT UNSIGNED COMMENT "Operation flags") COMMENT="operations" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$membership
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$membership`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$membership` (`node_id` INT UNSIGNED COMMENT "node id",`group_id` INT UNSIGNED COMMENT "node group id",`left_node` INT UNSIGNED COMMENT "Left node in heart beat chain",`right_node` INT UNSIGNED COMMENT "Right node in heart beat chain",`president` INT UNSIGNED COMMENT "President nodeid",`successor` INT UNSIGNED COMMENT "President successor",`dynamic_id` INT UNSIGNED COMMENT "President, Configured_heartbeat order",`arbitrator` INT UNSIGNED COMMENT "Arbitrator nodeid",`arb_ticket` VARCHAR(512) COMMENT "Arbitrator ticket",`arb_state` INT UNSIGNED COMMENT "Arbitrator state",`arb_connected` INT UNSIGNED COMMENT "Arbitrator connected",`conn_rank1_arbs` VARCHAR(512) COMMENT "Connected rank 1 arbitrators",`conn_rank2_arbs` VARCHAR(512) COMMENT "Connected rank 2 arbitrators") COMMENT="membership" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$dict_obj_info
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$dict_obj_info`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$dict_obj_info` (`type` INT UNSIGNED COMMENT "Type of dict object",`id` INT UNSIGNED COMMENT "Object identity",`version` INT UNSIGNED COMMENT "Object version",`state` INT UNSIGNED COMMENT "Object state",`parent_obj_type` INT UNSIGNED COMMENT "Parent object type",`parent_obj_id` INT UNSIGNED COMMENT "Parent object id",`fq_name` VARCHAR(512) COMMENT "Fully qualified object name") COMMENT="Dictionary object info" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$frag_mem_use
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$frag_mem_use`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$frag_mem_use` (`node_id` INT UNSIGNED COMMENT "node id",`block_instance` INT UNSIGNED COMMENT "LDM instance number",`table_id` INT UNSIGNED COMMENT "Table identity",`fragment_num` INT UNSIGNED COMMENT "Fragment number",`rows` BIGINT UNSIGNED COMMENT "Number of rows in table",`fixed_elem_alloc_bytes` BIGINT UNSIGNED COMMENT "Number of bytes allocated for fixed-sized elements",`fixed_elem_free_bytes` BIGINT UNSIGNED COMMENT "Free bytes in fixed-size element pages",`fixed_elem_count` BIGINT UNSIGNED COMMENT "Number of fixed size elements in use",`fixed_elem_size_bytes` INT UNSIGNED COMMENT "Length of each fixed sized element in bytes",`var_elem_alloc_bytes` BIGINT UNSIGNED COMMENT "Number of bytes allocated for var-size elements",`var_elem_free_bytes` BIGINT UNSIGNED COMMENT "Free bytes in var-size element pages",`var_elem_count` BIGINT UNSIGNED COMMENT "Number of var size elements in use",`tuple_l2pmap_alloc_bytes` BIGINT UNSIGNED COMMENT "Bytes in logical to physical page map for tuple store",`hash_index_l2pmap_alloc_bytes` BIGINT UNSIGNED COMMENT "Bytes in logical to physical page map for the hash index",`hash_index_alloc_bytes` BIGINT UNSIGNED COMMENT "Bytes in linear hash map") COMMENT="Per fragment space information" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$disk_write_speed_base
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$disk_write_speed_base`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$disk_write_speed_base` (`node_id` INT UNSIGNED COMMENT "node_id",`thr_no` INT UNSIGNED COMMENT "LDM thread instance",`millis_ago` BIGINT UNSIGNED COMMENT "Milliseconds ago since period finished",`millis_passed` BIGINT UNSIGNED COMMENT "Milliseconds passed in the period reported",`backup_lcp_bytes_written` BIGINT UNSIGNED COMMENT "Bytes written in the period for backups and LCP",`redo_bytes_written` BIGINT UNSIGNED COMMENT "Bytes written in the period for REDO log",`target_disk_write_speed` BIGINT UNSIGNED COMMENT "Target disk write speed at time of measurement") COMMENT="Actual speed of disk writes per LDM thread, base data" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$disk_write_speed_aggregate
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$disk_write_speed_aggregate`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$disk_write_speed_aggregate` (`node_id` INT UNSIGNED COMMENT "node_id",`thr_no` INT UNSIGNED COMMENT "LDM thread instance",`backup_lcp_speed_last_sec` BIGINT UNSIGNED COMMENT "Number of kBytes written by backup and LCP last second",`redo_speed_last_sec` BIGINT UNSIGNED COMMENT "Number of kBytes written to REDO log last second",`backup_lcp_speed_last_10sec` BIGINT UNSIGNED COMMENT "Number of kBytes written by backup and LCP per second last 10 seconds",`redo_speed_last_10sec` BIGINT UNSIGNED COMMENT "Number of kBytes written to REDO log per second last 10 seconds",`std_dev_backup_lcp_speed_last_10sec` BIGINT UNSIGNED COMMENT "Standard deviation of Number of kBytes written by backup and LCP per second last 10 seconds",`std_dev_redo_speed_last_10sec` BIGINT UNSIGNED COMMENT "Standard deviation of Number of kBytes written to REDO log per second last 10 seconds",`backup_lcp_speed_last_60sec` BIGINT UNSIGNED COMMENT "Number of kBytes written by backup and LCP per second last 60 seconds",`redo_speed_last_60sec` BIGINT UNSIGNED COMMENT "Number of kBytes written to REDO log per second last 60 seconds",`std_dev_backup_lcp_speed_last_60sec` BIGINT UNSIGNED COMMENT "Standard deviation of Number of kBytes written by backup and LCP per second last 60 seconds",`std_dev_redo_speed_last_60sec` BIGINT UNSIGNED COMMENT "Standard deviation of Number of kBytes written to REDO log per second last 60 seconds",`slowdowns_due_to_io_lag` BIGINT UNSIGNED COMMENT "Number of seconds that we got slowdown due to REDO IO lagging",`slowdowns_due_to_high_cpu` BIGINT UNSIGNED COMMENT "Number of seconds that we got slowdown due to high CPU usage",`disk_write_speed_set_to_min` BIGINT UNSIGNED COMMENT "Number of seconds that we slowed down to a minimum disk write speed",`current_target_disk_write_speed` BIGINT UNSIGNED COMMENT "Current target of disk write speed") COMMENT="Actual speed of disk writes per LDM thread, aggregate data" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$frag_operations
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$frag_operations`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$frag_operations` (`node_id` INT UNSIGNED COMMENT "node id",`block_instance` INT UNSIGNED COMMENT "LQH instance no",`table_id` INT UNSIGNED COMMENT "Table identity",`fragment_num` INT UNSIGNED COMMENT "Fragment number",`tot_key_reads` BIGINT UNSIGNED COMMENT "Total number of key reads received",`tot_key_inserts` BIGINT UNSIGNED COMMENT "Total number of key inserts received",`tot_key_updates` BIGINT UNSIGNED COMMENT "Total number of key updates received",`tot_key_writes` BIGINT UNSIGNED COMMENT "Total number of key writes received",`tot_key_deletes` BIGINT UNSIGNED COMMENT "Total number of key deletes received",`tot_key_refs` BIGINT UNSIGNED COMMENT "Total number of key operations refused by LDM",`tot_key_attrinfo_bytes` BIGINT UNSIGNED COMMENT "Total attrinfo bytes received for key operations",`tot_key_keyinfo_bytes` BIGINT UNSIGNED COMMENT "Total keyinfo bytes received for key operations",`tot_key_prog_bytes` BIGINT UNSIGNED COMMENT "Total bytes of filter programs for key operations",`tot_key_inst_exec` BIGINT UNSIGNED COMMENT "Total number of interpreter instructions executed for key operations",`tot_key_bytes_returned` BIGINT UNSIGNED COMMENT "Total number of bytes returned to client for key operations",`tot_frag_scans` BIGINT UNSIGNED COMMENT "Total number of fragment scans received",`tot_scan_rows_examined` BIGINT UNSIGNED COMMENT "Total number of rows examined by scans",`tot_scan_rows_returned` BIGINT UNSIGNED COMMENT "Total number of rows returned to client by scan",`tot_scan_bytes_returned` BIGINT UNSIGNED COMMENT "Total number of bytes returned to client by scans",`tot_scan_prog_bytes` BIGINT UNSIGNED COMMENT "Total bytes of scan filter programs",`tot_scan_bound_bytes` BIGINT UNSIGNED COMMENT "Total bytes of scan bounds",`tot_scan_inst_exec` BIGINT UNSIGNED COMMENT "Total number of interpreter instructions executed for scans",`tot_qd_frag_scans` BIGINT UNSIGNED COMMENT "Total number of fragment scans queued before exec",`conc_frag_scans` INT UNSIGNED COMMENT "Number of frag scans currently running",`conc_qd_plain_frag_scans` INT UNSIGNED COMMENT "Number of tux frag scans currently queued",`conc_qd_tup_frag_scans` INT UNSIGNED COMMENT "Number of tup frag scans currently queued",`conc_qd_acc_frag_scans` INT UNSIGNED COMMENT "Number of acc frag scans currently queued",`tot_commits` BIGINT UNSIGNED COMMENT "Total number of committed row changes") COMMENT="Per fragment operational information" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$restart_info
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$restart_info`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$restart_info` (`node_id` INT UNSIGNED COMMENT "node_id",`node_restart_status` VARCHAR(512) COMMENT "Current state of node recovery",`node_restart_status_int` INT UNSIGNED COMMENT "Current state of node recovery as number",`secs_to_complete_node_failure` INT UNSIGNED COMMENT "Seconds to complete node failure handling",`secs_to_allocate_node_id` INT UNSIGNED COMMENT "Seconds from node failure completion to allocation of node id",`secs_to_include_in_heartbeat_protocol` INT UNSIGNED COMMENT "Seconds from allocation of node id to inclusion in HB protocol",`secs_until_wait_for_ndbcntr_master` INT UNSIGNED COMMENT "Seconds from included in HB protocol until we wait for ndbcntr master",`secs_wait_for_ndbcntr_master` INT UNSIGNED COMMENT "Seconds we waited for being accepted by NDBCNTR master to start",`secs_to_get_start_permitted` INT UNSIGNED COMMENT "Seconds from permit by master until all nodes accepted our start",`secs_to_wait_for_lcp_for_copy_meta_data` INT UNSIGNED COMMENT "Seconds waiting for LCP completion before copying meta data",`secs_to_copy_meta_data` INT UNSIGNED COMMENT "Seconds to copy meta data to starting node from master",`secs_to_include_node` INT UNSIGNED COMMENT "Seconds to wait for GCP and inclusion of all nodes into protocols",`secs_starting_node_to_request_local_recovery` INT UNSIGNED COMMENT "Seconds for starting node to request local recovery",`secs_for_local_recovery` INT UNSIGNED COMMENT "Seconds for local recovery in starting node",`secs_restore_fragments` INT UNSIGNED COMMENT "Seconds to restore fragments from LCP files",`secs_undo_disk_data` INT UNSIGNED COMMENT "Seconds to execute UNDO log on disk data part of records",`secs_exec_redo_log` INT UNSIGNED COMMENT "Seconds to execute REDO log on all restored fragments",`secs_index_rebuild` INT UNSIGNED COMMENT "Seconds to rebuild indexes on restored fragments",`secs_to_synchronize_starting_node` INT UNSIGNED COMMENT "Seconds to synchronize starting node from live nodes",`secs_wait_lcp_for_restart` INT UNSIGNED COMMENT "Seconds to wait for LCP start and completion before restart is completed",`secs_wait_subscription_handover` INT UNSIGNED COMMENT "Seconds waiting for handover of replication subscriptions",`total_restart_secs` INT UNSIGNED COMMENT "Total number of seconds from node failure until node is started again") COMMENT="Times of restart phases in seconds and current state" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$tc_time_track_stats
SET @str=IF(@have_ndbinfo,'DROP TABLE IF EXISTS `ndbinfo`.`ndb$tc_time_track_stats`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$tc_time_track_stats` (`node_id` INT UNSIGNED COMMENT "node_id",`block_number` INT UNSIGNED COMMENT "Block number",`block_instance` INT UNSIGNED COMMENT "Block instance",`comm_node_id` INT UNSIGNED COMMENT "node_id of API or DB",`upper_bound` BIGINT UNSIGNED COMMENT "Upper bound in micros of interval",`scans` BIGINT UNSIGNED COMMENT "scan histogram interval",`scan_errors` BIGINT UNSIGNED COMMENT "scan error histogram interval",`scan_fragments` BIGINT UNSIGNED COMMENT "scan fragment histogram interval",`scan_fragment_errors` BIGINT UNSIGNED COMMENT "scan fragment error histogram interval",`transactions` BIGINT UNSIGNED COMMENT "transaction histogram interval",`transaction_errors` BIGINT UNSIGNED COMMENT "transaction error histogram interval",`read_key_ops` BIGINT UNSIGNED COMMENT "read key operation histogram interval",`write_key_ops` BIGINT UNSIGNED COMMENT "write key operation histogram interval",`index_key_ops` BIGINT UNSIGNED COMMENT "index key operation histogram interval",`key_op_errors` BIGINT UNSIGNED COMMENT "key operation error histogram interval") COMMENT="Time tracking of transaction, key operations and scan ops" ENGINE=NDBINFO','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.blocks
SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`blocks` (block_number INT UNSIGNED PRIMARY KEY, block_name VARCHAR(512))','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'INSERT INTO `ndbinfo`.`blocks` VALUES (254, "CMVMI"), (248, "DBACC"), (250, "DBDICT"), (246, "DBDIH"), (247, "DBLQH"), (245, "DBTC"), (249, "DBTUP"), (253, "NDBFS"), (251, "NDBCNTR"), (252, "QMGR"), (255, "TRIX"), (244, "BACKUP"), (256, "DBUTIL"), (257, "SUMA"), (258, "DBTUX"), (259, "TSMAN"), (260, "LGMAN"), (261, "PGMAN"), (262, "RESTORE"), (263, "DBINFO"), (264, "DBSPJ"), (265, "THRMAN"), (266, "TRPMAN")','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.dict_obj_types
SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`dict_obj_types` (type_id` INT UNSIGNED PRIMARY KEY, type_name VARCHAR(512))','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'INSERT INTO `ndbinfo`.`dict_obj_types` VALUES (1, "System table"), (2, "User table"), (3, "Unique hash index"), (4, "Hash index"), (5, "Unique ordered index"), (6, "Ordered index"), (11, "Hash index trigger"), (16, "Subscription trigger"), (17, "Read only constraint"), (18, "Index trigger"), (19, "Reorganize trigger"), (20, "Tablespace"), (21, "Log file group"), (22, "Data file"), (23, "Undo file"), (24, "Hash map"), (25, "Foreign key definition"), (26, "Foreign key parent trigger"), (27, "Foreign key child trigger"), (30, "Schema transaction")','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.config_params
SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`config_params` (param_number INT UNSIGNED PRIMARY KEY, param_name VARCHAR(512))','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'INSERT INTO `ndbinfo`.`config_params` VALUES (179, "MaxNoOfSubscriptions"), (180, "MaxNoOfSubscribers"), (181, "MaxNoOfConcurrentSubOperations"), (636, "TcpBind_INADDR_ANY"), (5, "HostName"), (3, "NodeId"), (635, "ServerPort"), (101, "NoOfReplicas"), (103, "MaxNoOfAttributes"), (102, "MaxNoOfTables"), (149, "MaxNoOfOrderedIndexes"), (150, "MaxNoOfUniqueHashIndexes"), (110, "MaxNoOfConcurrentIndexOperations"), (105, "MaxNoOfTriggers"), (109, "MaxNoOfFiredTriggers"), (100, "MaxNoOfSavedMessages"), (177, "LockExecuteThreadToCPU"), (178, "LockMaintThreadsToCPU"), (176, "RealtimeScheduler"), (114, "LockPagesInMainMemory"), (123, "TimeBetweenWatchDogCheck"), (174, "SchedulerExecutionTimer"), (644, "MaxSendDelay"), (175, "SchedulerSpinTimer"), (646, "SchedulerResponsiveness"), (647, "__sched_scan_priority"), (141, "TimeBetweenWatchDogCheckInitial"), (124, "StopOnError"), (107, "MaxNoOfConcurrentOperations"), (627, "MaxDMLOperationsPerTransaction"), (151, "MaxNoOfLocalOperations"), (152, "MaxNoOfLocalScans"), (153, "BatchSizePerLocalScan"), (106, "MaxNoOfConcurrentTransactions"), (108, "MaxNoOfConcurrentScans"), (111, "TransactionBufferMemory"), (113, "IndexMemory"), (112, "DataMemory"), (154, "UndoIndexBuffer"), (155, "UndoDataBuffer"), (156, "RedoBuffer"), (157, "LongMessageBuffer"), (160, "DiskPageBufferMemory"), (198, "SharedGlobalMemory"), (115, "StartPartialTimeout"), (116, "StartPartitionedTimeout"), (117, "StartFailureTimeout"), (619, "StartNoNodegroupTimeout"), (118, "HeartbeatIntervalDbDb"), (618, "ConnectCheckIntervalDelay"), (119, "HeartbeatIntervalDbApi"), (120, "TimeBetweenLocalCheckpoints"), (121, "TimeBetweenGlobalCheckpoints"), (206, "TimeBetweenGlobalCheckpointsTimeout"), (170, "TimeBetweenEpochs"), (171, "TimeBetweenEpochsTimeout"), (182, "MaxBufferedEpochs"), (350, "MaxBufferedEpochBytes"), (632, "NoOfFragmentLogParts"), (126, "NoOfFragmentLogFiles"), (140, "FragmentLogFileSize"), (189, "InitFragmentLogFiles"), (190, "DiskIOThreadPool"), (159, "MaxNoOfOpenFiles"), (162, "InitialNoOfOpenFiles"), (129, "TimeBetweenInactiveTransactionAbortCheck"), (130, "TransactionInactiveTimeout"), (131, "TransactionDeadlockDetectionTimeout"), (148, "Diskless"), (122, "ArbitrationTimeout"), (142, "Arbitration"), (7, "DataDir"), (125, "FileSystemPath"), (250, "LogLevelStartup"), (251, "LogLevelShutdown"), (252, "LogLevelStatistic"), (253, "LogLevelCheckpoint"), (254, "LogLevelNodeRestart"), (255, "LogLevelConnection"), (259, "LogLevelCongestion"), (258, "LogLevelError"), (256, "LogLevelInfo"), (158, "BackupDataDir"), (163, "DiskSyncSize"), (638, "MinDiskWriteSpeed"), (639, "MaxDiskWriteSpeed"), (640, "MaxDiskWriteSpeedOtherNodeRestart"), (641, "MaxDiskWriteSpeedOwnRestart"), (645, "BackupDiskWriteSpeedPct"), (134, "BackupDataBufferSize"), (135, "BackupLogBufferSize"), (136, "BackupWriteSize"), (139, "BackupMaxWriteSize"), (161, "StringMemory"), (169, "MaxAllocate"), (166, "MemReportFrequency"), (167, "BackupReportFrequency"), (184, "StartupStatusReportFrequency"), (168, "ODirect"), (172, "CompressedBackup"), (173, "CompressedLCP"), (203, "ExtraSendBufferMemory"), (9, "TotalSendBufferMemory"), (185, "Nodegroup"), (186, "MaxNoOfExecutionThreads"), (188, "__ndbmt_lqh_workers"), (187, "__ndbmt_lqh_threads"), (191, "__ndbmt_classic"), (628, "ThreadConfig"), (193, "FileSystemPathDD"), (194, "FileSystemPathDataFiles"), (195, "FileSystemPathUndoFiles"), (196, "InitialLogfileGroup"), (197, "InitialTablespace"), (605, "MaxLCPStartDelay"), (606, "BuildIndexThreads"), (607, "HeartbeatOrder"), (608, "DictTrace"), (609, "MaxStartFailRetries"), (610, "StartFailRetryDelay"), (613, "EventLogBufferSize"), (614, "Numa"), (611, "RedoOverCommitLimit"), (612, "RedoOverCommitCounter"), (615, "LateAlloc"), (643, "MaxParallelCopyInstances"), (616, "TwoPassInitialNodeRestartCopy"), (617, "MaxParallelScansPerFragment"), (620, "IndexStatAutoCreate"), (621, "IndexStatAutoUpdate"), (622, "IndexStatSaveSize"), (623, "IndexStatSaveScale"), (624, "IndexStatTriggerPct"), (625, "IndexStatTriggerScale"), (626, "IndexStatUpdateDelay"), (629, "CrashOnCorruptedTuple"), (630, "MinFreePct"), (806, "DefaultHashmapSize"), (631, "LcpScanProgressTimeout"), (633, "__at_restart_skip_indexes"), (634, "__at_restart_skip_fks"), (642, "__debug_mixology_level"), (637, "RestartSubscriberConnectTimeout"), (205, "DiskPageBufferEntries")','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$dbtc_apiconnect_state
SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$dbtc_apiconnect_state` (state_int_value  INT UNSIGNED PRIMARY KEY, state_name VARCHAR(256), state_friendly_name VARCHAR(256), state_description VARCHAR(256))','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'INSERT INTO `ndbinfo`.`ndb$dbtc_apiconnect_state` VALUES (0, "CS_CONNECTED", "Connected", "An allocated idle transaction object"), (1, "CS_DISCONNECTED", "Disconnected", "An unallocated connection object"), (2, "CS_STARTED", "Started", "A started transaction"), (3, "CS_RECEIVING", "Receiving", "A transaction receiving operations"), (7, "CS_RESTART", "", ""), (8, "CS_ABORTING", "Aborting", "A transaction aborting"), (9, "CS_COMPLETING", "Completing", "A transaction completing"), (10, "CS_COMPLETE_SENT", "Completing", "A transaction completing"), (11, "CS_PREPARE_TO_COMMIT", "", ""), (12, "CS_COMMIT_SENT", "Committing", "A transaction committing"), (13, "CS_START_COMMITTING", "", ""), (14, "CS_COMMITTING", "Committing", "A transaction committing"), (15, "CS_REC_COMMITTING", "", ""), (16, "CS_WAIT_ABORT_CONF", "Aborting", ""), (17, "CS_WAIT_COMPLETE_CONF", "Completing", ""), (18, "CS_WAIT_COMMIT_CONF", "Committing", ""), (19, "CS_FAIL_ABORTING", "TakeOverAborting", ""), (20, "CS_FAIL_ABORTED", "TakeOverAborting", ""), (21, "CS_FAIL_PREPARED", "", ""), (22, "CS_FAIL_COMMITTING", "TakeOverCommitting", ""), (23, "CS_FAIL_COMMITTED", "TakeOverCommitting", ""), (24, "CS_FAIL_COMPLETED", "TakeOverCompleting", ""), (25, "CS_START_SCAN", "Scanning", ""), (26, "CS_SEND_FIRE_TRIG_REQ", "Precomitting", ""), (27, "CS_WAIT_FIRE_TRIG_REQ", "Precomitting", "")','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.ndb$dblqh_tcconnect_state
SET @str=IF(@have_ndbinfo,'CREATE TABLE `ndbinfo`.`ndb$dblqh_tcconnect_state` (state_int_value  INT UNSIGNED PRIMARY KEY, state_name VARCHAR(256), state_friendly_name VARCHAR(256), state_description VARCHAR(256))','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

SET @str=IF(@have_ndbinfo,'INSERT INTO `ndbinfo`.`ndb$dblqh_tcconnect_state` VALUES (0, "IDLE", "Idle", ""), (1, "WAIT_ACC", "WaitLock", ""), (2, "WAIT_TUPKEYINFO", "", ""), (3, "WAIT_ATTR", "WaitData", ""), (4, "WAIT_TUP", "WaitTup", ""), (6, "LOG_QUEUED", "LogPrepare", ""), (7, "PREPARED", "Prepared", ""), (8, "LOG_COMMIT_WRITTEN_WAIT_SIGNAL", "", ""), (9, "LOG_COMMIT_QUEUED_WAIT_SIGNAL", "", ""), (11, "LOG_COMMIT_QUEUED", "Committing", ""), (12, "COMMIT_QUEUED", "Committing", ""), (13, "COMMITTED", "Committed", ""), (35, "WAIT_TUP_COMMIT", "Committing", ""), (14, "WAIT_ACC_ABORT", "Aborting", ""), (15, "ABORT_QUEUED", "Aborting", ""), (17, "WAIT_AI_AFTER_ABORT", "Aborting", ""), (18, "LOG_ABORT_QUEUED", "Aborting", ""), (19, "WAIT_TUP_TO_ABORT", "Aborting", ""), (20, "WAIT_SCAN_AI", "Scanning", ""), (21, "SCAN_STATE_USED", "Scanning", ""), (30, "SCAN_TUPKEY", "Scanning", ""), (31, "COPY_TUPKEY", "NodeRecoveryScanning", ""), (32, "TC_NOT_CONNECTED", "Idle", ""), (33, "PREPARED_RECEIVED_COMMIT", "Committing", ""), (34, "LOG_COMMIT_WRITTEN", "Committing", "")','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.transporters
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`transporters` AS SELECT node_id, remote_node_id,  CASE connection_status  WHEN 0 THEN "CONNECTED"  WHEN 1 THEN "CONNECTING"  WHEN 2 THEN "DISCONNECTED"  WHEN 3 THEN "DISCONNECTING"  ELSE NULL  END AS status,  remote_address, bytes_sent, bytes_received,  connect_count,  overloaded, overload_count, slowdown, slowdown_count FROM `ndbinfo`.`ndb$transporters`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.logspaces
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`logspaces` AS SELECT node_id,  CASE log_type  WHEN 0 THEN "REDO"  WHEN 1 THEN "DD-UNDO"  ELSE NULL  END AS log_type, log_id, log_part, total, used FROM `ndbinfo`.`ndb$logspaces`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.logbuffers
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`logbuffers` AS SELECT node_id,  CASE log_type  WHEN 0 THEN "REDO"  WHEN 1 THEN "DD-UNDO"  ELSE "<unknown>"  END AS log_type, log_id, log_part, total, used FROM `ndbinfo`.`ndb$logbuffers`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.resources
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`resources` AS SELECT node_id,  CASE resource_id  WHEN 0 THEN "RESERVED"  WHEN 1 THEN "DISK_OPERATIONS"  WHEN 2 THEN "DISK_RECORDS"  WHEN 3 THEN "DATA_MEMORY"  WHEN 4 THEN "JOBBUFFER"  WHEN 5 THEN "FILE_BUFFERS"  WHEN 6 THEN "TRANSPORTER_BUFFERS"  WHEN 7 THEN "DISK_PAGE_BUFFER"  WHEN 8 THEN "QUERY_MEMORY"  WHEN 9 THEN "SCHEMA_TRANS_MEMORY"  ELSE "<unknown>"  END AS resource_name, reserved, used, max FROM `ndbinfo`.`ndb$resources`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.counters
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`counters` AS SELECT node_id, b.block_name, block_instance, counter_id, CASE counter_id  WHEN 1 THEN "ATTRINFO"  WHEN 2 THEN "TRANSACTIONS"  WHEN 3 THEN "COMMITS"  WHEN 4 THEN "READS"  WHEN 5 THEN "SIMPLE_READS"  WHEN 6 THEN "WRITES"  WHEN 7 THEN "ABORTS"  WHEN 8 THEN "TABLE_SCANS"  WHEN 9 THEN "RANGE_SCANS"  WHEN 10 THEN "OPERATIONS"  WHEN 11 THEN "READS_RECEIVED"  WHEN 12 THEN "LOCAL_READS_SENT"  WHEN 13 THEN "REMOTE_READS_SENT"  WHEN 14 THEN "READS_NOT_FOUND"  WHEN 15 THEN "TABLE_SCANS_RECEIVED"  WHEN 16 THEN "LOCAL_TABLE_SCANS_SENT"  WHEN 17 THEN "RANGE_SCANS_RECEIVED"  WHEN 18 THEN "LOCAL_RANGE_SCANS_SENT"  WHEN 19 THEN "REMOTE_RANGE_SCANS_SENT"  WHEN 20 THEN "SCAN_BATCHES_RETURNED"  WHEN 21 THEN "SCAN_ROWS_RETURNED"  WHEN 22 THEN "PRUNED_RANGE_SCANS_RECEIVED"  WHEN 23 THEN "CONST_PRUNED_RANGE_SCANS_RECEIVED"  WHEN 24 THEN "LOCAL_READS"  WHEN 25 THEN "LOCAL_WRITES"  WHEN 26 THEN "LQHKEY_OVERLOAD"  WHEN 27 THEN "LQHKEY_OVERLOAD_TC"  WHEN 28 THEN "LQHKEY_OVERLOAD_READER"  WHEN 29 THEN "LQHKEY_OVERLOAD_NODE_PEER"  WHEN 30 THEN "LQHKEY_OVERLOAD_SUBSCRIBER"  WHEN 31 THEN "LQHSCAN_SLOWDOWNS"  ELSE "<unknown>"  END AS counter_name, val FROM `ndbinfo`.`ndb$counters` c LEFT JOIN `ndbinfo`.blocks b ON c.block_number = b.block_number','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.nodes
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`nodes` AS SELECT node_id, uptime, CASE status  WHEN 0 THEN "NOTHING"  WHEN 1 THEN "CMVMI"  WHEN 2 THEN "STARTING"  WHEN 3 THEN "STARTED"  WHEN 4 THEN "SINGLEUSER"  WHEN 5 THEN "STOPPING_1"  WHEN 6 THEN "STOPPING_2"  WHEN 7 THEN "STOPPING_3"  WHEN 8 THEN "STOPPING_4"  ELSE "<unknown>"  END AS status, start_phase, config_generation FROM `ndbinfo`.`ndb$nodes`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.memoryusage
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`memoryusage` AS SELECT node_id,  pool_name AS memory_type,  SUM(used*entry_size) AS used,  SUM(used) AS used_pages,  SUM(total*entry_size) AS total,  SUM(total) AS total_pages FROM `ndbinfo`.`ndb$pools` WHERE block_number IN (248, 254) AND   (pool_name = "Index memory" OR pool_name = "Data memory") GROUP BY node_id, memory_type','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.diskpagebuffer
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`diskpagebuffer` AS SELECT node_id, block_instance, pages_written, pages_written_lcp, pages_read, log_waits, page_requests_direct_return, page_requests_wait_queue, page_requests_wait_io FROM `ndbinfo`.`ndb$diskpagebuffer`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.diskpagebuffer
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`diskpagebuffer` AS SELECT node_id, block_instance, pages_written, pages_written_lcp, pages_read, log_waits, page_requests_direct_return, page_requests_wait_queue, page_requests_wait_io FROM `ndbinfo`.`ndb$diskpagebuffer`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.threadblocks
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`threadblocks` AS SELECT t.node_id, t.thr_no, b.block_name, t.block_instance FROM `ndbinfo`.`ndb$threadblocks` t LEFT JOIN `ndbinfo`.blocks b ON t.block_number = b.block_number','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.threadstat
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`threadstat` AS SELECT * from `ndbinfo`.`ndb$threadstat`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.disk_write_speed_base
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`disk_write_speed_base` AS SELECT * from `ndbinfo`.`ndb$disk_write_speed_base`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.disk_write_speed_aggregate
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`disk_write_speed_aggregate` AS SELECT * from `ndbinfo`.`ndb$disk_write_speed_aggregate`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.cluster_transactions
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`cluster_transactions` AS SELECT t.node_id, t.block_instance, t.transid0 + (t.transid1 << 32) as transid, s.state_friendly_name as state,  t.c_ops as count_operations,  t.outstanding as outstanding_operations,  t.timer as inactive_seconds,  (t.apiref & 65535) as client_node_id,  (t.apiref >> 16) as client_block_ref FROM `ndbinfo`.`ndb$transactions` t LEFT JOIN `ndbinfo`.`ndb$dbtc_apiconnect_state` s        ON s.state_int_value = t.state','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.server_transactions
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`server_transactions` AS SELECT map.mysql_connection_id, t.*FROM information_schema.ndb_transid_mysql_connection_map map JOIN `ndbinfo`.cluster_transactions t   ON (map.ndb_transid >> 32) = (t.transid >> 32)','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.cluster_operations
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`cluster_operations` AS SELECT o.node_id, o.block_instance, o.transid0 + (o.transid1 << 32) as transid, case o.op  when 1 then "READ" when 2 then "READ-SH" when 3 then "READ-EX" when 4 then "INSERT" when 5 then "UPDATE" when 6 then "DELETE" when 7 then "WRITE" when 8 then "UNLOCK" when 9 then "REFRESH" when 257 then "SCAN" when 258 then "SCAN-SH" when 259 then "SCAN-EX" ELSE "<unknown>" END as operation_type,  s.state_friendly_name as state,  o.tableid,  o.fragmentid,  (o.apiref & 65535) as client_node_id,  (o.apiref >> 16) as client_block_ref,  (o.tcref & 65535) as tc_node_id,  ((o.tcref >> 16) & 511) as tc_block_no,  ((o.tcref >> (16 + 9)) & 127) as tc_block_instance FROM `ndbinfo`.`ndb$operations` o LEFT JOIN `ndbinfo`.`ndb$dblqh_tcconnect_state` s        ON s.state_int_value = o.state','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.server_operations
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`server_operations` AS SELECT map.mysql_connection_id, o.* FROM `ndbinfo`.cluster_operations o JOIN information_schema.ndb_transid_mysql_connection_map map  ON (map.ndb_transid >> 32) = (o.transid >> 32)','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.membership
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`membership` AS SELECT node_id, group_id, left_node, right_node, president, successor, dynamic_id & 0xFFFF AS succession_order, dynamic_id >> 16 AS Conf_HB_order, arbitrator, arb_ticket, CASE arb_state  WHEN 0 THEN "ARBIT_NULL"  WHEN 1 THEN "ARBIT_INIT"  WHEN 2 THEN "ARBIT_FIND"  WHEN 3 THEN "ARBIT_PREP1"  WHEN 4 THEN "ARBIT_PREP2"  WHEN 5 THEN "ARBIT_START"  WHEN 6 THEN "ARBIT_RUN"  WHEN 7 THEN "ARBIT_CHOOSE"  WHEN 8 THEN "ARBIT_CRASH"  ELSE "UNKNOWN" END AS arb_state, CASE arb_connected  WHEN 1 THEN "Yes"  ELSE "No" END AS arb_connected, conn_rank1_arbs AS connected_rank1_arbs, conn_rank2_arbs AS connected_rank2_arbs FROM `ndbinfo`.`ndb$membership`','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.arbitrator_validity_detail
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`arbitrator_validity_detail` AS SELECT node_id, arbitrator, arb_ticket, CASE arb_connected  WHEN 1 THEN "Yes"  ELSE "No" END AS arb_connected, CASE arb_state  WHEN 0 THEN "ARBIT_NULL"  WHEN 1 THEN "ARBIT_INIT"  WHEN 2 THEN "ARBIT_FIND"  WHEN 3 THEN "ARBIT_PREP1"  WHEN 4 THEN "ARBIT_PREP2"  WHEN 5 THEN "ARBIT_START"  WHEN 6 THEN "ARBIT_RUN"  WHEN 7 THEN "ARBIT_CHOOSE"  WHEN 8 THEN "ARBIT_CRASH"  ELSE "UNKNOWN" END AS arb_state FROM `ndbinfo`.`ndb$membership` ORDER BY arbitrator, arb_connected DESC','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.arbitrator_validity_summary
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`arbitrator_validity_summary` AS SELECT arbitrator, arb_ticket, CASE arb_connected  WHEN 1 THEN "Yes"  ELSE "No" END AS arb_connected, count(*) as consensus_count FROM `ndbinfo`.`ndb$membership` GROUP BY arbitrator, arb_ticket, arb_connected','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.memory_per_fragment
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`memory_per_fragment` AS SELECT name.fq_name, parent_name.fq_name AS parent_fq_name,types.type_name AS type, table_id, node_id, block_instance, fragment_num, fixed_elem_count, fixed_elem_size_bytes, fixed_elem_alloc_bytes, fixed_elem_free_bytes,  FLOOR(fixed_elem_free_bytes/fixed_elem_size_bytes) AS fixed_elem_free_count, var_elem_count, var_elem_alloc_bytes, var_elem_free_bytes, hash_index_alloc_bytes FROM `ndbinfo`.`ndb$frag_mem_use` AS space JOIN `ndbinfo`.`ndb$dict_obj_info` AS name ON name.id=space.table_id AND name.type<=6 JOIN `ndbinfo`.dict_obj_types AS types ON name.type=types.type_id LEFT JOIN `ndbinfo`.`ndb$dict_obj_info` AS parent_name ON name.parent_obj_id=parent_name.id AND name.parent_obj_type=parent_name.type','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# ndbinfo.operations_per_fragment
SET @str=IF(@have_ndbinfo,'CREATE OR REPLACE DEFINER=`root`@`localhost` SQL SECURITY INVOKER VIEW `ndbinfo`.`operations_per_fragment` AS SELECT name.fq_name, parent_name.fq_name AS parent_fq_name, types.type_name AS type, table_id, node_id, block_instance, fragment_num, tot_key_reads, tot_key_inserts, tot_key_updates, tot_key_writes, tot_key_deletes, tot_key_refs, tot_key_attrinfo_bytes,tot_key_keyinfo_bytes, tot_key_prog_bytes, tot_key_inst_exec, tot_key_bytes_returned, tot_frag_scans, tot_scan_rows_examined, tot_scan_rows_returned, tot_scan_bytes_returned, tot_scan_prog_bytes, tot_scan_bound_bytes, tot_scan_inst_exec, tot_qd_frag_scans, conc_frag_scans,conc_qd_plain_frag_scans+conc_qd_tup_frag_scans AS conc_qd_frag_scans, tot_commits FROM ndbinfo.ndb$frag_operations AS ops JOIN ndbinfo.ndb$dict_obj_info AS name ON name.id=ops.table_id AND name.type<=6 JOIN ndbinfo.dict_obj_types AS types ON name.type=types.type_id LEFT JOIN ndbinfo.ndb$dict_obj_info AS parent_name ON name.parent_obj_id=parent_name.id AND name.parent_obj_type=parent_name.type','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

# Finally turn off offline mode
SET @str=IF(@have_ndbinfo,'SET @@global.ndbinfo_offline=FALSE','SET @dummy = 0');
PREPARE stmt FROM @str;
EXECUTE stmt;
DROP PREPARE stmt;

