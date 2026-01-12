# Redis Reference

Quick reference for Redis (in-memory data structure store). Use `/` to search in vim.

## Table of Contents

- [Installation](#installation)
- [Connection](#connection)
  - [redis-cli](#redis-cli)
  - [Client Libraries](#client-libraries)
- [Key Operations](#key-operations)
  - [Basic Commands](#basic-commands)
  - [Key Expiration](#key-expiration)
  - [Key Scanning](#key-scanning)
- [String Operations](#string-operations)
  - [GET / SET](#get--set)
  - [APPEND / STRLEN](#append--strlen)
  - [INCR / DECR](#incr--decr)
  - [GETRANGE / SETRANGE](#getrange--setrange)
  - [MGET / MSET](#mget--mset)
- [List Operations](#list-operations)
  - [PUSH / POP](#push--pop)
  - [RANGE](#range)
  - [INDEX / LEN](#index--len)
  - [TRIM](#trim)
- [Set Operations](#set-operations)
  - [ADD / REMOVE](#add--remove)
  - [Members](#members)
  - [Operations](#operations)
- [Sorted Set Operations](#sorted-set-operations)
  - [ADD / REMOVE](#add--remove-1)
  - [RANGE](#range-1)
  - [Score Operations](#score-operations)
- [Hash Operations](#hash-operations)
  - [SET / GET](#set--get)
  - [GETALL](#getall)
  - [INCR](#incr)
- [Transactions](#transactions)
- [Pub/Sub](#pubsub)
- [Persistence](#persistence)
- [Configuration](#configuration)

## Installation

Install Redis.

```bash
# macOS (Homebrew)
brew install redis
brew services start redis

# Ubuntu/Debian
sudo apt-get install redis-server
sudo systemctl start redis-server
sudo systemctl enable redis-server

# Docker
docker run --name redis -p 6379:6379 -d redis:7

# Verify installation
redis-cli ping
# PONG
```

## Connection

### redis-cli

Connect to Redis using CLI.

```bash
# Local connection (default: localhost:6379)
redis-cli

# Remote connection
redis-cli -h hostname -p 6379

# With password
redis-cli -h hostname -a password

# Connect to specific database (0-15)
redis-cli -n 0

# Execute command and exit
redis-cli SET mykey "Hello"
redis-cli GET mykey

# Monitor commands in real-time
redis-cli MONITOR

# Statistics
redis-cli INFO

# Watch key for changes
redis-cli WATCH mykey
```

### Client Libraries

```bash
# Node.js
npm install redis
npm install ioredis

# Python
pip install redis

# Ruby
gem install redis

# Java
maven: redis.clients:jedis

# PHP
pecl install redis
```

JavaScript (ioredis):

```javascript
const Redis = require("ioredis");
const redis = new Redis({
  host: "localhost",
  port: 6379,
  password: "password",
});

await redis.set("key", "value");
const value = await redis.get("key");
```

## Key Operations

### Basic Commands

```bash
# Set key
SET mykey "Hello"

# Get key
GET mykey
# "Hello"

# Check if key exists
EXISTS mykey
# (integer) 1

# Delete key
DEL mykey

# Delete multiple
DEL key1 key2 key3

# Type of key
TYPE mykey
# string

# Rename key
RENAME mykey newkey

# Rename (only if new key doesn't exist)
RENAMENX mykey newkey
```

### Key Expiration

```bash
# Set expiration (seconds)
EXPIRE mykey 3600           # 1 hour
SET mykey "value" EX 3600   # Set with expiration

# Set expiration (milliseconds)
PEXPIRE mykey 3600000
SET mykey "value" PX 3600000

# Set expiration at Unix timestamp
EXPIREAT mykey 1735689600

# Check TTL (time to live)
TTL mykey
# (integer) 3599

# Check PTTL (milliseconds)
PTTL mykey

# Remove expiration
PERSIST mykey

# Set with options
SET mykey "value" EX 3600 NX    # Only if doesn't exist
SET mykey "value" EX 3600 XX    # Only if exists
```

### Key Scanning

```bash
# Get all keys (avoid on production!)
KEYS *

# Pattern matching
KEYS user:*
KEYS user:???
KEYS user:[0-9]*

# Scan (iterator, safer)
SCAN 0                      # Start at cursor 0
SCAN 0 MATCH user:* COUNT 10

# Scan specific type
HSCAN myhash 0
SSCAN myset 0
ZSCAN myzset 0
```

## String Operations

### GET / SET

```bash
# Set
SET mykey "Hello"

# Get
GET mykey
# "Hello"

# Set multiple
MSET key1 "value1" key2 "value2" key3 "value3"

# Get multiple
MGET key1 key2 key3
# 1) "value1"
# 2) "value2"
# 3) "value3"

# Get and set
GETSET mykey "NewValue"
# "Hello"

# Set if not exists
SETNX mykey "value"
# (integer) 1 (success) or 0 (exists)
```

### APPEND / STRLEN

```bash
# Append to value
APPEND mykey " World"
# Returns length

# Get length
STRLEN mykey
# (integer) 11
```

### INCR / DECR

```bash
# Increment
SET counter 10
INCR counter
# (integer) 11

# Increment by amount
INCRBY counter 5
# (integer) 16

# Decrement
DECR counter
# (integer) 15

# Decrement by amount
DECRBY counter 3
# (integer) 12

# Increment float
INCRBYFLOAT counter 0.5
```

### GETRANGE / SETRANGE

```bash
# Get substring
GETRANGE mykey 0 4
# Returns first 5 characters

# Set substring
SETRANGE mykey 6 "Redis"
# Overwrites starting at index 6
```

### MGET / MSET

```bash
# Multiple get
MGET key1 key2 key3

# Multiple set
MSET key1 value1 key2 value2

# Multiple set if not exists
MSETNX key1 value1 key2 value2
# (integer) 1 if all set, 0 if any exist
```

## List Operations

```bash
# LPUSH - Add to left (head)
LPUSH mylist "World"
LPUSH mylist "Hello"
# List is now: ["Hello", "World"]

# RPUSH - Add to right (tail)
RPUSH mylist "!"
# List is now: ["Hello", "World", "!"]

# LPOP - Remove from left
LPOP mylist
# "Hello"

# RPOP - Remove from right
RPOP mylist
# "!"

# LLEN - Get length
LLEN mylist
# (integer) 1

# LRANGE - Get range
LRANGE mylist 0 -1
# 1) "World"

# LINDEX - Get element at index
LINDEX mylist 0
# "World"

# LSET - Set element at index
LSET mylist 0 "Redis"

# LTRIM - Keep range, delete rest
LTRIM mylist 0 1

# RPOPLPUSH - Pop from right, push to left of another
RPOPLPUSH source destination

# LINSERT - Insert before/after
LINSERT mylist BEFORE "World" "Hello"
LINSERT mylist AFTER "World" "!"

# LREM - Remove elements
LREM mylist 1 "World"    # Remove 1 occurrence
LREM mylist 0 "World"    # Remove all occurrences
```

## Set Operations

```bash
# SADD - Add member
SADD myset "Hello"
SADD myset "World" "Test"

# SREM - Remove member
SREM myset "Hello"

# SMEMBERS - Get all members
SMEMBERS myset
# 1) "World"
# 2) "Test"

# SCARD - Get cardinality (size)
SCARD myset
# (integer) 2

# SISMEMBER - Check membership
SISMEMBER myset "World"
# (integer) 1

# SRANDMEMBER - Get random member
SRANDMEMBER myset
SRANDMEMBER myset 2    # Get 2 random members

# SPOP - Remove and return random
SPOP myset

# Set operations
SUNION set1 set2        # Union
SINTER set1 set2        # Intersection
SDIFF set1 set2         # Difference

SUNIONSTORE dest set1 set2    # Union and store
SINTERSTORE dest set1 set2    # Intersection and store
SDIFFSTORE dest set1 set2     # Difference and store
```

## Sorted Set Operations

Sorted sets maintain elements with scores for ordering.

```bash
# ZADD - Add member with score
ZADD myzset 1 "One"
ZADD myzset 2 "Two" 3 "Three"

# ZREM - Remove member
ZREM myzset "One"

# ZCARD - Get cardinality
ZCARD myzset
# (integer) 2

# ZSCORE - Get score
ZSCORE myzset "Two"
# "2"

# ZRANK - Get rank (index)
ZRANK myzset "Two"      # 0-based, lowest score first
# (integer) 0

# ZREVRANK - Reverse rank
ZREVRANK myzset "Two"   # Highest score first

# ZRANGE - Get range by rank
ZRANGE myzset 0 -1                 # All members
ZRANGE myzset 0 -1 WITHSCORES      # With scores

# ZREVRANGE - Reverse range
ZREVRANGE myzset 0 -1

# ZRANGEBYSCORE - Get by score range
ZRANGEBYSCORE myzset 1 2
ZRANGEBYSCORE myzset 1 2 WITHSCORES
ZRANGEBYSCORE myzset -inf +inf     # All

# ZCOUNT - Count in score range
ZCOUNT myzset 1 2

# ZINCRBY - Increment score
ZINCRBY myzset 1 "Two"
# Now "Two" has score 3
```

## Hash Operations

Hashes store multiple field-value pairs.

```bash
# HSET - Set field
HSET myhash field1 "Hello"
HSET myhash field2 "World"

# HGET - Get field
HGET myhash field1
# "Hello"

# HMSET - Multiple set
HMSET myhash field1 "Hello" field2 "World"

# HMGET - Multiple get
HMGET myhash field1 field2

# HGETALL - Get all fields and values
HGETALL myhash
# 1) "field1"
# 2) "Hello"
# 3) "field2"
# 4) "World"

# HLEN - Get field count
HLEN myhash
# (integer) 2

# HEXISTS - Check if field exists
HEXISTS myhash field1
# (integer) 1

# HDEL - Delete field
HDEL myhash field1

# HKEYS - Get all field names
HKEYS myhash

# HVALS - Get all values
HVALS myhash

# HINCRBY - Increment field value
HINCRBY myhash counter 1

# HINCRBYFLOAT - Increment float
HINCRBYFLOAT myhash price 0.5

# HSETNX - Set if field doesn't exist
HSETNX myhash field1 "value"
```

## Transactions

```bash
# Begin transaction
MULTI
SET key1 "value1"
SET key2 "value2"
INCR counter
EXEC            # Execute all commands
# Or DISCARD to cancel

# Watch key for changes
WATCH mykey
MULTI
SET mykey "value"
EXEC
# Fails if mykey was modified between WATCH and EXEC

# UNWATCH
UNWATCH
```

JavaScript example:

```javascript
const pipe = redis.pipeline();
pipe.set("key1", "value1");
pipe.set("key2", "value2");
pipe.incr("counter");
await pipe.exec();
```

## Pub/Sub

```bash
# Subscribe to channel
SUBSCRIBE mychannel

# Publish message
PUBLISH mychannel "Hello"

# Pattern subscribe
PSUBSCRIBE news:*

# Unsubscribe
UNSUBSCRIBE mychannel

# List subscriptions
PUBSUB CHANNELS         # Active channels
PUBSUB NUMSUB channel1  # Subscribers per channel
```

JavaScript:

```javascript
const subscriber = redis.duplicate();
await subscriber.subscribe("mychannel", (message) => {
  console.log(message);
});

redis.publish("mychannel", "Hello");
```

## Persistence

```bash
# Save snapshot (blocking)
SAVE

# Save snapshot (non-blocking)
BGSAVE

# Get last save time
LASTSAVE

# AOF (Append-only file) rewrite
BGREWRITEAOF

# Configuration
CONFIG GET save
CONFIG SET save "900 1"    # Save if 1 change in 900s
```

## Configuration

```bash
# Get configuration
CONFIG GET maxmemory
CONFIG GET *

# Set configuration
CONFIG SET maxmemory 100mb
CONFIG SET maxmemory-policy allkeys-lru

# Memory policies
allkeys-lru           # Remove any key using LRU
volatile-lru          # Remove expiring keys using LRU
allkeys-random        # Remove any random key
volatile-random       # Remove expiring key randomly
volatile-ttl          # Remove with shortest TTL
noeviction            # Return error (default)

# Save configuration
CONFIG REWRITE

# Server info
INFO
INFO stats
INFO memory

# Flushdb
FLUSHDB               # Clear current database
FLUSHALL              # Clear all databases
```
