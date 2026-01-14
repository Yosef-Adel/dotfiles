*redis.txt*  Redis Reference

==============================================================================
CONTENTS                                                      *redis-contents*

1. Installation .......................... |redis-install|
2. Connection ............................ |redis-connection|
3. Key Operations ........................ |redis-keys|
4. String Operations ..................... |redis-strings|
5. List Operations ....................... |redis-lists|
6. Set Operations ........................ |redis-sets|
7. Sorted Set Operations ................. |redis-sorted-sets|
8. Hash Operations ....................... |redis-hashes|
9. Transactions .......................... |redis-transactions|
10. Pub/Sub .............................. |redis-pubsub|
11. Persistence .......................... |redis-persistence|
12. Configuration ........................ |redis-config|

==============================================================================
1. INSTALLATION                                              *redis-install*

Install Redis~
>
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
<

==============================================================================
2. CONNECTION                                             *redis-connection*

redis-cli~                                                  *redis-cli*
>
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
<

Client libraries~                                    *redis-client-libraries*
>
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
<

JavaScript (ioredis)~                                  *redis-javascript*
>
    const Redis = require("ioredis");
    const redis = new Redis({
      host: "localhost",
      port: 6379,
      password: "password",
    });

    await redis.set("key", "value");
    const value = await redis.get("key");
<

==============================================================================
3. KEY OPERATIONS                                               *redis-keys*

Basic commands~                                        *redis-keys-basic*
>
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
<

Key expiration~                                      *redis-keys-expiration*
>
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
<

Key scanning~                                          *redis-keys-scanning*
>
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
<

==============================================================================
4. STRING OPERATIONS                                        *redis-strings*

GET / SET~                                              *redis-strings-get-set*
>
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
<

APPEND / STRLEN~                                      *redis-strings-append*
>
    # Append to value
    APPEND mykey " World"
    # Returns length

    # Get length
    STRLEN mykey
    # (integer) 11
<

INCR / DECR~                                          *redis-strings-incr*
>
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
<

GETRANGE / SETRANGE~                                  *redis-strings-range*
>
    # Get substring
    GETRANGE mykey 0 4
    # Returns first 5 characters

    # Set substring
    SETRANGE mykey 6 "Redis"
    # Overwrites starting at index 6
<

MGET / MSET~                                          *redis-strings-multi*
>
    # Multiple get
    MGET key1 key2 key3

    # Multiple set
    MSET key1 value1 key2 value2

    # Multiple set if not exists
    MSETNX key1 value1 key2 value2
    # (integer) 1 if all set, 0 if any exist
<

==============================================================================
5. LIST OPERATIONS                                            *redis-lists*

Push and pop~                                          *redis-lists-push-pop*
>
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

    # RPOPLPUSH - Pop from right, push to left of another
    RPOPLPUSH source destination
<

Range operations~                                      *redis-lists-range*
>
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
<

Insert and remove~                                    *redis-lists-insert*
>
    # LINSERT - Insert before/after
    LINSERT mylist BEFORE "World" "Hello"
    LINSERT mylist AFTER "World" "!"

    # LREM - Remove elements
    LREM mylist 1 "World"    # Remove 1 occurrence
    LREM mylist 0 "World"    # Remove all occurrences
<

==============================================================================
6. SET OPERATIONS                                              *redis-sets*

Add and remove~                                         *redis-sets-add-remove*
>
    # SADD - Add member
    SADD myset "Hello"
    SADD myset "World" "Test"

    # SREM - Remove member
    SREM myset "Hello"

    # SPOP - Remove and return random
    SPOP myset
<

Members~                                                *redis-sets-members*
>
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
<

Set operations~                                        *redis-sets-operations*
>
    # Union
    SUNION set1 set2

    # Intersection
    SINTER set1 set2

    # Difference
    SDIFF set1 set2

    # Union and store
    SUNIONSTORE dest set1 set2

    # Intersection and store
    SINTERSTORE dest set1 set2

    # Difference and store
    SDIFFSTORE dest set1 set2
<

==============================================================================
7. SORTED SET OPERATIONS                                *redis-sorted-sets*

Sorted sets maintain elements with scores for ordering~

Add and remove~                                      *redis-sorted-sets-add*
>
    # ZADD - Add member with score
    ZADD myzset 1 "One"
    ZADD myzset 2 "Two" 3 "Three"

    # ZREM - Remove member
    ZREM myzset "One"

    # ZCARD - Get cardinality
    ZCARD myzset
    # (integer) 2
<

Score operations~                                  *redis-sorted-sets-score*
>
    # ZSCORE - Get score
    ZSCORE myzset "Two"
    # "2"

    # ZRANK - Get rank (index)
    ZRANK myzset "Two"      # 0-based, lowest score first
    # (integer) 0

    # ZREVRANK - Reverse rank
    ZREVRANK myzset "Two"   # Highest score first

    # ZINCRBY - Increment score
    ZINCRBY myzset 1 "Two"
    # Now "Two" has score 3
<

Range operations~                                  *redis-sorted-sets-range*
>
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
<

==============================================================================
8. HASH OPERATIONS                                           *redis-hashes*

Hashes store multiple field-value pairs~

Set and get~                                           *redis-hashes-set-get*
>
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

    # HSETNX - Set if field doesn't exist
    HSETNX myhash field1 "value"
<

Get all~                                                *redis-hashes-getall*
>
    # HGETALL - Get all fields and values
    HGETALL myhash
    # 1) "field1"
    # 2) "Hello"
    # 3) "field2"
    # 4) "World"

    # HKEYS - Get all field names
    HKEYS myhash

    # HVALS - Get all values
    HVALS myhash

    # HLEN - Get field count
    HLEN myhash
    # (integer) 2

    # HEXISTS - Check if field exists
    HEXISTS myhash field1
    # (integer) 1

    # HDEL - Delete field
    HDEL myhash field1
<

Increment~                                              *redis-hashes-incr*
>
    # HINCRBY - Increment field value
    HINCRBY myhash counter 1

    # HINCRBYFLOAT - Increment float
    HINCRBYFLOAT myhash price 0.5
<

==============================================================================
9. TRANSACTIONS                                        *redis-transactions*

Transaction commands~                           *redis-transactions-commands*
>
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
<

JavaScript example~                             *redis-transactions-javascript*
>
    const pipe = redis.pipeline();
    pipe.set("key1", "value1");
    pipe.set("key2", "value2");
    pipe.incr("counter");
    await pipe.exec();
<

==============================================================================
10. PUB/SUB                                                  *redis-pubsub*

Publish and subscribe~                                *redis-pubsub-commands*
>
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
<

JavaScript example~                               *redis-pubsub-javascript*
>
    const subscriber = redis.duplicate();
    await subscriber.subscribe("mychannel", (message) => {
      console.log(message);
    });

    redis.publish("mychannel", "Hello");
<

==============================================================================
11. PERSISTENCE                                         *redis-persistence*

Persistence commands~                            *redis-persistence-commands*
>
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
<

==============================================================================
12. CONFIGURATION                                            *redis-config*

Configuration commands~                             *redis-config-commands*
>
    # Get configuration
    CONFIG GET maxmemory
    CONFIG GET *

    # Set configuration
    CONFIG SET maxmemory 100mb
    CONFIG SET maxmemory-policy allkeys-lru

    # Save configuration
    CONFIG REWRITE
<

Memory policies~                                       *redis-config-memory*
>
    allkeys-lru           # Remove any key using LRU
    volatile-lru          # Remove expiring keys using LRU
    allkeys-random        # Remove any random key
    volatile-random       # Remove expiring key randomly
    volatile-ttl          # Remove with shortest TTL
    noeviction            # Return error (default)
<

Server info~                                            *redis-config-info*
>
    # Server info
    INFO
    INFO stats
    INFO memory

    # Flushdb
    FLUSHDB               # Clear current database
    FLUSHALL              # Clear all databases
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
