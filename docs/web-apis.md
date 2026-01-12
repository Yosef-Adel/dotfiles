# Web APIs Reference

Quick reference for modern browser APIs beyond DOM manipulation.

## Table of Contents

- [Crypto API](#crypto-api)
  - [Hashing](#hashing)
  - [Random](#random)
  - [Encrypt/Decrypt](#encryptdecrypt)
- [Blob & File APIs](#blob--file-apis)
  - [Blob](#blob)
  - [File](#file)
  - [FileReader](#filereader)
- [Web Workers](#web-workers)
  - [Creating Workers](#creating-workers)
  - [Worker Communication](#worker-communication)
- [IndexedDB](#indexeddb)
  - [Open Database](#open-database)
  - [CRUD Operations](#crud-operations)
  - [Queries](#queries)
- [Service Workers](#service-workers)
  - [Register Service Worker](#register-service-worker)
  - [Caching](#caching)
- [Geolocation API](#geolocation-api)
- [Notification API](#notification-api)
- [Fullscreen API](#fullscreen-api)
- [Battery API](#battery-api)
- [Clipboard API](#clipboard-api)
- [Vibration API](#vibration-api)

## Crypto API

### Hashing

```javascript
// Hash data (SHA-1, SHA-256, SHA-384, SHA-512)
const buffer = await crypto.subtle.digest(
  "SHA-256",
  new TextEncoder().encode("password")
);

// Convert to hex
const hashArray = Array.from(new Uint8Array(buffer));
const hashHex = hashArray.map((b) => b.toString(16).padStart(2, "0")).join("");

// Generate hash one-liner
async function hash(str) {
  const buffer = await crypto.subtle.digest(
    "SHA-256",
    new TextEncoder().encode(str)
  );
  const hashArray = Array.from(new Uint8Array(buffer));
  return hashArray.map((b) => b.toString(16).padStart(2, "0")).join("");
}

const sha256 = await hash("password");
```

### Random

```javascript
// Generate random bytes
const buffer = new Uint8Array(16);
crypto.getRandomValues(buffer);
const hexString = Array.from(buffer)
  .map((b) => b.toString(16).padStart(2, "0"))
  .join("");

// Generate random number
const array = new Uint32Array(1);
crypto.getRandomValues(array);
const randomNum = array[0];

// Random UUID
const uuid = crypto.randomUUID();
// "8c2b5de2-47e7-4a4d-b9f7-5e5e5e5e5e5e"
```

### Encrypt/Decrypt

```javascript
// Generate key
const key = await crypto.subtle.generateKey(
  { name: "AES-GCM", length: 256 },
  true, // extractable
  ["encrypt", "decrypt"]
);

// Encrypt
const plaintext = "Secret message";
const iv = crypto.getRandomValues(new Uint8Array(12));
const encrypted = await crypto.subtle.encrypt(
  { name: "AES-GCM", iv },
  key,
  new TextEncoder().encode(plaintext)
);

// Decrypt
const decrypted = await crypto.subtle.decrypt(
  { name: "AES-GCM", iv },
  key,
  encrypted
);
const text = new TextDecoder().decode(decrypted);
```

## Blob & File APIs

### Blob

```javascript
// Create blob
const blob = new Blob(["Hello ", "World"], { type: "text/plain" });
console.log(blob.size); // bytes
console.log(blob.type); // "text/plain"

// Slice blob
const part = blob.slice(0, 5);

// Blob URL
const url = URL.createObjectURL(blob);
// Use for: <img src="url">, fetch(), download, etc.

// Download blob
const a = document.createElement("a");
a.href = URL.createObjectURL(blob);
a.download = "file.txt";
a.click();

// Clean up
URL.revokeObjectURL(url);

// Read blob as different types
const arrayBuffer = await blob.arrayBuffer();
const text = await blob.text();
const stream = blob.stream(); // ReadableStream
```

### File

```javascript
// File extends Blob
// From <input type="file">
const input = document.querySelector("input[type=file]");

input.addEventListener("change", (event) => {
  const file = event.target.files[0];
  console.log(file.name); // "document.pdf"
  console.log(file.size); // bytes
  console.log(file.type); // "application/pdf"
  console.log(file.lastModified); // timestamp

  // Use like blob
  const url = URL.createObjectURL(file);
});

// Create file programmatically
const file = new File(["content"], "file.txt", { type: "text/plain" });
```

### FileReader

```javascript
const input = document.querySelector("input[type=file]");

input.addEventListener("change", (event) => {
  const file = event.target.files[0];
  const reader = new FileReader();

  // Read as text
  reader.onload = () => {
    const text = reader.result;
    console.log(text);
  };
  reader.readAsText(file);

  // Read as data URL (for preview)
  reader.onload = () => {
    const dataUrl = reader.result;
    img.src = dataUrl; // Preview image
  };
  reader.readAsDataURL(file);

  // Read as array buffer
  reader.onload = () => {
    const buffer = reader.result;
  };
  reader.readAsArrayBuffer(file);

  // Error handling
  reader.onerror = () => {
    console.error("Error reading file:", reader.error);
  };

  // Progress
  reader.onprogress = (event) => {
    const percent = (event.loaded / event.total) * 100;
    console.log(`${percent}% loaded`);
  };

  // Abort
  // reader.abort();
});
```

## Web Workers

### Creating Workers

```javascript
// main.js
const worker = new Worker("worker.js");

// Send message to worker
worker.postMessage({ task: "calculate", data: [1, 2, 3] });

// Receive message from worker
worker.onmessage = (event) => {
  console.log("Result:", event.data);
};

// Error handling
worker.onerror = (event) => {
  console.error("Worker error:", event.message);
};

// Terminate worker
worker.terminate();

// worker.js
self.onmessage = (event) => {
  const { task, data } = event.data;

  if (task === "calculate") {
    const result = data.reduce((a, b) => a + b);
    self.postMessage(result);
  }
};
```

### Worker Communication

```javascript
// Two-way messaging
// main.js
const worker = new Worker("worker.js");

worker.postMessage({
  type: "start",
  config: { threads: 4 },
});

worker.addEventListener("message", (event) => {
  if (event.data.type === "progress") {
    console.log(`${event.data.percent}%`);
  } else if (event.data.type === "complete") {
    console.log("Done:", event.data.result);
  }
});

// worker.js
self.addEventListener("message", (event) => {
  const { type, config } = event.data;

  if (type === "start") {
    for (let i = 0; i <= 100; i += 10) {
      self.postMessage({ type: "progress", percent: i });
    }
    self.postMessage({ type: "complete", result: "Done" });
  }
});

// Shared Workers
const shared = new SharedWorker("shared-worker.js");
shared.port.start();
shared.port.postMessage("message");
shared.port.onmessage = (event) => {
  console.log(event.data);
};
```

## IndexedDB

### Open Database

```javascript
// Open/create database
const request = indexedDB.open("myDatabase", 1); // version 1

request.onerror = () => {
  console.error("Failed to open database");
};

request.onsuccess = () => {
  const db = request.result;
  console.log("Database opened");
};

// Create object stores
request.onupgradeneeded = (event) => {
  const db = event.target.result;

  // Create store with auto-incrementing key
  if (!db.objectStoreNames.contains("users")) {
    const store = db.createObjectStore("users", {
      keyPath: "id",
      autoIncrement: true,
    });

    // Create indexes
    store.createIndex("email", "email", { unique: true });
    store.createIndex("name", "name");
  }
};
```

### CRUD Operations

```javascript
const db = /* get db from open request */;

// Add/Create
const addRequest = db
  .transaction("users", "readwrite")
  .objectStore("users")
  .add({ name: "John", email: "john@example.com" });

addRequest.onsuccess = () => {
  console.log("Added with ID:", addRequest.result);
};

// Read
const getRequest = db
  .transaction("users")
  .objectStore("users")
  .get(1);

getRequest.onsuccess = () => {
  console.log("User:", getRequest.result);
};

// Update
const putRequest = db
  .transaction("users", "readwrite")
  .objectStore("users")
  .put({ id: 1, name: "Jane", email: "jane@example.com" });

putRequest.onsuccess = () => {
  console.log("Updated");
};

// Delete
const deleteRequest = db
  .transaction("users", "readwrite")
  .objectStore("users")
  .delete(1);

deleteRequest.onsuccess = () => {
  console.log("Deleted");
};

// Delete all
const clearRequest = db
  .transaction("users", "readwrite")
  .objectStore("users")
  .clear();

clearRequest.onsuccess = () => {
  console.log("Store cleared");
};
```

### Queries

```javascript
const db = /* get db */;

// Get all
const allRequest = db
  .transaction("users")
  .objectStore("users")
  .getAll();

allRequest.onsuccess = () => {
  const users = allRequest.result;
  console.log(users);
};

// Query by index
const emailRequest = db
  .transaction("users")
  .objectStore("users")
  .index("email")
  .get("john@example.com");

emailRequest.onsuccess = () => {
  console.log("User:", emailRequest.result);
};

// Range query
const range = IDBKeyRange.bound(1, 5); // Keys 1-5
const rangeRequest = db
  .transaction("users")
  .objectStore("users")
  .getAll(range);

rangeRequest.onsuccess = () => {
  console.log("Users 1-5:", rangeRequest.result);
};

// IDBKeyRange options
IDBKeyRange.lowerBound(1); // >= 1
IDBKeyRange.upperBound(5); // <= 5
IDBKeyRange.bound(1, 5); // 1 <= x <= 5
IDBKeyRange.bound(1, 5, true); // 1 < x <= 5
IDBKeyRange.bound(1, 5, true, true); // 1 < x < 5

// Cursor (iterate)
const cursorRequest = db
  .transaction("users")
  .objectStore("users")
  .openCursor();

cursorRequest.onsuccess = (event) => {
  const cursor = event.target.result;
  if (cursor) {
    console.log("User:", cursor.value);
    cursor.continue(); // Next item
  }
};
```

## Service Workers

### Register Service Worker

```javascript
// main.js
if ("serviceWorker" in navigator) {
  navigator.serviceWorker
    .register("/service-worker.js")
    .then((reg) => {
      console.log("Service Worker registered");
    })
    .catch((err) => {
      console.error("Registration failed:", err);
    });
}

// Check for updates
setInterval(() => {
  navigator.serviceWorker.ready.then((reg) => {
    reg.update();
  });
}, 60000); // Check every minute

// Get active service worker
navigator.serviceWorker.controller; // Current SW

// Listen for messages
navigator.serviceWorker.addEventListener("message", (event) => {
  console.log("Message from SW:", event.data);
});
```

### Caching

```javascript
// service-worker.js
const CACHE_NAME = "v1";

// Install - cache assets
self.addEventListener("install", (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME).then((cache) => {
      return cache.addAll(["/", "/index.html", "/style.css", "/app.js"]);
    })
  );
  self.skipWaiting(); // Activate immediately
});

// Fetch - serve from cache
self.addEventListener("fetch", (event) => {
  event.respondWith(
    caches.match(event.request).then((response) => {
      // Return cached or fetch
      return response || fetch(event.request);
    })
  );
});

// Cache and update strategy
self.addEventListener("fetch", (event) => {
  if (event.request.method === "GET") {
    event.respondWith(
      caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          const fetchPromise = fetch(event.request).then((response) => {
            // Update cache with fresh version
            cache.put(event.request, response.clone());
            return response;
          });
          return response || fetchPromise;
        });
      })
    );
  }
});

// Activate - cleanup old caches
self.addEventListener("activate", (event) => {
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames.map((cacheName) => {
          if (cacheName !== CACHE_NAME) {
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  self.clients.claim(); // Take control of pages
});
```

## Geolocation API

```javascript
// Check support
if ("geolocation" in navigator) {
  // Get current position
  navigator.geolocation.getCurrentPosition(
    (position) => {
      console.log(position.coords.latitude);
      console.log(position.coords.longitude);
      console.log(position.coords.accuracy); // meters
    },
    (error) => {
      console.error("Error:", error.message);
      // error.code: 1 = permission denied, 2 = position unavailable, 3 = timeout
    },
    {
      timeout: 5000,
      enableHighAccuracy: true,
    }
  );

  // Watch position
  const watchId = navigator.geolocation.watchPosition(
    (position) => {
      console.log("New position:", position.coords);
    },
    (error) => {
      console.error(error);
    }
  );

  // Stop watching
  navigator.geolocation.clearWatch(watchId);
}
```

## Notification API

```javascript
// Request permission
Notification.requestPermission().then((permission) => {
  if (permission === "granted") {
    console.log("Notifications allowed");
  }
});

// Send notification
if (Notification.permission === "granted") {
  new Notification("Title", {
    body: "Message body",
    icon: "/icon.png",
    badge: "/badge.png",
    tag: "notification-1", // Group notifications
    requireInteraction: true, // Don't auto-close
  });

  // With service worker
  self.registration.showNotification("Title", {
    body: "Message",
    actions: [
      { action: "open", title: "Open" },
      { action: "close", title: "Close" },
    ],
  });
}

// Listen for notification clicks
self.addEventListener("notificationclick", (event) => {
  if (event.action === "open") {
    clients.openWindow("/");
  }
  event.notification.close();
});
```

## Fullscreen API

```javascript
const element = document.getElementById("video");

// Request fullscreen
element.requestFullscreen();
// or
element.webkitRequestFullscreen(); // Safari
element.mozRequestFullScreen(); // Firefox
element.msRequestFullscreen(); // IE/Edge

// Exit fullscreen
document.exitFullscreen();

// Check if fullscreen
if (document.fullscreenElement) {
  console.log("In fullscreen");
} else {
  console.log("Not fullscreen");
}

// Listen for fullscreen changes
document.addEventListener("fullscreenchange", () => {
  if (document.fullscreenElement) {
    console.log("Entered fullscreen");
  } else {
    console.log("Exited fullscreen");
  }
});

// Fullscreen capabilities
document.fullscreenEnabled; // true/false
document.fullscreenElement; // Current fullscreen element or null
```

## Battery API (Deprecated)

```javascript
// Deprecated but still works in some browsers
navigator.getBattery().then((battery) => {
  console.log(battery.level); // 0-1
  console.log(battery.charging); // true/false
  console.log(battery.chargingTime); // seconds
  console.log(battery.dischargingTime); // seconds

  battery.addEventListener("levelchange", () => {
    console.log("Battery level:", battery.level);
  });
});
```

## Clipboard API

```javascript
// Copy to clipboard
await navigator.clipboard.writeText("Text to copy");

// Copy formatted content
await navigator.clipboard.write([
  new ClipboardItem({
    "text/plain": new Blob(["Plain text"], { type: "text/plain" }),
    "text/html": new Blob(["<b>HTML</b>"], { type: "text/html" }),
  }),
]);

// Read from clipboard
const text = await navigator.clipboard.readText();
console.log(text);

// Copy with fallback
function copyToClipboard(text) {
  if (navigator.clipboard && navigator.clipboard.writeText) {
    return navigator.clipboard.writeText(text);
  }

  // Fallback
  const textarea = document.createElement("textarea");
  textarea.value = text;
  document.body.appendChild(textarea);
  textarea.select();
  document.execCommand("copy");
  document.body.removeChild(textarea);
}
```

## Vibration API

```javascript
// Vibrate once (milliseconds)
navigator.vibrate(200);
navigator.vibrate([100]); // Same as above

// Vibration pattern
navigator.vibrate([100, 50, 100]); // Vibrate, pause, vibrate

// Stop vibration
navigator.vibrate(0);
navigator.vibrate([]);

// Check support
if ("vibrate" in navigator) {
  navigator.vibrate(200);
}
```
