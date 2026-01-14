*ssh.txt*  SSH Reference

==============================================================================
CONTENTS                                                         *ssh-contents*

1. Basic Connection ...................... |ssh-connection|
2. SSH Keys .............................. |ssh-keys|
3. SSH Config ............................ |ssh-config|
4. File Transfer ......................... |ssh-transfer|
5. Tunneling ............................. |ssh-tunneling|
6. Agent Forwarding ...................... |ssh-agent|
7. Security .............................. |ssh-security|
8. Troubleshooting ....................... |ssh-troubleshooting|

==============================================================================
1. BASIC CONNECTION                                          *ssh-connection*

Connect to remote host~                              *ssh-connection-basic*
>
    # Basic connection
    ssh user@host

    # With port
    ssh -p 2222 user@host

    # With specific key
    ssh -i ~/.ssh/id_rsa user@host

    # Run command and exit
    ssh user@host 'ls -la'
    ssh user@host 'cd /var/www && git pull'

    # Interactive shell with command
    ssh -t user@host 'cd /var/www && bash'
<

Connection options~                                *ssh-connection-options*
>
    # Verbose output (debugging)
    ssh -v user@host      # Verbose
    ssh -vv user@host     # More verbose
    ssh -vvv user@host    # Most verbose

    # Without host key check (insecure, use with caution)
    ssh -o StrictHostKeyChecking=no user@host

    # Keep connection alive
    ssh -o ServerAliveInterval=60 user@host
<

==============================================================================
2. SSH KEYS                                                       *ssh-keys*

Generate SSH keys~                                        *ssh-keys-generate*
>
    # Generate SSH key pair
    ssh-keygen -t ed25519 -C "your_email@example.com"
    # or RSA (older, larger)
    ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

    # Generate with custom filename
    ssh-keygen -t ed25519 -f ~/.ssh/id_work -C "work@example.com"

    # Change passphrase
    ssh-keygen -p -f ~/.ssh/id_ed25519
<

View and manage keys~                                    *ssh-keys-manage*
>
    # Show public key
    cat ~/.ssh/id_ed25519.pub

    # Show fingerprint
    ssh-keygen -lf ~/.ssh/id_ed25519.pub

    # Copy public key to server
    ssh-copy-id user@host
    # or manually
    cat ~/.ssh/id_ed25519.pub | ssh user@host \
      "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

    # Test key authentication
    ssh -i ~/.ssh/id_ed25519 user@host
<

SSH agent~                                                 *ssh-keys-agent*
>
    # Add key to ssh-agent
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_ed25519

    # List keys in agent
    ssh-add -l

    # Remove all keys from agent
    ssh-add -D

    # Remove specific key
    ssh-add -d ~/.ssh/id_ed25519

    # Auto-start ssh-agent (add to ~/.bashrc or ~/.zshrc)
    if [ -z "$SSH_AUTH_SOCK" ]; then
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
    fi

    # macOS: Add key to keychain
    ssh-add --apple-use-keychain ~/.ssh/id_ed25519
<

==============================================================================
3. SSH CONFIG                                                   *ssh-config*

Configuration file: ~/.ssh/config~

Single host~                                           *ssh-config-single*
>
    Host myserver
        HostName 192.168.1.100
        User john
        Port 22
        IdentityFile ~/.ssh/id_ed25519

    # Now connect with: ssh myserver
<

Multiple hosts~                                       *ssh-config-multiple*
>
    # Wildcards
    Host *.example.com
        User admin
        IdentityFile ~/.ssh/id_work

    # GitHub
    Host github.com
        HostName github.com
        User git
        IdentityFile ~/.ssh/id_github
<

Jump server~                                             *ssh-config-jump*
>
    # Bastion/Jump server
    Host internal-server
        HostName 10.0.1.50
        User admin
        ProxyJump bastion

    Host bastion
        HostName bastion.example.com
        User admin
        IdentityFile ~/.ssh/id_bastion
<

Agent forwarding~                                    *ssh-config-forwarding*
>
    Host dev-server
        HostName dev.example.com
        User developer
        ForwardAgent yes
<

Keep alive~                                          *ssh-config-keepalive*
>
    Host *
        ServerAliveInterval 60
        ServerAliveCountMax 3
<

Multiple identities~                               *ssh-config-identities*
>
    Host work
        HostName work.example.com
        User jsmith
        IdentityFile ~/.ssh/id_work
        IdentitiesOnly yes

    Host personal
        HostName personal.example.com
        User john
        IdentityFile ~/.ssh/id_personal
        IdentitiesOnly yes
<

Other options~                                        *ssh-config-options*
>
    # Disable host key checking (insecure)
    Host trust-*
        StrictHostKeyChecking no
        UserKnownHostsFile /dev/null

    # Compression
    Host slow-connection
        HostName slow.example.com
        Compression yes

    # X11 Forwarding
    Host gui-server
        HostName gui.example.com
        ForwardX11 yes

    # Set permissions
    chmod 600 ~/.ssh/config
<

==============================================================================
4. FILE TRANSFER                                              *ssh-transfer*

SCP (Secure Copy)~                                         *ssh-transfer-scp*
>
    # Copy to remote
    scp file.txt user@host:/path/to/destination/
    scp -r directory/ user@host:/path/to/destination/

    # Copy from remote
    scp user@host:/path/to/file.txt .
    scp -r user@host:/path/to/directory/ .

    # Copy between two remotes
    scp user1@host1:/path/file.txt user2@host2:/path/

    # With specific port
    scp -P 2222 file.txt user@host:/path/

    # With specific key
    scp -i ~/.ssh/id_rsa file.txt user@host:/path/

    # Preserve permissions and timestamps
    scp -p file.txt user@host:/path/
<

SFTP~                                                     *ssh-transfer-sftp*
>
    # Interactive SFTP
    sftp user@host
    # SFTP commands:
    # ls, cd, pwd       - Navigate remote
    # lls, lcd, lpwd    - Navigate local
    # get file          - Download
    # put file          - Upload
    # mkdir, rmdir      - Create/remove directory
    # rm, rename        - File operations
    # exit, quit, bye   - Exit

    # SFTP session
    sftp user@host
    > get remote-file.txt
    > put local-file.txt
    > get -r remote-directory/
    > put -r local-directory/
    > exit

    # Batch SFTP
    sftp -b commands.txt user@host
<

Rsync over SSH~                                      *ssh-transfer-rsync*
>
    # Rsync (recommended for large transfers)
    rsync -avz file.txt user@host:/path/
    rsync -avz -e "ssh -p 2222" file.txt user@host:/path/

    # Sync directories
    rsync -avz --delete source/ user@host:/destination/

    # Show progress
    rsync -avz --progress source/ user@host:/destination/

    # Dry run
    rsync -avzn source/ user@host:/destination/
<

==============================================================================
5. TUNNELING                                                 *ssh-tunneling*

Local port forwarding~                            *ssh-tunneling-local*
>
    # Access remote service locally
    ssh -L local_port:remote_host:remote_port user@ssh_server

    # Example: Access remote database
    ssh -L 5432:localhost:5432 user@db-server
    # Now connect to localhost:5432 to access remote database

    # Example: Access internal web server
    ssh -L 8080:internal.example.com:80 user@gateway
    # Now open http://localhost:8080
<

Remote port forwarding~                          *ssh-tunneling-remote*
>
    # Expose local service to remote
    ssh -R remote_port:local_host:local_port user@ssh_server

    # Example: Share local web server
    ssh -R 8080:localhost:3000 user@remote-server
    # Remote users can access your local:3000 via remote:8080
<

Dynamic port forwarding~                        *ssh-tunneling-dynamic*
>
    # SOCKS proxy
    ssh -D 9090 user@server
    # Configure browser to use SOCKS5 proxy localhost:9090
<

Keep tunnel alive~                             *ssh-tunneling-background*
>
    # Keep tunnel alive in background
    ssh -fN -L 5432:localhost:5432 user@db-server
    # -f: Background
    # -N: No command execution

    # Multiple tunnels
    ssh -L 3306:localhost:3306 -L 5432:localhost:5432 user@server

    # Through bastion/jump server
    ssh -J bastion@gateway -L 5432:database:5432 user@internal-server
<

==============================================================================
6. AGENT FORWARDING                                             *ssh-agent*

Enable agent forwarding~                            *ssh-agent-enable*
>
    # Enable agent forwarding
    ssh -A user@host

    # Or in ~/.ssh/config
    Host server
        ForwardAgent yes

    # Chain connections with agent
    ssh -A user@server1
    # Then from server1:
    ssh user@server2

    # Add keys to agent
    ssh-add ~/.ssh/id_ed25519
    ssh-add -l  # List keys
<

Security warning~                                  *ssh-agent-security*
>
    # Agent forwarding can be risky on untrusted hosts
    # Consider using ProxyJump instead:
    ssh -J bastion user@internal-server
<

==============================================================================
7. SECURITY                                                   *ssh-security*

Server-side configuration~                         *ssh-security-server*
>
    # /etc/ssh/sshd_config

    # Disable password authentication
    PasswordAuthentication no

    # Disable root login
    PermitRootLogin no

    # Allow specific users
    AllowUsers john jane

    # Change default port
    Port 2222

    # Limit authentication attempts
    MaxAuthTries 3

    # Disconnect idle sessions
    ClientAliveInterval 300
    ClientAliveCountMax 2

    # Disable X11 forwarding
    X11Forwarding no

    # Use only key authentication
    PubkeyAuthentication yes
    PasswordAuthentication no
    ChallengeResponseAuthentication no

    # Restart SSH service after changes
    sudo systemctl restart sshd    # Linux
    sudo service ssh restart       # Ubuntu/Debian
<

Client-side security~                              *ssh-security-client*
>
    # Set correct permissions
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_ed25519
    chmod 644 ~/.ssh/id_ed25519.pub
    chmod 600 ~/.ssh/config
    chmod 600 ~/.ssh/authorized_keys

    # Use strong passphrases
    ssh-keygen -t ed25519 -C "user@example.com"

    # Different keys for different purposes
    ~/.ssh/id_work      # Work
    ~/.ssh/id_personal  # Personal
    ~/.ssh/id_github    # GitHub

    # Verify host key fingerprint
    ssh-keygen -lf /etc/ssh/ssh_host_ed25519_key.pub

    # Remove host from known_hosts
    ssh-keygen -R hostname

    # Fail2ban to prevent brute force
    sudo apt install fail2ban
<

==============================================================================
8. TROUBLESHOOTING                                     *ssh-troubleshooting*

Debug connection~                              *ssh-troubleshooting-debug*
>
    # Verbose connection
    ssh -vvv user@host

    # Test key authentication
    ssh -v -i ~/.ssh/id_ed25519 user@host

    # Check SSH service status
    sudo systemctl status sshd
    sudo service ssh status

    # View SSH logs
    tail -f /var/log/auth.log        # Ubuntu/Debian
    tail -f /var/log/secure          # CentOS/RHEL
    journalctl -u sshd -f            # systemd

    # Test from server
    ssh -T git@github.com

    # Check SSH agent
    echo $SSH_AUTH_SOCK
    ssh-add -l

    # Debug connection issues
    ssh -vvv user@host 2>&1 | tee ssh-debug.log
<

Fix permissions~                           *ssh-troubleshooting-permissions*
>
    chmod 700 ~/.ssh
    chmod 600 ~/.ssh/id_*
    chmod 644 ~/.ssh/*.pub
    chmod 600 ~/.ssh/authorized_keys
<

Connection hangs~                              *ssh-troubleshooting-hangs*
>
    # Connection hangs at "debug1: Expecting SSH2_MSG_KEX_ECDH_REPLY"
    # Add to ~/.ssh/config:
    Host *
        KexAlgorithms +diffie-hellman-group1-sha1
<

Too many authentication failures~             *ssh-troubleshooting-auth*
>
    # Add to ~/.ssh/config:
    Host problematic-server
        IdentitiesOnly yes
        IdentityFile ~/.ssh/specific_key
<

Agent failure~                                *ssh-troubleshooting-agent*
>
    # Agent admitted failure to sign
    ssh-add ~/.ssh/id_ed25519
<

Host key verification failed~               *ssh-troubleshooting-hostkey*
>
    # Remove old key:
    ssh-keygen -R hostname
    # Then reconnect
<

Timeout issues~                              *ssh-troubleshooting-timeout*
>
    # Add to ~/.ssh/config:
    Host *
        ServerAliveInterval 60
        ServerAliveCountMax 3
<

Common error messages~                        *ssh-troubleshooting-errors*
>
    # "Permission denied (publickey)"
    # - Key not added to authorized_keys
    # - Wrong permissions on .ssh directory
    # - SSH key not added to agent
    # - PasswordAuthentication disabled on server

    # "Connection refused"
    # - SSH service not running
    # - Wrong port number
    # - Firewall blocking connection

    # "Connection timed out"
    # - Host unreachable
    # - Firewall blocking
    # - Wrong IP/hostname

    # "Host key verification failed"
    # - Host key changed (potential MITM attack)
    # - Server was reinstalled
    # - Remove old key: ssh-keygen -R hostname
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
