# jacoelho.postgresql

### Description

Ansible role to manage postgresql servers, supports:

    - versions 9.1, 9.2, 9.3, 9.4
    - multiple sanity checks
    - basic extensions
    - replication

### How to use

#### Replication (master):

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

#### Replication (slave):

postgresql_replication: true
postgresql_replication_role: slave
postgresql_replication_master_ip: <master server ip>

### SSL:
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

### Users:
postgresql_users:
  - user: username
    roles:
      - login
    databases:
      - database: database01
        priv: ALL
      - database: database02
        priv: ALL
    connections:
      - database: all
        type: hostssl
        address: 0.0.0.0/0
        auth: cert clientcert=1 map=cn
      - database: database02
        type: local
        auth: trust

### Databases:
postgresql_databases:
      - database: database01
        owner: "postgres"
      - database: database02
        owner: "postgres"



### TODO

- [ ] improve config override
- [ ] support more extensions
- [ ] privilegies
- [ ] better test coverage

### Build Status

![Build Status](https://travis-ci.org/jacoelho/jacoelho.postgresql.svg?branch=master)
