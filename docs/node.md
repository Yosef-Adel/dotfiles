# Node.js APIs Reference

Quick reference for Node.js core modules. Use `/` to search in vim.

## Table of Contents

- [Node.js APIs Reference](#nodejs-apis-reference)
  - [Table of Contents](#table-of-contents)
  - [File System (fs)](#file-system-fs)
    - [Reading Files](#reading-files)
    - [Writing Files](#writing-files)
    - [Directory Operations](#directory-operations)
    - [File Info](#file-info)
  - [Path](#path)
    - [Path Methods](#path-methods)
  - [Events](#events)
    - [EventEmitter](#eventemitter)
  - [Streams](#streams)
    - [Reading Streams](#reading-streams)
    - [Writing Streams](#writing-streams)
    - [Transform Streams](#transform-streams)
    - [Piping](#piping)
  - [HTTP Server](#http-server)
    - [Create Server](#create-server)
    - [Request/Response](#requestresponse)
    - [Routing](#routing)
  - [Process](#process)
    - [Process Info](#process-info)
    - [Environment Variables](#environment-variables)
    - [Exit \& Signals](#exit--signals)
  - [Child Processes](#child-processes)
    - [exec](#exec)
    - [spawn](#spawn)
    - [fork](#fork)
  - [Crypto](#crypto)
    - [Hashing](#hashing)
    - [Random Bytes](#random-bytes)
  - [Utilities](#utilities)
    - [util.inspect](#utilinspect)
    - [util.promisify](#utilpromisify)

## File System (fs)

### Reading Files

```javascript
const fs = require("fs");

// Synchronous (blocks)
const content = fs.readFileSync("file.txt", "utf8");

// Callback-based
fs.readFile("file.txt", "utf8", (err, data) => {
  if (err) throw err;
  console.log(data);
});

// Promise-based
const fsPromises = fs.promises;
const content = await fsPromises.readFile("file.txt", "utf8");

// Streaming (for large files)
const stream = fs.createReadStream("large-file.txt", {
  encoding: "utf8",
  highWaterMark: 16 * 1024, // 16KB chunks
});

stream.on("data", (chunk) => {
  console.log("Chunk:", chunk);
});

stream.on("end", () => {
  console.log("Done reading");
});

stream.on("error", (err) => {
  console.error(err);
});
```

### Writing Files

```javascript
const fs = require("fs");

// Synchronous
fs.writeFileSync("output.txt", "Hello World");

// Callback-based
fs.writeFile("output.txt", "Hello World", (err) => {
  if (err) throw err;
  console.log("File written");
});

// Promise-based
await fs.promises.writeFile("output.txt", "Hello World");

// Append
fs.appendFileSync("log.txt", "New log entry\n");
await fs.promises.appendFile("log.txt", "New log entry\n");

// Writing stream
const writer = fs.createWriteStream("output.txt");
writer.write("Line 1\n");
writer.write("Line 2\n");
writer.end(); // Must call to finish

writer.on("finish", () => {
  console.log("All writes done");
});

writer.on("error", (err) => {
  console.error(err);
});
```

### Directory Operations

```javascript
const fs = require("fs");

// Create directory
fs.mkdirSync("new-folder");
await fs.promises.mkdir("new-folder");

// Create recursive
await fs.promises.mkdir("path/to/deep/folder", { recursive: true });

// Read directory
const files = fs.readdirSync("./");
// ['file.txt', 'folder', ...]

const files2 = await fs.promises.readdir("./");

// Read with file types
const entries = await fs.promises.readdir("./", { withFileTypes: true });
entries.forEach((entry) => {
  if (entry.isFile()) console.log("File:", entry.name);
  if (entry.isDirectory()) console.log("Dir:", entry.name);
});

// Remove directory
fs.rmdirSync("empty-folder");
await fs.promises.rmdir("empty-folder");

// Remove directory recursively
await fs.promises.rm("folder-with-contents", { recursive: true });

// Copy file
fs.copyFileSync("src.txt", "dest.txt");
await fs.promises.copyFile("src.txt", "dest.txt");

// Copy recursively
const cp = require("fs").cp || require("fs").promises.cp;
await cp("src-folder", "dest-folder", { recursive: true });
```

### File Info

```javascript
const fs = require("fs");

// File exists
const exists = fs.existsSync("file.txt");

// Get stats
const stats = fs.statSync("file.txt");
console.log(stats.isFile()); // true
console.log(stats.isDirectory()); // false
console.log(stats.size); // bytes
console.log(stats.mtime); // Modified time

const stats2 = await fs.promises.stat("file.txt");

// Watch file/directory
fs.watch("file.txt", (eventType, filename) => {
  console.log(eventType); // 'rename' or 'change'
  console.log(filename);
});

// Rename/Move
fs.renameSync("old-name.txt", "new-name.txt");
await fs.promises.rename("old-name.txt", "new-name.txt");

// Delete file
fs.unlinkSync("file.txt");
await fs.promises.unlink("file.txt");
```

## Path

### Path Methods

```javascript
const path = require("path");

// Join paths
const fullPath = path.join("/users", "john", "documents", "file.txt");
// /users/john/documents/file.txt

// Resolve to absolute
const absolute = path.resolve("./file.txt");
// /current/working/directory/file.txt

// Get basename (filename)
path.basename("/users/john/file.txt"); // "file.txt"
path.basename("/users/john/file.txt", ".txt"); // "file"

// Get dirname
path.dirname("/users/john/file.txt"); // "/users/john"

// Get extension
path.extname("file.txt"); // ".txt"
path.extname("file.tar.gz"); // ".gz"

// Parse path
const parsed = path.parse("/users/john/file.txt");
// { root: '/', dir: '/users/john', base: 'file.txt', ext: '.txt', name: 'file' }

// Format path
const formatted = path.format({
  dir: "/users/john",
  base: "file.txt",
});
// /users/john/file.txt

// Normalize path
path.normalize("/users//john///documents"); // "/users/john/documents"

// Relative path
path.relative("/a/b/c", "/a/b/d"); // "../d"

// Check if absolute
path.isAbsolute("/users/file.txt"); // true
path.isAbsolute("relative/file.txt"); // false

// Platform separator
path.sep; // "/" (unix) or "\\" (windows)
path.delimiter; // ":" (unix) or ";" (windows)
```

## Events

### EventEmitter

```javascript
const EventEmitter = require("events");

// Create custom emitter
class MyEmitter extends EventEmitter {}

const emitter = new MyEmitter();

// Listen for event
emitter.on("message", (data) => {
  console.log("Got message:", data);
});

// Emit event
emitter.emit("message", "Hello");

// Once - listen only once
emitter.once("startup", () => {
  console.log("Starting up"); // Only fires first time
});

emitter.emit("startup");
emitter.emit("startup"); // Doesn't trigger listener

// Remove listener
function handler(data) {
  console.log(data);
}

emitter.on("data", handler);
emitter.off("data", handler); // Remove specific

emitter.removeAllListeners("event"); // Remove all for event
emitter.removeAllListeners(); // Remove all

// Get listeners
const listeners = emitter.listeners("message");
const count = emitter.listenerCount("message");

// Listen to all events
emitter.on("*", (event, data) => {
  console.log(`Event: ${event}, Data:`, data);
});

// Error handling (important!)
emitter.on("error", (err) => {
  console.error("Error:", err);
});

// If no error listener and error is emitted, process crashes
// Always add error listener
```

## Streams

### Reading Streams

```javascript
const fs = require("fs");

const readable = fs.createReadStream("large-file.txt", {
  encoding: "utf8",
  highWaterMark: 16 * 1024, // Chunk size
});

// Read chunks
readable.on("data", (chunk) => {
  console.log("Chunk size:", chunk.length);
});

readable.on("end", () => {
  console.log("No more data");
});

readable.on("error", (err) => {
  console.error("Error:", err);
});

// Pause/Resume
readable.pause();
setTimeout(() => {
  readable.resume();
}, 1000);

// Check if paused
if (readable.isPaused()) {
  readable.resume();
}

// Read exact amount
readable.read(10); // Read 10 bytes
```

### Writing Streams

```javascript
const fs = require("fs");

const writable = fs.createWriteStream("output.txt", {
  encoding: "utf8",
  highWaterMark: 16 * 1024,
});

// Write data
writable.write("Hello ");
writable.write("World");
writable.end(); // Signal end

// Check if writable
if (writable.writable) {
  writable.write("data");
}

// Events
writable.on("finish", () => {
  console.log("All data written");
});

writable.on("error", (err) => {
  console.error(err);
});

writable.on("drain", () => {
  console.log("Buffer emptied, ready for more data");
});

// Write with callback
writable.write("data", "utf8", () => {
  console.log("Data written");
});

// Backpressure handling
function writeMillionRecords(writer) {
  let i = 0;

  function write() {
    let ok = true;
    while (i < 1000000 && ok) {
      const data = `Record ${i}\n`;
      if (i === 999999) {
        writer.write(data); // Last write
      } else {
        ok = writer.write(data); // Check backpressure
      }
      i++;
    }
    if (i < 1000000) {
      writer.once("drain", write);
    }
  }

  write();
}
```

### Transform Streams

```javascript
const { Transform } = require("stream");

// Create transform stream
const uppercase = new Transform({
  transform(chunk, encoding, callback) {
    this.push(chunk.toString().toUpperCase());
    callback(); // Signal done
  },
});

// Use it
process.stdin.pipe(uppercase).pipe(process.stdout);

// With error handling
const myTransform = new Transform({
  transform(chunk, encoding, callback) {
    try {
      const result = chunk.toString().toUpperCase();
      callback(null, result);
    } catch (err) {
      callback(err);
    }
  },
});

// Flush function (called at end)
const transform2 = new Transform({
  transform(chunk, encoding, callback) {
    callback(null, chunk);
  },
  flush(callback) {
    console.log("Stream ending");
    callback();
  },
});
```

### Piping

```javascript
const fs = require("fs");

// Simple pipe
fs.createReadStream("input.txt").pipe(fs.createWriteStream("output.txt"));

// Chain multiple transforms
fs.createReadStream("input.txt")
  .pipe(uppercase) // Custom transform
  .pipe(fs.createWriteStream("output.txt"));

// Error handling in pipe
fs.createReadStream("input.txt")
  .on("error", (err) => {
    console.error("Read error:", err);
  })
  .pipe(fs.createWriteStream("output.txt"))
  .on("error", (err) => {
    console.error("Write error:", err);
  });

// Using pipeline (better error handling)
const { pipeline } = require("stream");
const { createReadStream, createWriteStream } = require("fs");
const { createGzip } = require("zlib");

pipeline(
  createReadStream("file.txt"),
  createGzip(),
  createWriteStream("file.txt.gz"),
  (err) => {
    if (err) {
      console.error("Pipeline failed:", err);
    } else {
      console.log("Pipeline succeeded");
    }
  }
);
```

## HTTP Server

### Create Server

```javascript
const http = require("http");

const server = http.createServer((req, res) => {
  console.log(req.method, req.url);
  res.statusCode = 200;
  res.setHeader("Content-Type", "text/plain");
  res.end("Hello World");
});

server.listen(3000, "127.0.0.1", () => {
  console.log("Server running at http://127.0.0.1:3000/");
});

// Close server
server.close(() => {
  console.log("Server closed");
});

// Max connections
server.maxConnections = 100;
```

### Request/Response

```javascript
const http = require("http");

const server = http.createServer((req, res) => {
  // Request properties
  console.log(req.method); // GET, POST, etc.
  console.log(req.url); // "/path?query=value"
  console.log(req.headers); // { 'user-agent': '...', ... }

  // Parse URL
  const url = new URL(req.url, `http://${req.headers.host}`);
  const pathname = url.pathname; // "/path"
  const searchParams = url.searchParams; // URLSearchParams
  const query = searchParams.get("query"); // "value"

  // Read request body
  let body = "";
  req.on("data", (chunk) => {
    body += chunk;
  });

  req.on("end", () => {
    console.log("Body:", body);
  });

  // Response
  res.statusCode = 200;
  res.setHeader("Content-Type", "application/json");
  res.write(JSON.stringify({ message: "Hello" }));
  res.end();
});

server.listen(3000);
```

### Routing

```javascript
const http = require("http");

const server = http.createServer((req, res) => {
  const url = new URL(req.url, `http://${req.headers.host}`);
  const pathname = url.pathname;
  const method = req.method;

  if (pathname === "/" && method === "GET") {
    res.statusCode = 200;
    res.end("Home");
  } else if (pathname === "/api/users" && method === "GET") {
    res.setHeader("Content-Type", "application/json");
    res.end(JSON.stringify([{ id: 1, name: "John" }]));
  } else if (pathname === "/api/users" && method === "POST") {
    // Handle POST
    res.statusCode = 201;
    res.end("User created");
  } else {
    res.statusCode = 404;
    res.end("Not found");
  }
});

server.listen(3000);
```

## Process

### Process Info

```javascript
// Current process ID
console.log(process.pid);

// Process version
console.log(process.version); // v16.0.0
console.log(process.versions); // { node: '16.0.0', v8: '9.0.0', ... }

// Uptime in seconds
console.log(process.uptime());

// Memory usage
const usage = process.memoryUsage();
console.log(Math.round(usage.heapUsed / 1024 / 1024) + " MB");

// CPU usage (rough)
const startUsage = process.cpuUsage();
// Do some work
const endUsage = process.cpuUsage(startUsage);
console.log(`User CPU: ${endUsage.user}µs, System CPU: ${endUsage.system}µs`);

// Platform
console.log(process.platform); // 'darwin', 'linux', 'win32'
console.log(process.arch); // 'x64', 'arm64'

// Current working directory
console.log(process.cwd());
process.chdir("/path");

// Command line arguments
console.log(process.argv);
// ['node', '/path/to/script.js', 'arg1', 'arg2']
```

### Environment Variables

```javascript
// Access environment variables
console.log(process.env.HOME);
console.log(process.env.NODE_ENV); // 'development', 'production'

// Set environment variable
process.env.MY_VAR = "value";

// Check if exists
if (process.env.API_KEY) {
  console.log("API key configured");
}

// Get all
console.log(process.env);

// Common pattern with .env file
require("dotenv").config(); // Load from .env
const dbUrl = process.env.DATABASE_URL;
```

### Exit & Signals

```javascript
// Exit process
process.exit(0); // Success
process.exit(1); // Error

// Exit code
process.exitCode = 0;

// Handle graceful shutdown
process.on("SIGTERM", () => {
  console.log("SIGTERM received, shutting down gracefully");
  server.close(() => {
    process.exit(0);
  });
});

process.on("SIGINT", () => {
  console.log("SIGINT received (Ctrl+C)");
  process.exit(0);
});

// Uncaught exception
process.on("uncaughtException", (err) => {
  console.error("Uncaught exception:", err);
  process.exit(1);
});

// Unhandled rejection
process.on("unhandledRejection", (reason, promise) => {
  console.error("Unhandled rejection:", reason);
  process.exit(1);
});
```

## Child Processes

### exec

```javascript
const { exec } = require("child_process");

// Execute shell command
exec("ls -la", (error, stdout, stderr) => {
  if (error) {
    console.error("Error:", error.message);
    return;
  }
  console.log("Output:", stdout);
  if (stderr) console.error("Stderr:", stderr);
});

// With options
exec("npm list", { maxBuffer: 10 * 1024 * 1024 }, (error, stdout) => {
  console.log(stdout);
});

// Promise version
const util = require("util");
const execPromise = util.promisify(exec);

const { stdout } = await execPromise("ls -la");
console.log(stdout);
```

### spawn

```javascript
const { spawn } = require("child_process");

// Spawn process
const child = spawn("node", ["script.js", "arg1", "arg2"]);

// Streams
child.stdout.on("data", (data) => {
  console.log("stdout:", data.toString());
});

child.stderr.on("data", (data) => {
  console.error("stderr:", data.toString());
});

child.on("close", (code) => {
  console.log("Process exited with code", code);
});

// Write to stdin
child.stdin.write("input data\n");
child.stdin.end();
```

### fork

```javascript
const { fork } = require("child_process");

// Fork worker script
const child = fork("worker.js");

// Send message
child.send({ task: "process", data: [1, 2, 3] });

// Receive message
child.on("message", (msg) => {
  console.log("Message from child:", msg);
});

child.on("error", (err) => {
  console.error("Error:", err);
});

child.on("exit", (code) => {
  console.log("Child exited with code", code);
});

// worker.js
process.on("message", (msg) => {
  console.log("Message from parent:", msg);
  const result = msg.data.reduce((a, b) => a + b);
  process.send({ result });
});
```

## Crypto

### Hashing

```javascript
const crypto = require("crypto");

// Create hash
const hash = crypto.createHash("sha256");
hash.update("password");
const digest = hash.digest("hex"); // hexadecimal
// "5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8"

// One-liner
const hashed = crypto.createHash("sha256").update("password").digest("hex");

// Other algorithms
crypto.createHash("md5");
crypto.createHash("sha1");
crypto.createHash("sha512");

// HMAC (keyed hash)
const hmac = crypto
  .createHmac("sha256", "secret-key")
  .update("data")
  .digest("hex");
```

### Random Bytes

```javascript
const crypto = require("crypto");

// Generate random bytes
const bytes = crypto.randomBytes(16); // 16 random bytes
const hex = bytes.toString("hex");

// Generate random integer
const random = crypto.randomInt(0, 100); // 0-99

// Generate random UUID
const uuid = crypto.randomUUID();
// "8c2b5de2-47e7-4a4d-b9f7-5e5e5e5e5e5e"
```

## Utilities

### util.inspect

```javascript
const util = require("util");

const obj = { a: 1, b: { c: 2 } };

// Pretty print
console.log(util.inspect(obj, { colors: true, depth: 2 }));

// Without colors
const str = util.inspect(obj);
console.log(str);

// Custom inspect
class MyClass {
  [util.inspect.custom]() {
    return "MyClass {}";
  }
}

console.log(new MyClass()); // MyClass {}
```

### util.promisify

```javascript
const util = require("util");
const fs = require("fs");

// Convert callback-based to promise
const readFile = util.promisify(fs.readFile);

const data = await readFile("file.txt", "utf8");
console.log(data);

// Custom function
function oldStyleCallback(value, callback) {
  setTimeout(() => {
    if (value > 0) {
      callback(null, value * 2);
    } else {
      callback(new Error("Must be positive"));
    }
  }, 100);
}

const promisified = util.promisify(oldStyleCallback);
const result = await promisified(5);
console.log(result); // 10
```
