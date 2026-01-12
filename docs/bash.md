# Bash Reference

Quick reference for Bash shell scripting. Use `/` to search in vim.

## Table of Contents

- [Basics](#basics)
  - [Shebang](#shebang)
  - [Variables](#variables)
  - [Input/Output](#inputoutput)
  - [Comments](#comments)
- [Operators](#operators)
  - [Arithmetic](#arithmetic)
  - [String](#string)
  - [Comparison](#comparison)
  - [Logical](#logical)
- [Conditionals](#conditionals)
  - [if/else](#ifelse)
  - [case](#case)
  - [test/[[]]](#testbrackets)
- [Loops](#loops)
  - [for](#for)
  - [while](#while)
  - [until](#until)
  - [break/continue](#breakcontinue)
- [Functions](#functions)
  - [Define Function](#define-function)
  - [Parameters](#parameters)
  - [Return Values](#return-values)
  - [Local Variables](#local-variables)
- [Arrays](#arrays)
  - [Index Arrays](#index-arrays)
  - [Associative Arrays](#associative-arrays)
- [String Operations](#string-operations)
  - [Variable Expansion](#variable-expansion)
  - [String Manipulation](#string-manipulation)
  - [Parameter Expansion](#parameter-expansion)
- [Advanced](#advanced)
  - [Command Substitution](#command-substitution)
  - [Process Substitution](#process-substitution)
  - [Redirects](#redirects)
  - [Pipes](#pipes)
  - [File Descriptors](#file-descriptors)
- [Error Handling](#error-handling)
  - [Exit Codes](#exit-codes)
  - [Error Trapping](#error-trapping)
- [File Operations](#file-operations)
  - [Test Operators](#test-operators)
  - [File Manipulation](#file-manipulation)

## Basics

### Shebang

```bash
#!/bin/bash              # Standard bash shebang
#!/usr/bin/env bash      # Use bash from PATH (portable)

# Make executable
chmod +x script.sh

# Run script
./script.sh
bash script.sh
```

### Variables

```bash
# Assign variable (no spaces)
name="John"
age=30
message='Single quotes (literal)'
interpolated="Double quotes (${name})"

# Unset variable
unset name

# Read-only variable
readonly CONFIG_FILE="/etc/config"

# Export to child processes
export API_KEY="secret"

# All variables
set | head -20

# Environment variables
echo $HOME
echo $USER
echo $PWD
```

### Input/Output

```bash
# Print output
echo "Hello World"
echo -e "Line 1\nLine 2"      # Enable escape sequences
echo -n "No newline"          # No trailing newline

# Printf (formatted)
printf "Name: %s, Age: %d\n" "John" 30

# Read input
read name
read -p "Enter name: " name   # With prompt
read -s password              # Secret input
read -r line                  # Raw input (no escape)
read -a array                 # Read into array
```

### Comments

```bash
# Single line comment

: '
Multi-line comment
Block comment
'

# Here document
cat << EOF
Multi-line text
Can contain variables: $name
EOF

# Here document (no variable expansion)
cat << 'EOF'
No expansion of $variables
EOF
```

## Operators

### Arithmetic

```bash
# Arithmetic expansion
echo $((5 + 3))        # 8
echo $((10 - 4))       # 6
echo $((3 * 4))        # 12
echo $((10 / 3))       # 3 (integer)
echo $((10 % 3))       # 1 (modulo)
echo $((2 ** 8))       # 256 (exponent)

# Increment/Decrement
((counter++))
((counter--))
((counter += 5))
((counter -= 2))
((counter *= 3))

# Arithmetic in variables
x=5
((x = x + 3))
result=$((x + 10))
```

### String

```bash
# Concatenation (implicit)
name="John"
greeting="Hello $name"

# String length
${#name}                # 4

# Comparison
[[ "$str1" == "$str2" ]]
[[ "$str1" != "$str2" ]]
[[ "$str1" < "$str2" ]]
[[ "$str1" > "$str2" ]]
[[ -z "$str" ]]         # Empty string
[[ -n "$str" ]]         # Non-empty string
```

### Comparison

```bash
# Numeric (use (( )) or [ ])
[[ $a -eq $b ]]    # Equal
[[ $a -ne $b ]]    # Not equal
[[ $a -lt $b ]]    # Less than
[[ $a -le $b ]]    # Less than or equal
[[ $a -gt $b ]]    # Greater than
[[ $a -ge $b ]]    # Greater than or equal
```

### Logical

```bash
# AND
[[ $a -gt 0 && $b -lt 10 ]]
(( a > 0 && b < 10 ))

# OR
[[ $a -eq 1 || $a -eq 2 ]]

# NOT
[[ ! -f "$file" ]]

# Group conditions
[[ ($a -gt 0 && $b -lt 10) || $c -eq 5 ]]
```

## Conditionals

### if/else

```bash
# Simple if
if [[ $age -ge 18 ]]; then
  echo "Adult"
fi

# if/else
if [[ $age -ge 18 ]]; then
  echo "Adult"
else
  echo "Minor"
fi

# if/elif/else
if [[ $age -lt 13 ]]; then
  echo "Child"
elif [[ $age -lt 18 ]]; then
  echo "Teen"
else
  echo "Adult"
fi

# One-liner
[[ $x -eq 1 ]] && echo "x is 1" || echo "x is not 1"

# One-liner with curly braces
{ [[ $x -eq 1 ]] && echo "yes"; } || echo "no"
```

### case

```bash
# Case statement
case "$fruit" in
  apple)
    echo "Apple"
    ;;
  banana|plantain)
    echo "Yellow fruit"
    ;;
  orange)
    echo "Orange"
    ;;
  *)
    echo "Unknown"
    ;;
esac

# With patterns
case "$filename" in
  *.txt)
    echo "Text file"
    ;;
  *.md)
    echo "Markdown file"
    ;;
  *)
    echo "Other file"
    ;;
esac
```

### test/[[]]

```bash
# Test command (POSIX)
[ -f "$file" ]
[ -d "$dir" ]
[ -e "$path" ]

# Double brackets (Bash, safer)
[[ -f "$file" ]]
[[ -d "$dir" ]]
[[ -e "$path" ]]

# Return status
if [ -f /etc/passwd ]; then
  echo "File exists"
fi

# Negate
[[ ! -f "$file" ]]

# Multiple conditions
[[ -f "$file" && -r "$file" ]]
```

## Loops

### for

```bash
# Loop over items
for item in apple banana cherry; do
  echo "$item"
done

# Loop over array
fruits=("apple" "banana" "cherry")
for fruit in "${fruits[@]}"; do
  echo "$fruit"
done

# Loop over range (Bash 4+)
for i in {1..5}; do
  echo "Count: $i"
done

# Loop with step
for i in {1..10..2}; do
  echo "$i"
done

# C-style loop
for ((i=1; i<=5; i++)); do
  echo "$i"
done

# Loop over glob pattern
for file in *.txt; do
  echo "Processing $file"
done

# Loop over command output
for line in $(cat file.txt); do
  echo "$line"
done
```

### while

```bash
# While loop
counter=1
while [[ $counter -le 5 ]]; do
  echo "Counter: $counter"
  ((counter++))
done

# While true (infinite)
while true; do
  read -p "Enter command: " cmd
  [[ "$cmd" == "quit" ]] && break
  eval "$cmd"
done

# While with read
while IFS= read -r line; do
  echo "Line: $line"
done < file.txt
```

### until

```bash
# Until loop (opposite of while)
counter=1
until [[ $counter -gt 5 ]]; do
  echo "Counter: $counter"
  ((counter++))
done
```

### break/continue

```bash
# Break (exit loop)
for i in {1..10}; do
  if [[ $i -eq 5 ]]; then
    break
  fi
  echo "$i"
done

# Continue (skip iteration)
for i in {1..5}; do
  if [[ $i -eq 3 ]]; then
    continue
  fi
  echo "$i"
done
```

## Functions

### Define Function

```bash
# Define function
function my_function() {
  echo "Hello from function"
}

# Alternative syntax
my_function() {
  echo "Hello from function"
}

# Call function
my_function
my_function arg1 arg2

# Function with return value
get_sum() {
  local result=$(($1 + $2))
  return $result
}

get_sum 5 3
echo "Sum: $?"
```

### Parameters

```bash
# Access parameters
my_func() {
  echo "First: $1"
  echo "Second: $2"
  echo "All: $@"
  echo "Count: $#"
}

my_func arg1 arg2 arg3

# "$@" vs "$*"
# "$@" - Each argument as separate word (correct)
# "$*" - All arguments as single word

# Loop parameters
process_files() {
  for file in "$@"; do
    echo "Processing: $file"
  done
}
```

### Return Values

```bash
# Capture stdout
result=$(my_function)
echo "$result"

# Capture exit code
my_function
exit_code=$?

# Return multiple values
get_user_info() {
  echo "John:30:john@example.com"
}

IFS=: read -r name age email < <(get_user_info)
```

### Local Variables

```bash
# Global variable
global_var="global"

my_function() {
  # Local variable (function scope)
  local local_var="local"
  global_var="modified"

  echo "Local: $local_var"
  echo "Global: $global_var"
}

my_function
echo "Global after: $global_var"    # "modified"
echo "Local after: $local_var"      # empty
```

## Arrays

### Index Arrays

```bash
# Declare array
arr=("apple" "banana" "cherry")
declare -a fruits=("apple" "banana")

# Access element
echo "${arr[0]}"        # apple
echo "${arr[1]}"        # banana
echo "${arr[-1]}"       # cherry (last element, Bash 4.3+)

# All elements
echo "${arr[@]}"        # All elements
echo "${arr[*]}"        # All elements as string

# Array length
echo "${#arr[@]}"       # 3

# Add element
arr+=("date")
arr[10]="grape"

# Delete element
unset arr[1]

# Loop array
for item in "${arr[@]}"; do
  echo "$item"
done

# Slice array (Bash 4+)
echo "${arr[@]:1:2}"    # From index 1, length 2
```

### Associative Arrays

```bash
# Declare associative array
declare -A person=([name]="John" [age]="30")
declare -A colors=()

# Add key-value
colors[red]="#FF0000"
colors[blue]="#0000FF"

# Access value
echo "${colors[red]}"   # #FF0000

# All keys
echo "${!colors[@]}"    # red blue

# All values
echo "${colors[@]}"     # #FF0000 #0000FF

# Key exists
[[ -v colors[red] ]] && echo "Key exists"

# Delete key
unset colors[red]

# Loop associative array
for key in "${!person[@]}"; do
  echo "$key: ${person[$key]}"
done
```

## String Operations

### Variable Expansion

```bash
# Basic expansion
name="John"
echo "$name"
echo "${name}"

# Default value
echo "${name:-default}"         # Use default if empty
echo "${name:=default}"         # Assign default if empty

# Alternate value
echo "${name:+value if set}"    # Use if not empty

# Remove suffix
filename="script.sh"
echo "${filename%.sh}"          # script

# Remove prefix
path="/home/user/file"
echo "${path#/home/}"           # user/file

# All matches
echo "${filename//./-}"         # Replace all . with -
```

### String Manipulation

```bash
# Length
str="hello"
echo "${#str}"          # 5

# Substring
echo "${str:1:3}"       # ell (from index 1, length 3)
echo "${str:1}"         # ello (from index 1 to end)

# Uppercase (Bash 4+)
echo "${str^^}"         # HELLO

# Lowercase (Bash 4+)
echo "${str,,}"         # hello

# Capitalize first letter
echo "${str^}"          # Hello
```

### Parameter Expansion

```bash
# Check if variable is set
[[ -z "$var" ]]         # True if empty
[[ -n "$var" ]]         # True if not empty

# Regex match
[[ "$email" =~ ^[a-z]+@[a-z]+\.[a-z]+$ ]] && echo "Valid email"

# Glob match
[[ "$filename" == *.txt ]] && echo "Text file"
```

## Advanced

### Command Substitution

```bash
# Subshell: $()
current_date=$(date "+%Y-%m-%d")
echo "Today: $current_date"

# Backticks (older style)
current_date=`date "+%Y-%m-%d"`

# Nested substitution
echo "Files: $(ls -1 $(pwd))"

# Multiple lines
output=$(
  echo "Line 1"
  echo "Line 2"
)
```

### Process Substitution

```bash
# Compare files
diff <(sort file1.txt) <(sort file2.txt)

# Multiple inputs to command
cat <(echo "Line 1") <(echo "Line 2")

# Capture output
while read -r line; do
  echo "Processed: $line"
done < <(grep "pattern" largefile.txt)
```

### Redirects

```bash
# Redirect stdout to file
echo "Hello" > file.txt           # Overwrite
echo "Hello" >> file.txt          # Append

# Redirect stderr
command 2> errors.log
command 2>> errors.log

# Redirect both
command &> output.log
command > output.log 2>&1

# Redirect to /dev/null (discard)
command > /dev/null 2>&1

# Input from file
wc -l < file.txt

# Here document
mysql << EOF
SELECT * FROM users;
EOF
```

### Pipes

```bash
# Pipe output to command
cat file.txt | grep "pattern"
ls -la | sort -k5 -rn

# Pipe with tee (see and save)
command | tee output.txt
command | tee -a output.txt      # Append

# Pipeline
cat data.json | jq '.items[]' | grep "active"
```

### File Descriptors

```bash
# Standard streams
# 0 = stdin, 1 = stdout, 2 = stderr

# Redirect specific descriptor
command 1> stdout.txt
command 2> stderr.txt

# Combine stderr to stdout
command 2>&1

# Close descriptor
command 3>&-

# Read from file descriptor
exec < file.txt
read line
```

## Error Handling

### Exit Codes

```bash
# Check exit code
command
echo "Exit code: $?"              # 0 = success, >0 = error

# && (run if previous succeeds)
cd /tmp && echo "Entered /tmp"

# || (run if previous fails)
cd /nonexistent || echo "Directory not found"

# Set exit code
exit 0
exit 1

# Conditional exit
[[ $? -ne 0 ]] && exit 1
```

### Error Trapping

```bash
# Set options
set -e                            # Exit on error
set -u                            # Error on undefined variable
set -o pipefail                   # Pipeline fails if any command fails
set -x                            # Debug mode (print commands)

# Trap errors
trap "echo 'Error on line $LINENO'" ERR

# Trap exit
trap "cleanup_function" EXIT

# Trap specific signal
trap "echo 'Caught interrupt'" INT

# Function called on error
error() {
  echo "Error: $1"
  exit 1
}

[[ -f "$file" ]] || error "File not found: $file"
```

## File Operations

### Test Operators

```bash
# File tests
[[ -f "$file" ]]                 # Regular file exists
[[ -d "$dir" ]]                  # Directory exists
[[ -e "$path" ]]                 # File or directory exists
[[ -r "$file" ]]                 # Readable
[[ -w "$file" ]]                 # Writable
[[ -x "$file" ]]                 # Executable
[[ -s "$file" ]]                 # File has size > 0
[[ -L "$link" ]]                 # Symbolic link
[[ -p "$fifo" ]]                 # Named pipe
[[ -z "$str" ]]                  # String is empty
[[ -n "$str" ]]                  # String is not empty

# Comparisons
[[ "$file1" -nt "$file2" ]]      # file1 newer than file2
[[ "$file1" -ot "$file2" ]]      # file1 older than file2
```

### File Manipulation

```bash
# Create file
touch newfile.txt
echo "content" > newfile.txt

# Create directory
mkdir -p /path/to/dir

# Copy
cp file.txt file-copy.txt
cp -r directory/ backup/

# Move/Rename
mv old-name.txt new-name.txt

# Delete
rm file.txt
rm -rf directory/

# Safe delete (interactive)
rm -i file.txt

# Create symbolic link
ln -s /path/to/file link-name

# Get file size
stat -f%z file.txt        # macOS
stat -c%s file.txt        # Linux

# Get file info
ls -lh file.txt
stat file.txt
```
