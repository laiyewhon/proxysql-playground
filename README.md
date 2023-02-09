# Database Sharding

```shell
# access proxysql
docker exec -ti proxysql-playground-proxysql-1 mysql -u admin -padmin -h proxysql -P6032 --prompt 'ProxySQL Admin> '

# mysql shard 1
docker exec -ti proxysql-playground-proxysql-1 mysql -u ashard -p -h mysql-shard-001

# mysql shard 2
docker exec -ti proxysql-playground-proxysql-1 mysql -u ashard -p -h mysql-shard-002

# access mysql through proxysql
docker exec -ti proxysql-playground-proxysql-1 mysql -u test -p -h proxysql test
```

## Proxysql Config

```&sql
insert into mysql_servers(hostgroup_id, hostname, port) values (1, 'mysql-shard-001', 3306);
insert into mysql_servers(hostgroup_id, hostname, port) values (1, 'mysql-shard-002', 3306);
LOAD MYSQL SERVERS TO RUNTIME;
SAVE MYSQL SERVERS TO DISK;

# password will be in plaintext when its inserted and hashed after being saved to disk
insert into mysql_users(username, password, default_hostgroup) values ('test', 'abc123', 1);
LOAD MYSQL USERS TO RUNTIME;
SAVE MYSQL USERS FROM RUNTIME;

UPDATE global_variables SET variable_value='monitor' WHERE variable_name='mysql-monitor_username';
UPDATE global_variables SET variable_value='monitor123' WHERE variable_name='mysql-monitor_password';
LOAD MYSQL VARIABLES TO RUNTIME;
SAVE MYSQL VARIABLES TO DISK;
```
