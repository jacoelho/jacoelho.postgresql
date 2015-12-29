# jacoelho.postgresql

### Description

Ansible role to manage postgresql servers, supports:

    - versions 9.1, 9.2, 9.3, 9.4
    - multiple sanity checks
    - basic extensions
    - replication

### How to use

Install lookup plugin by adding the path to `tests/lookup_plugins` to your ansible.cfg file

```
[default]
lookup_plugins = jacoelho.postgresql/tests/lookup_plugins
```


#### Replication (master):
```yaml
postgresql_replication: true
postgresql_replication_role: master

postgresql_users_replication:
  - user: replication
    password: "password"
    connections:
      - database: replication
        type: host
        address: <slave ip>/32
        auth: md5
```

#### Replication (slave):
```yaml
postgresql_replication: true
postgresql_replication_role: slave
postgresql_replication_master_ip: <master server ip>
```

### SSL:
```yaml
postgresql_cfg_ssl: "on"
postgresql_cfg_ssl_key_file: /path/to/file
postgresql_cfg_ssl_cert_file: /path/to/file
postgresql_cfg_ssl_ca_file: /path/to/file
postgresql_ssl:
  key: |
    contents
  cert: |
    contents
  ca: |
    contents
```

### Users:
```yaml
postgresql_users:
  - user: username
    roles:
      - login
    databases:
      - database: database01
        priv: ALL
      - database: database02
        priv: SELECT
        priv_objs: ALL_IN_SCHEMA
        priv_type: table
    connections:
      - database: all
        type: hostssl
        address: 0.0.0.0/0
        auth: cert clientcert=1 map=cn
      - database: database02
        type: local
        auth: trust
```

### Databases:
```yaml
postgresql_databases:
    - database: database01
      owner: "postgres"
    - database: database02
      owner: "postgres"
```


### TODO

- [ ] improve config override
- [ ] support more extensions
- [ ] privilegies
- [ ] better test coverage

### Build Status

![Build Status](https://travis-ci.org/jacoelho/jacoelho.postgresql.svg?branch=master)
