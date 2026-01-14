*linux.txt*  Linux/Unix Commands Reference

==============================================================================
CONTENTS                                                        *linux-contents*

1. File Operations ....................... |linux-files|
2. Directory Navigation .................. |linux-navigation|
3. File Permissions ...................... |linux-permissions|
4. Text Processing ....................... |linux-text|
5. Search and Find ....................... |linux-search|
6. Process Management .................... |linux-processes|
7. System Information .................... |linux-system|
8. Network ............................... |linux-network|
9. Archives and Compression .............. |linux-archives|
10. Disk Usage ........................... |linux-disk|
11. File Transfer ........................ |linux-transfer|
12. Text Editors ......................... |linux-editors|
13. Package Management ................... |linux-packages|
14. User Management ...................... |linux-users|
15. Environment Variables ................ |linux-env|
16. Redirection and Pipes ................ |linux-redirect|
17. Job Control .......................... |linux-jobs|
18. Common Patterns ...................... |linux-patterns|

==============================================================================
1. FILE OPERATIONS                                              *linux-files*

List files~                                              *linux-files-list*
>
    ls                  # List files
    ls -l               # Long format (permissions, size, date)
    ls -la              # Include hidden files
    ls -lh              # Human-readable sizes
    ls -ltr             # Sort by time, reverse (oldest first)
    ls -R               # Recursive
<

Copy~                                                    *linux-files-copy*
>
    cp source dest              # Copy file
    cp -r source/ dest/         # Copy directory recursively
    cp -i source dest           # Interactive (prompt before overwrite)
    cp -v source dest           # Verbose
<

Move/Rename~                                             *linux-files-move*
>
    mv old new                  # Rename
    mv file dir/                # Move to directory
    mv -i old new               # Interactive
<

Remove~                                                *linux-files-remove*
>
    rm file                     # Remove file
    rm -r dir/                  # Remove directory recursively
    rm -f file                  # Force (no prompt)
    rm -rf dir/                 # Force remove directory
    rm -i file                  # Interactive
<

Create~                                                *linux-files-create*
>
    touch file.txt              # Create empty file / update timestamp
    mkdir dir                   # Create directory
    mkdir -p path/to/dir        # Create parent directories
<

Links~                                                  *linux-files-links*
>
    ln source link              # Hard link
    ln -s source link           # Symbolic (soft) link
    readlink -f link            # Show full path of link
<

File info~                                              *linux-files-info*
>
    file filename               # Determine file type
    stat filename               # Detailed file info
    du -h filename              # File size
    wc filename                 # Count lines, words, bytes
    wc -l filename              # Count lines only
<

==============================================================================
2. DIRECTORY NAVIGATION                                   *linux-navigation*

Navigation commands~                               *linux-navigation-commands*
>
    cd /path/to/dir     # Change directory
    cd ~                # Go to home directory
    cd -                # Go to previous directory
    cd ..               # Go up one level
    cd ../..            # Go up two levels

    pwd                 # Print working directory
    pushd /path         # Push directory to stack and cd
    popd                # Pop directory from stack and cd
    dirs                # Show directory stack
<

==============================================================================
3. FILE PERMISSIONS                                       *linux-permissions*

Permission format~                                *linux-permissions-format*
>
    # Permission format: rwxrwxrwx (owner, group, others)
    # r=4, w=2, x=1
<

Change permissions~                               *linux-permissions-chmod*
>
    chmod 755 file              # rwxr-xr-x
    chmod 644 file              # rw-r--r--
    chmod +x file               # Add execute
    chmod -w file               # Remove write
    chmod u+x file              # Add execute for owner
    chmod g-w file              # Remove write for group
    chmod o=r file              # Set others to read only
    chmod -R 755 dir/           # Recursive
<

Common permissions~                               *linux-permissions-common*
>
    chmod 777 file              # rwxrwxrwx (all permissions, not recommended)
    chmod 755 file              # rwxr-xr-x (executable, standard for scripts)
    chmod 644 file              # rw-r--r-- (standard for files)
    chmod 600 file              # rw------- (private file)
<

Change ownership~                                  *linux-permissions-chown*
>
    chown user file             # Change owner
    chown user:group file       # Change owner and group
    chown -R user dir/          # Recursive
    chgrp group file            # Change group only
<

View permissions~                                  *linux-permissions-view*
>
    ls -l                       # Show permissions
    stat file                   # Detailed info
<

==============================================================================
4. TEXT PROCESSING                                              *linux-text*

View files~                                              *linux-text-view*
>
    cat file.txt                # Display entire file
    cat file1 file2             # Concatenate files
    cat -n file.txt             # Show line numbers
    head file.txt               # First 10 lines
    head -n 20 file.txt         # First 20 lines
    tail file.txt               # Last 10 lines
    tail -n 20 file.txt         # Last 20 lines
    tail -f file.txt            # Follow (watch for changes)
    less file.txt               # Page through file
    more file.txt               # Page through file (older)
<

Search in files~                                        *linux-text-search*
>
    grep "pattern" file.txt             # Search for pattern
    grep -i "pattern" file.txt          # Case insensitive
    grep -r "pattern" dir/              # Recursive search
    grep -n "pattern" file.txt          # Show line numbers
    grep -v "pattern" file.txt          # Invert match (exclude)
    grep -l "pattern" *.txt             # Show only filenames
    grep -c "pattern" file.txt          # Count matches
    grep -A 3 "pattern" file.txt        # Show 3 lines after
    grep -B 3 "pattern" file.txt        # Show 3 lines before
    grep -C 3 "pattern" file.txt        # Show 3 lines around
    grep -E "regex" file.txt            # Extended regex
    grep -o "pattern" file.txt          # Show only matched part
<

Cut and paste~                                            *linux-text-cut*
>
    cut -d',' -f1 file.csv              # Get first field (comma delimited)
    cut -d' ' -f2,3 file.txt            # Get fields 2 and 3
    cut -c1-10 file.txt                 # Get characters 1-10
    paste file1 file2                   # Merge lines side by side
<

Sort~                                                    *linux-text-sort*
>
    sort file.txt                       # Sort lines
    sort -r file.txt                    # Reverse sort
    sort -n file.txt                    # Numeric sort
    sort -k2 file.txt                   # Sort by 2nd field
    sort -u file.txt                    # Sort and remove duplicates
    sort -t',' -k2 file.csv             # Sort CSV by 2nd column
<

Unique~                                                 *linux-text-unique*
>
    uniq file.txt                       # Remove adjacent duplicates
    uniq -c file.txt                    # Count occurrences
    uniq -d file.txt                    # Show only duplicates
    sort file.txt | uniq                # Remove all duplicates
<

Replace~                                               *linux-text-replace*
>
    sed 's/old/new/' file.txt           # Replace first occurrence per line
    sed 's/old/new/g' file.txt          # Replace all occurrences
    sed -i 's/old/new/g' file.txt       # Replace in-place
    sed -n '5,10p' file.txt             # Print lines 5-10
    sed '5d' file.txt                   # Delete line 5
    sed '/pattern/d' file.txt           # Delete lines matching pattern
<

AWK~                                                      *linux-text-awk*
>
    awk '{print $1}' file.txt           # Print first field
    awk '{print $1, $3}' file.txt       # Print fields 1 and 3
    awk -F',' '{print $2}' file.csv     # CSV with comma delimiter
    awk '$3 > 100' file.txt             # Filter rows where field 3 > 100
    awk '{sum+=$1} END {print sum}'     # Sum first column
    awk 'NR==5' file.txt                # Print line 5
<

Column formatting~                                     *linux-text-column*
>
    column -t file.txt                  # Format into columns
    column -t -s',' file.csv            # Format CSV
<

TR (translate)~                                           *linux-text-tr*
>
    tr 'a-z' 'A-Z' < file.txt           # Convert to uppercase
    tr -d '0-9' < file.txt              # Delete digits
    tr -s ' ' < file.txt                # Squeeze repeated spaces
<

==============================================================================
5. SEARCH AND FIND                                            *linux-search*

Find files~                                            *linux-search-find*
>
    find . -name "*.txt"                # Find by name
    find . -iname "*.txt"               # Case insensitive
    find . -type f                      # Find files only
    find . -type d                      # Find directories only
    find . -size +10M                   # Files larger than 10MB
    find . -size -1M                    # Files smaller than 1MB
    find . -mtime -7                    # Modified in last 7 days
    find . -mtime +30                   # Modified more than 30 days ago
    find . -name "*.log" -delete        # Find and delete
    find . -name "*.txt" -exec cat {} \;    # Execute command on results
    find . -perm 644                    # Find by permission
    find . -user username               # Find by owner
<

Locate~                                              *linux-search-locate*
>
    locate filename                     # Find file by name
    locate -i filename                  # Case insensitive
    updatedb                            # Update locate database (run as root)
<

Which/Where~                                          *linux-search-which*
>
    which command                       # Show path to command
    whereis command                     # Show binary, source, manual locations
    type command                        # Show command type
<

==============================================================================
6. PROCESS MANAGEMENT                                      *linux-processes*

View processes~                                    *linux-processes-view*
>
    ps                          # Show your processes
    ps aux                      # Show all processes
    ps aux | grep name          # Find specific process
    top                         # Interactive process viewer
    htop                        # Better interactive viewer (if installed)
<

Kill processes~                                    *linux-processes-kill*
>
    kill PID                    # Terminate process
    kill -9 PID                 # Force kill
    killall name                # Kill by name
    pkill name                  # Kill by pattern
<

Background processes~                          *linux-processes-background*
>
    command &                   # Run in background
    nohup command &             # Run immune to hangup
    jobs                        # List background jobs
    fg                          # Bring to foreground
    bg                          # Resume in background
    disown                      # Remove from job table
<

Process priority~                              *linux-processes-priority*
>
    nice -n 10 command          # Run with priority (higher number = lower priority)
    renice -n 5 -p PID          # Change priority of running process
<

==============================================================================
7. SYSTEM INFORMATION                                         *linux-system*

System~                                                *linux-system-info*
>
    uname -a                    # All system info
    uname -r                    # Kernel version
    hostname                    # Computer name
    uptime                      # How long system has been running
    whoami                      # Current user
    id                          # User ID and group info
    w                           # Who is logged in
    last                        # Last logins
<

Hardware~                                          *linux-system-hardware*
>
    lscpu                       # CPU info
    lsmem                       # Memory info
    lsblk                       # Block devices (disks)
    lsusb                       # USB devices
    lspci                       # PCI devices
    free -h                     # Memory usage
    cat /proc/cpuinfo           # Detailed CPU info
    cat /proc/meminfo           # Detailed memory info
<

Distribution~                                        *linux-system-distro*
>
    cat /etc/os-release         # OS information
    lsb_release -a              # Distribution info (if available)
<

==============================================================================
8. NETWORK                                                    *linux-network*

Network info~                                        *linux-network-info*
>
    ip addr                     # Show IP addresses
    ip a                        # Short form
    ifconfig                    # Network interfaces (older)
    ip route                    # Show routing table
<

Network testing~                                     *linux-network-test*
>
    ping host                   # Test connectivity
    ping -c 4 host              # Ping 4 times
    traceroute host             # Show route to host
    nslookup domain             # DNS lookup
    dig domain                  # DNS lookup (detailed)
    host domain                 # Simple DNS lookup
<

Ports and connections~                              *linux-network-ports*
>
    netstat -tuln               # Show listening ports
    ss -tuln                    # Show listening ports (newer)
    lsof -i :8080               # Show what's using port 8080
    nc -zv host port            # Test if port is open
<

Download~                                         *linux-network-download*
>
    curl url                    # Fetch URL
    curl -O url                 # Save with original filename
    curl -o file url            # Save with custom filename
    curl -I url                 # Show headers only
    wget url                    # Download file
    wget -c url                 # Continue interrupted download
<

Network monitoring~                              *linux-network-monitor*
>
    iftop                       # Network bandwidth usage (if installed)
    nethogs                     # Per-process bandwidth (if installed)
<

==============================================================================
9. ARCHIVES AND COMPRESSION                                *linux-archives*

Tar~                                                  *linux-archives-tar*
>
    tar -czf archive.tar.gz dir/        # Create gzipped tar
    tar -xzf archive.tar.gz             # Extract gzipped tar
    tar -cjf archive.tar.bz2 dir/       # Create bzip2 tar
    tar -xjf archive.tar.bz2            # Extract bzip2 tar
    tar -tf archive.tar.gz              # List contents
    tar -xzf archive.tar.gz -C /path    # Extract to path
<

Zip~                                                  *linux-archives-zip*
>
    zip -r archive.zip dir/             # Create zip
    unzip archive.zip                   # Extract zip
    unzip -l archive.zip                # List contents
    unzip archive.zip -d /path          # Extract to path
<

Gzip~                                                *linux-archives-gzip*
>
    gzip file                           # Compress file (replaces original)
    gzip -k file                        # Keep original
    gunzip file.gz                      # Decompress
    gzip -c file > file.gz              # Compress to stdout
<

Bzip2~                                              *linux-archives-bzip2*
>
    bzip2 file                          # Compress
    bunzip2 file.bz2                    # Decompress
<

==============================================================================
10. DISK USAGE                                                  *linux-disk*

Disk space~                                            *linux-disk-space*
>
    df -h                       # Show disk usage (human-readable)
    df -i                       # Show inode usage
    du -h                       # Disk usage of current directory
    du -sh *                    # Summary of each item
    du -sh dir                  # Total size of directory
    du -h --max-depth=1         # Show one level deep
    ncdu                        # Interactive disk usage (if installed)
<

Disk partitions~                                  *linux-disk-partitions*
>
    lsblk                       # List block devices
    fdisk -l                    # List partitions (root required)
    mount                       # Show mounted filesystems
<

==============================================================================
11. FILE TRANSFER                                            *linux-transfer*

SCP (secure copy)~                                      *linux-transfer-scp*
>
    scp file user@host:/path            # Copy to remote
    scp user@host:/path/file .          # Copy from remote
    scp -r dir user@host:/path          # Copy directory
<

Rsync~                                                *linux-transfer-rsync*
>
    rsync -av source/ dest/             # Sync directories
    rsync -av source/ user@host:/dest/  # Sync to remote
    rsync -av --delete src/ dst/        # Delete extra files in dest
    rsync -av --progress src/ dst/      # Show progress
    rsync -avz src/ user@host:/dst/     # Compress during transfer
<

==============================================================================
12. TEXT EDITORS                                              *linux-editors*

Vim~                                                    *linux-editors-vim*
>
    vim file                    # Edit file
    vim +10 file                # Open at line 10
    vim -R file                 # Read-only mode
<

Nano~                                                  *linux-editors-nano*
>
    nano file                   # Edit file
    nano +10 file               # Open at line 10
<

Other~                                                *linux-editors-other*
>
    emacs file                  # Emacs editor
    vi file                     # Vi editor (original)
<

==============================================================================
13. PACKAGE MANAGEMENT                                       *linux-packages*

Debian/Ubuntu (apt)~                                 *linux-packages-apt*
>
    apt update                  # Update package list
    apt upgrade                 # Upgrade packages
    apt install package         # Install package
    apt remove package          # Remove package
    apt search package          # Search for package
    apt show package            # Show package info
<

RedHat/CentOS (yum)~                                 *linux-packages-yum*
>
    yum update                  # Update packages
    yum install package         # Install package
    yum remove package          # Remove package
    yum search package          # Search for package
<

Fedora (dnf)~                                        *linux-packages-dnf*
>
    dnf update                  # Update packages
    dnf install package         # Install package
    dnf remove package          # Remove package
<

Arch (pacman)~                                    *linux-packages-pacman*
>
    pacman -Syu                 # Update system
    pacman -S package           # Install package
    pacman -R package           # Remove package
    pacman -Ss package          # Search for package
<

macOS (Homebrew)~                                   *linux-packages-brew*
>
    brew update                 # Update Homebrew
    brew upgrade                # Upgrade packages
    brew install package        # Install package
    brew uninstall package      # Uninstall package
    brew search package         # Search for package
<

==============================================================================
14. USER MANAGEMENT                                             *linux-users*

Users~                                                  *linux-users-manage*
>
    useradd username            # Add user
    userdel username            # Delete user
    usermod -aG group user      # Add user to group
    passwd username             # Change password
    su username                 # Switch user
    su -                        # Switch to root
    sudo command                # Run as root
    sudo -i                     # Interactive root shell
    sudo -u user command        # Run as specific user
<

Groups~                                                 *linux-users-groups*
>
    groups                      # Show your groups
    groups username             # Show user's groups
    groupadd groupname          # Add group
    groupdel groupname          # Delete group
<

==============================================================================
15. ENVIRONMENT VARIABLES                                        *linux-env*

View variables~                                          *linux-env-view*
>
    env                         # List all environment variables
    printenv                    # List all environment variables
    echo $PATH                  # Show specific variable
    echo $HOME                  # Home directory
    echo $USER                  # Current user
<

Set variables~                                            *linux-env-set*
>
    export VAR=value            # Set for current session
    VAR=value command           # Set for single command
    unset VAR                   # Remove variable
<

Persistent variables~                                *linux-env-persistent*
>
    # Persistent variables (add to ~/.bashrc or ~/.zshrc)
    export PATH=$PATH:/new/path
<

==============================================================================
16. REDIRECTION AND PIPES                                    *linux-redirect*

Redirection~                                        *linux-redirect-output*
>
    command > file              # Redirect stdout to file (overwrite)
    command >> file             # Redirect stdout to file (append)
    command 2> file             # Redirect stderr to file
    command &> file             # Redirect both stdout and stderr
    command 2>&1                # Redirect stderr to stdout
    command < file              # Read input from file
    command <<EOF               # Here document
    text
    EOF
<

Pipes~                                                *linux-redirect-pipes*
>
    command1 | command2         # Pipe output to next command
    ls -l | grep ".txt"         # List and filter
    cat file | sort | uniq      # Chain commands
    ls -l | tee file.txt        # Show output and save to file
<

==============================================================================
17. JOB CONTROL                                                  *linux-jobs*

Job control~                                          *linux-jobs-control*
>
    command &                   # Run in background
    Ctrl+Z                      # Suspend current job
    jobs                        # List jobs
    fg %1                       # Bring job 1 to foreground
    bg %1                       # Resume job 1 in background
    kill %1                     # Kill job 1
    disown %1                   # Remove job from shell
<

Screen~                                                 *linux-jobs-screen*
>
    screen                      # Start new screen session
    screen -S name              # Start named session
    Ctrl+A D                    # Detach from screen
    screen -ls                  # List sessions
    screen -r                   # Reattach to session
    screen -r name              # Reattach to named session
<

Tmux~                                                     *linux-jobs-tmux*
>
    tmux                        # Start new tmux session
    tmux new -s name            # Start named session
    Ctrl+B D                    # Detach from tmux
    tmux ls                     # List sessions
    tmux attach                 # Attach to session
    tmux attach -t name         # Attach to named session
<

==============================================================================
18. COMMON PATTERNS                                          *linux-patterns*

Common patterns~                                      *linux-patterns-list*
>
    # Find and delete old files
    find /path -name "*.log" -mtime +30 -delete

    # Find large files
    find / -type f -size +100M -exec ls -lh {} \;

    # Count files in directory
    ls -1 | wc -l

    # Find and replace in multiple files
    find . -name "*.txt" -exec sed -i 's/old/new/g' {} \;

    # Check if command exists
    command -v git &> /dev/null && echo "git is installed"

    # Loop through files
    for file in *.txt; do
      echo "Processing $file"
      # commands
    done

    # Create backup with timestamp
    cp file.txt file.txt.$(date +%Y%m%d_%H%M%S)

    # Monitor log file
    tail -f /var/log/syslog

    # Find processes by name
    ps aux | grep process_name | grep -v grep

    # Kill all processes matching pattern
    pkill -f pattern

    # Create directory and cd into it
    mkdir new_dir && cd new_dir

    # Quick HTTP server (Python)
    python3 -m http.server 8000

    # Show largest directories
    du -h --max-depth=1 | sort -hr | head -10

    # Watch command output (update every 2 seconds)
    watch -n 2 'ls -l'

    # Get public IP address
    curl ifconfig.me
    curl ipinfo.io/ip

    # Compare directories
    diff -r dir1 dir2

    # Create symbolic link
    ln -s /path/to/original /path/to/link

    # Find broken symbolic links
    find . -type l ! -exec test -e {} \; -print

    # Show file without comments
    grep -v '^#' file.txt | grep -v '^$'

    # Extract specific column from CSV
    awk -F',' '{print $2}' file.csv

    # Count lines of code
    find . -name "*.js" -exec cat {} \; | wc -l

    # Batch rename files
    for f in *.txt; do mv "$f" "${f%.txt}.md"; done
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
