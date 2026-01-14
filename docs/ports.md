*ports.txt*  Common Port Numbers Reference

==============================================================================
CONTENTS                                                       *ports-contents*

1. Well-Known Ports (0-1023) ............ |ports-well-known|
2. Registered Ports (1024-49151) ........ |ports-registered|
3. Development & Common Services ........ |ports-development|
4. By Technology ........................ |ports-technology|
5. Security & Remote Access ............. |ports-security|
6. Email ................................ |ports-email|
7. File Transfer ........................ |ports-file-transfer|
8. Testing & Development ................ |ports-testing|
9. Checking Port Usage .................. |ports-checking|
10. Port Ranges ......................... |ports-ranges|

==============================================================================
1. WELL-KNOWN PORTS (0-1023)                              *ports-well-known*

Standard ports that require root/admin privileges~
>
    20      FTP Data Transfer
    21      FTP Control
    22      SSH (Secure Shell)
    23      Telnet
    25      SMTP (Simple Mail Transfer Protocol)
    53      DNS (Domain Name System)
    67/68   DHCP (Server/Client)
    69      TFTP (Trivial File Transfer Protocol)
    80      HTTP
    110     POP3 (Post Office Protocol v3)
    119     NNTP (Network News Transfer Protocol)
    123     NTP (Network Time Protocol)
    143     IMAP (Internet Message Access Protocol)
    161/162 SNMP (Simple Network Management Protocol)
    194     IRC (Internet Relay Chat)
    443     HTTPS (HTTP over SSL/TLS)
    465     SMTPS (SMTP over SSL)
    514     Syslog
    587     SMTP (Mail Submission)
    636     LDAPS (LDAP over SSL)
    993     IMAPS (IMAP over SSL)
    995     POP3S (POP3 over SSL)
<

==============================================================================
2. REGISTERED PORTS (1024-49151)                         *ports-registered*

Commonly used application ports~
>
    1433    Microsoft SQL Server
    1521    Oracle Database
    1723    PPTP (Point-to-Point Tunneling Protocol)
    3000    Node.js/React development server (common)
    3306    MySQL Database
    3389    RDP (Remote Desktop Protocol)
    5000    Flask development server (common)
    5432    PostgreSQL Database
    5672    AMQP (RabbitMQ)
    5900    VNC (Virtual Network Computing)
    6379    Redis
    8000    HTTP Alternate (Django development, common)
    8080    HTTP Proxy/Alternate
    8443    HTTPS Alternate
    8888    HTTP Alternate (Jupyter Notebook, common)
    9200    Elasticsearch
    9300    Elasticsearch (Node communication)
    27017   MongoDB
<

==============================================================================
3. DEVELOPMENT & COMMON SERVICES                         *ports-development*

Web development~                                   *ports-development-web*
>
    3000    Node.js/React dev server
    3001    Alternative dev server
    4200    Angular dev server
    5000    Flask dev server
    5173    Vite dev server
    8000    Django dev server
    8080    HTTP proxy/Tomcat/alternate
    8888    Jupyter Notebook
<

Databases~                                          *ports-development-db*
>
    3306    MySQL/MariaDB
    5432    PostgreSQL
    6379    Redis
    27017   MongoDB
    28015   RethinkDB (client driver)
    29015   RethinkDB (cluster)
<

Message queues~                                 *ports-development-queue*
>
    4369    Erlang Port Mapper (RabbitMQ)
    5672    AMQP (RabbitMQ)
    15672   RabbitMQ Management
    9092    Kafka
<

Search~                                          *ports-development-search*
>
    9200    Elasticsearch HTTP
    9300    Elasticsearch Transport
<

Monitoring & logging~                         *ports-development-monitoring*
>
    3000    Grafana
    9090    Prometheus
    5601    Kibana
    4317    OpenTelemetry
<

Containers & orchestration~               *ports-development-containers*
>
    2375    Docker (unencrypted)
    2376    Docker (encrypted)
    2379    etcd client
    2380    etcd peer
    6443    Kubernetes API server
    10250   Kubelet API
<

Version control~                                 *ports-development-vcs*
>
    9418    Git protocol
    3000    Gitea
    8080    GitLab (HTTP)
<

CI/CD~                                            *ports-development-cicd*
>
    8080    Jenkins
    9000    SonarQube
<

Caching~                                        *ports-development-cache*
>
    11211   Memcached
<

Proxies & load balancers~                     *ports-development-proxy*
>
    80      Nginx/Apache
    443     Nginx/Apache (HTTPS)
    1080    SOCKS proxy
    3128    Squid proxy
    8080    HAProxy
<

Gaming~                                          *ports-development-gaming*
>
    25565   Minecraft
    27015   Counter-Strike
<

==============================================================================
4. BY TECHNOLOGY                                         *ports-technology*

JavaScript/Node.js~                                    *ports-tech-javascript*
>
    3000    Express/Next.js/CRA default
    3001    Alternative dev server
    5173    Vite
    4200    Angular CLI
    8080    Webpack dev server
<

Python~                                                    *ports-tech-python*
>
    5000    Flask
    8000    Django
    8888    Jupyter
    6006    TensorBoard
<

Ruby~                                                        *ports-tech-ruby*
>
    3000    Rails server
    4567    Sinatra
<

Go~                                                            *ports-tech-go*
>
    8080    Common Go HTTP server
<

Java~                                                        *ports-tech-java*
>
    8080    Tomcat
    8009    Tomcat AJP
    9990    WildFly management
<

PHP~                                                          *ports-tech-php*
>
    8000    PHP built-in server
    9000    PHP-FPM
<

Databases~                                                 *ports-tech-database*
>
    3306    MySQL
    5432    PostgreSQL
    1433    MS SQL Server
    1521    Oracle
    27017   MongoDB
    6379    Redis
    5984    CouchDB
    7000    Cassandra (inter-node)
    9042    Cassandra (native transport)
    7474    Neo4j HTTP
    7687    Neo4j Bolt
<

==============================================================================
5. SECURITY & REMOTE ACCESS                                *ports-security*

Remote access protocols~                            *ports-security-remote*
>
    22      SSH
    3389    RDP (Windows Remote Desktop)
    5900    VNC
    5800    VNC over HTTP
<

==============================================================================
6. EMAIL                                                         *ports-email*

Email protocols~                                          *ports-email-protocols*
>
    25      SMTP
    110     POP3
    143     IMAP
    465     SMTPS
    587     SMTP (submission)
    993     IMAPS
    995     POP3S
<

==============================================================================
7. FILE TRANSFER                                           *ports-file-transfer*

File transfer protocols~                           *ports-file-transfer-protocols*
>
    20      FTP Data
    21      FTP Control
    22      SFTP (over SSH)
    69      TFTP
    445     SMB (Windows file sharing)
    2049    NFS
<

==============================================================================
8. TESTING & DEVELOPMENT                                     *ports-testing*

Testing and development tools~                         *ports-testing-tools*
>
    1080    SOCKS proxy
    3000    Mock server / Dev server
    4444    Selenium
    8080    Test server
    8888    Test server
    9229    Node.js debugging (--inspect)
<

==============================================================================
9. CHECKING PORT USAGE                                       *ports-checking*

Linux/Mac commands~                                    *ports-checking-unix*
>
    # What's using port 8080
    lsof -i :8080

    # Is port 8080 listening
    netstat -tuln | grep 8080
    ss -tuln | grep 8080       # Newer alternative

    # All listening ports
    sudo lsof -i -P -n | grep LISTEN

    # Test if port is open
    nc -zv localhost 8080
    telnet localhost 8080
    curl localhost:8080

    # Kill process on port
    lsof -ti:8080 | xargs kill
    # or
    kill $(lsof -t -i:8080)
<

Windows commands~                                   *ports-checking-windows*
>
    # Check port usage
    netstat -ano | findstr :8080

    # Get process ID
    Get-Process -Id (Get-NetTCPConnection -LocalPort 8080).OwningProcess
<

==============================================================================
10. PORT RANGES                                                *ports-ranges*

Standard port ranges~                                   *ports-ranges-standard*
>
    0-1023      Well-known ports (require root/admin)
    1024-49151  Registered ports
    49152-65535 Dynamic/private ports (ephemeral)
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
