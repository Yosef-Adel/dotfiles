# DOM APIs Reference

Quick reference for DOM APIs. Use `/` to search in vim.

## Table of Contents

- [DOM APIs Reference](#dom-apis-reference)
  - [Table of Contents](#table-of-contents)
  - [Selecting Elements](#selecting-elements)
    - [querySelector / querySelectorAll](#queryselector--queryselectorall)
    - [getElementById](#getelementbyid)
    - [getElementsByClassName](#getelementsbyclassname)
    - [getElementsByTagName](#getelementsbytagname)
  - [Creating \& Modifying Elements](#creating--modifying-elements)
    - [createElement](#createelement)
    - [appendChild / insertBefore](#appendchild--insertbefore)
    - [removeChild](#removechild)
    - [replaceChild](#replacechild)
    - [innerHTML / textContent / innerText](#innerhtml--textcontent--innertext)
  - [Element Properties](#element-properties)
    - [className / classList](#classname--classlist)
    - [id / setAttribute](#id--setattribute)
    - [style](#style)
    - [dataset](#dataset)
  - [DOM Traversal](#dom-traversal)
    - [parentElement](#parentelement)
    - [children / childNodes](#children--childnodes)
    - [nextSibling / previousSibling](#nextsibling--previoussibling)
    - [closest](#closest)
  - [Events](#events)
    - [addEventListener](#addeventlistener)
    - [removeEventListener](#removeeventlistener)
    - [Event Object](#event-object)
    - [Event Delegation](#event-delegation)
  - [Forms](#forms)
    - [Getting Form Values](#getting-form-values)
    - [Form Events](#form-events)
    - [Form Validation](#form-validation)
  - [Window \& Document](#window--document)
    - [window.location](#windowlocation)
    - [window.history](#windowhistory)
    - [document.title](#documenttitle)
    - [window.innerHeight / innerWidth](#windowinnerheight--innerwidth)
  - [Timing Functions](#timing-functions)
    - [requestAnimationFrame](#requestanimationframe)
  - [Window \& Document Events](#window--document-events)
    - [Document Lifecycle Events](#document-lifecycle-events)
    - [Window Events](#window-events)
    - [Visibility Events](#visibility-events)
  - [Local \& Session Storage](#local--session-storage)
    - [localStorage](#localstorage)
    - [sessionStorage](#sessionstorage)
  - [AJAX \& Fetch](#ajax--fetch)
    - [Fetch GET](#fetch-get)
    - [Fetch POST](#fetch-post)

## Selecting Elements

### querySelector / querySelectorAll

```javascript
// querySelector - returns first match
const element = document.querySelector(".my-class");
const element2 = document.querySelector("#my-id");
const element3 = document.querySelector("div.container > p");

// querySelectorAll - returns NodeList of all matches
const elements = document.querySelectorAll(".my-class");
// Convert to array if needed
const arr = Array.from(elements);
// or
const arr2 = [...elements];

// Loop through
elements.forEach((el) => {
  console.log(el);
});
```

### getElementById

```javascript
const element = document.getElementById("my-id");
```

### getElementsByClassName

```javascript
const elements = document.getElementsByClassName("my-class");
// Returns HTMLCollection (live collection)
```

### getElementsByTagName

```javascript
const paragraphs = document.getElementsByTagName("p");
// Returns HTMLCollection (live collection)
```

## Creating & Modifying Elements

### createElement

```javascript
const div = document.createElement("div");
const button = document.createElement("button");
const input = document.createElement("input");

button.textContent = "Click me";
input.type = "text";
```

### appendChild / insertBefore

```javascript
const parent = document.getElementById("container");
const child = document.createElement("div");

// Add to end
parent.appendChild(child);

// Insert at specific position
const referenceNode = parent.firstChild;
parent.insertBefore(child, referenceNode);
```

### removeChild

```javascript
const parent = document.getElementById("container");
const child = parent.getElementById("my-child");

parent.removeChild(child);

// Or simpler:
child.remove();
```

### replaceChild

```javascript
const parent = document.getElementById("container");
const oldChild = document.getElementById("old");
const newChild = document.createElement("div");

parent.replaceChild(newChild, oldChild);
```

### innerHTML / textContent / innerText

```javascript
const element = document.getElementById("my-div");

// innerHTML - includes HTML tags
element.innerHTML = "<p>Hello <strong>World</strong></p>";
const content = element.innerHTML; // "<p>Hello <strong>World</strong></p>"

// textContent - only text (includes hidden elements)
element.textContent = "Hello World";
const text = element.textContent; // "Hello World"

// innerText - only visible text (respects CSS)
element.innerText = "Hello World";
const visibleText = element.innerText; // "Hello World"
```

## Element Properties

### className / classList

```javascript
const element = document.getElementById("my-element");

// className - replace all classes
element.className = "new-class";
element.className = "class1 class2 class3";

// classList - manage individual classes
element.classList.add("active");
element.classList.remove("inactive");
element.classList.toggle("highlight");
element.classList.contains("active"); // true/false
element.classList.replace("old-class", "new-class");

// Get all classes as array-like
for (const cls of element.classList) {
  console.log(cls);
}
```

### id / setAttribute

```javascript
const element = document.getElementById("my-id");

// id
element.id = "new-id";
console.log(element.id); // "new-id"

// setAttribute / getAttribute / removeAttribute
element.setAttribute("data-role", "admin");
const role = element.getAttribute("data-role"); // "admin"
element.removeAttribute("data-role");

// hasAttribute
if (element.hasAttribute("disabled")) {
  console.log("Element is disabled");
}
```

### style

```javascript
const element = document.getElementById("my-element");

// Inline styles
element.style.color = "red";
element.style.backgroundColor = "blue";
element.style.fontSize = "16px";
element.style.display = "none";

// Get computed style
const color = getComputedStyle(element).color;
const display = getComputedStyle(element).display;

// Multiple styles
element.style.cssText = "color: red; background: blue; font-size: 16px;";
```

### dataset

```javascript
// HTML: <div id="user" data-user-id="123" data-role="admin"></div>
const element = document.getElementById("user");

// Access data attributes
console.log(element.dataset.userId); // "123"
console.log(element.dataset.role); // "admin"

// Set data attributes
element.dataset.userId = "456";
element.dataset.newAttr = "value";

// Matches: data-user-id, data-role, data-new-attr
```

## DOM Traversal

### parentElement

```javascript
const element = document.getElementById("child");

const parent = element.parentElement;
const grandparent = parent.parentElement;
```

### children / childNodes

```javascript
const parent = document.getElementById("container");

// children - only Element nodes (preferred)
for (const child of parent.children) {
  console.log(child);
}

// childNodes - all nodes including text/comment
for (const node of parent.childNodes) {
  console.log(node);
}

// First/last child
const first = parent.firstElementChild; // or firstChild
const last = parent.lastElementChild; // or lastChild
```

### nextSibling / previousSibling

```javascript
const element = document.getElementById("item2");

// Element-based (preferred)
const next = element.nextElementSibling;
const prev = element.previousElementSibling;

// Node-based (includes text nodes)
const nextNode = element.nextSibling;
const prevNode = element.previousSibling;
```

### closest

```javascript
// HTML: <div class="container"><div class="item"><button id="btn">Click</button></div></div>
const button = document.getElementById("btn");

// Find closest parent matching selector
const item = button.closest(".item");
const container = button.closest(".container");
const notFound = button.closest(".missing"); // null
```

## Events

### addEventListener

```javascript
const button = document.getElementById("my-button");

// Simple event
button.addEventListener("click", (event) => {
  console.log("Button clicked!");
});

// Multiple listeners
button.addEventListener("click", handleClick);
button.addEventListener("click", logClick);

// With options
element.addEventListener("scroll", handleScroll, { passive: true });
element.addEventListener("click", handleClick, { once: true }); // Only once
element.addEventListener("input", handleInput, { capture: true }); // Capture phase

// Common events
element.addEventListener("focus", () => {});
element.addEventListener("blur", () => {});
element.addEventListener("change", () => {});
element.addEventListener("input", () => {});
element.addEventListener("submit", () => {});
element.addEventListener("keydown", () => {});
element.addEventListener("keyup", () => {});
element.addEventListener("mouseenter", () => {});
element.addEventListener("mouseleave", () => {});
element.addEventListener("mousedown", () => {});
element.addEventListener("mouseup", () => {});
```

### removeEventListener

```javascript
const button = document.getElementById("my-button");

function handleClick(event) {
  console.log("Clicked");
}

button.addEventListener("click", handleClick);
button.removeEventListener("click", handleClick);
```

### Event Object

```javascript
element.addEventListener("click", (event) => {
  // Common properties
  console.log(event.type); // "click"
  console.log(event.target); // Element that triggered event
  console.log(event.currentTarget); // Element with listener
  console.log(event.pageX); // X position relative to page
  console.log(event.pageY); // Y position relative to page

  // Methods
  event.preventDefault(); // Prevent default behavior
  event.stopPropagation(); // Stop event bubbling
  event.stopImmediatePropagation(); // Stop all propagation

  // Keyboard events
  if (event.key === "Enter") {
    console.log("Enter pressed");
  }
  console.log(event.ctrlKey); // true if Ctrl held
  console.log(event.shiftKey);
  console.log(event.altKey);
});
```

### Event Delegation

```javascript
// HTML: <ul id="list"><li><button>Delete</button></li><li><button>Delete</button></li></ul>
const list = document.getElementById("list");

list.addEventListener("click", (event) => {
  if (event.target.tagName === "BUTTON") {
    const item = event.target.closest("li");
    item.remove();
  }
});
```

## Forms

### Getting Form Values

```javascript
// HTML:
// <form id="myForm">
//   <input type="text" name="username" value="john">
//   <input type="password" name="password" value="secret">
//   <textarea name="bio">My bio</textarea>
//   <select name="country"><option value="us">USA</option></select>
//   <input type="checkbox" name="agree" checked>
// </form>

const form = document.getElementById("myForm");

// Get values
const username = form.elements.username.value;
const password = form.elements.password.value;
const bio = form.elements.bio.value;
const country = form.elements.country.value;
const agree = form.elements.agree.checked;

// Or via FormData
const formData = new FormData(form);
const username2 = formData.get("username");
const data = Object.fromEntries(formData);
// {username: 'john', password: 'secret', bio: 'My bio', ...}

// Multiple selects/checkboxes
const selected = Array.from(form.elements.options)
  .filter((option) => option.selected)
  .map((option) => option.value);
```

### Form Events

```javascript
const form = document.getElementById("myForm");
const input = form.elements.username;

// submit - form submission
form.addEventListener("submit", (event) => {
  event.preventDefault(); // Prevent default submission
  const formData = new FormData(form);
  // Send to server, etc.
});

// change - value changed and element loses focus
input.addEventListener("change", (event) => {
  console.log("Final value:", event.target.value);
});

// input - value changed (fires on every keystroke)
input.addEventListener("input", (event) => {
  console.log("Current value:", event.target.value);
});

// focus / blur
input.addEventListener("focus", () => {
  console.log("Input focused");
});

input.addEventListener("blur", () => {
  console.log("Input lost focus");
});
```

### Form Validation

```javascript
const form = document.getElementById("myForm");
const email = form.elements.email;

// HTML5 validation
form.addEventListener("submit", (event) => {
  if (!form.checkValidity()) {
    event.preventDefault();
    // Show errors
  }
});

// Custom validation
email.addEventListener("blur", () => {
  if (!email.value.includes("@")) {
    email.classList.add("error");
    email.setAttribute("aria-invalid", "true");
  } else {
    email.classList.remove("error");
    email.removeAttribute("aria-invalid");
  }
});

// Check validity
console.log(email.validity.valid); // true/false
console.log(email.validity.valueMissing);
console.log(email.validity.typeMismatch);
```

## Window & Document

### window.location

```javascript
// Current URL
console.log(window.location.href); // Full URL
console.log(window.location.protocol); // "https:"
console.log(window.location.hostname); // "example.com"
console.log(window.location.pathname); // "/page"
console.log(window.location.search); // "?id=123"
console.log(window.location.hash); // "#section"

// Navigate
window.location.href = "https://example.com";
window.location.replace("https://example.com"); // Replace history
location.reload(); // Reload page
```

### window.history

```javascript
// Navigate
window.history.back(); // Go back
window.history.forward(); // Go forward
window.history.go(-1); // Go back 1 page
window.history.go(2); // Go forward 2 pages

// Add to history
window.history.pushState({ data: "value" }, "Title", "/new-url");
// Change URL without reload
window.history.replaceState({ data: "value" }, "Title", "/replaced-url");

// Listen for changes
window.addEventListener("popstate", (event) => {
  console.log("History changed:", event.state);
});
```

### document.title

```javascript
// Get title
console.log(document.title); // "Page Title"

// Set title
document.title = "New Title";
```

### window.innerHeight / innerWidth

```javascript
// Viewport dimensions
console.log(window.innerHeight); // 768
console.log(window.innerWidth); // 1024

// Scroll position
console.log(window.scrollX); // Horizontal scroll
console.log(window.scrollY); // Vertical scroll

// Scroll to position
window.scrollTo(0, 0); // Top of page
window.scrollTo({ top: 500, behavior: "smooth" });

// Element scroll into view
element.scrollIntoView();
element.scrollIntoView({ behavior: "smooth", block: "center" });
```

## Timing Functions

### requestAnimationFrame

```javascript
// Schedule function before next repaint
let animationId = requestAnimationFrame(() => {
  console.log("This runs before paint");
});

// Cancel animation
cancelAnimationFrame(animationId);

// Smooth animation example
let position = 0;

function animate() {
  position += 5;
  element.style.left = position + "px";

  if (position < 500) {
    requestAnimationFrame(animate);
  }
}

requestAnimationFrame(animate);
```

## Window & Document Events

### Document Lifecycle Events

```javascript
// DOMContentLoaded - DOM is fully loaded, styles and images may still be loading
document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM ready");
  const element = document.getElementById("my-element"); // Safe to access
});

// load - entire page is loaded (images, stylesheets, scripts)
window.addEventListener("load", () => {
  console.log("Page fully loaded");
});

// unload - user is leaving the page
window.addEventListener("unload", () => {
  // Cleanup code
});

// beforeunload - before page unload (can show confirmation)
window.addEventListener("beforeunload", (event) => {
  if (hasUnsavedChanges) {
    event.preventDefault();
    event.returnValue = "Are you sure?"; // Some browsers show this
  }
});

// readystatechange - track loading progress
document.addEventListener("readystatechange", () => {
  console.log(document.readyState);
  // 'loading' - document is still loading
  // 'interactive' - DOM parsed, DOMContentLoaded fired
  // 'complete' - all resources loaded, load event fired
});
```

### Window Events

```javascript
// resize - window/viewport resized
window.addEventListener("resize", () => {
  console.log("Window size:", window.innerWidth, window.innerHeight);
});

// scroll - page scrolled
window.addEventListener("scroll", () => {
  console.log("Scroll position:", window.scrollY);
  // Debounce for better performance
});

// Debounced scroll
let scrollTimeout;
window.addEventListener("scroll", () => {
  clearTimeout(scrollTimeout);
  scrollTimeout = setTimeout(() => {
    console.log("Scroll ended");
  }, 150);
});

// error - JavaScript error occurs
window.addEventListener("error", (event) => {
  console.error("Error:", event.message, event.filename, event.lineno);
});

// unhandledrejection - unhandled Promise rejection
window.addEventListener("unhandledrejection", (event) => {
  console.error("Unhandled rejection:", event.reason);
  event.preventDefault(); // Suppress error
});

// hashchange - URL hash changed
window.addEventListener("hashchange", () => {
  console.log("Hash changed to:", window.location.hash);
});

// online / offline - network status changed
window.addEventListener("online", () => {
  console.log("Connected to internet");
});

window.addEventListener("offline", () => {
  console.log("Disconnected from internet");
});

// Check current status
if (navigator.onLine) {
  console.log("Online");
}

// beforeprint / afterprint - printing
window.addEventListener("beforeprint", () => {
  console.log("About to print");
});

window.addEventListener("afterprint", () => {
  console.log("Print dialog closed");
});

// message - receive message from other window/worker
window.addEventListener("message", (event) => {
  if (event.origin !== "https://example.com") return; // Security check
  console.log("Message received:", event.data);
});

// Send message to other window
const popup = window.open("popup.html");
popup.postMessage({ type: "greeting", text: "Hello" }, "https://example.com");

// storage - localStorage/sessionStorage changed from another tab
window.addEventListener("storage", (event) => {
  console.log("Storage changed:", event.key, event.newValue);
});
```

### Visibility Events

```javascript
// Page Visibility API - detect if page is visible/hidden
document.addEventListener("visibilitychange", () => {
  if (document.hidden) {
    console.log("Page is hidden");
    // Pause videos, stop animations, etc.
  } else {
    console.log("Page is visible");
    // Resume
  }
});

// Check current state
if (document.hidden) {
  console.log("Page is currently hidden");
} else {
  console.log("Page is currently visible");
}

// visibilityState
const state = document.visibilityState; // 'visible', 'hidden', 'prerender'

// Intersection Observer - detect when elements enter/leave viewport
const observer = new IntersectionObserver((entries) => {
  entries.forEach((entry) => {
    if (entry.isIntersecting) {
      console.log("Element is in viewport");
      // Lazy load images, start animations, etc.
    } else {
      console.log("Element left viewport");
    }
  });
});

const element = document.getElementById("lazy-image");
observer.observe(element);

// IntersectionObserver with options
const observer2 = new IntersectionObserver(
  (entries) => {
    entries.forEach((entry) => {
      console.log(entry.isIntersecting, entry.intersectionRatio);
    });
  },
  {
    threshold: 0.5, // Trigger when 50% visible
    rootMargin: "50px", // Start detecting 50px before element enters
  }
);

// Stop observing
observer2.unobserve(element);
observer2.disconnect(); // Stop all

// Mutation Observer - detect DOM changes
const mutationObserver = new MutationObserver((mutations) => {
  mutations.forEach((mutation) => {
    console.log("DOM changed:", mutation.type);
    console.log(mutation.target);
  });
});

const config = {
  attributes: true, // Watch attribute changes
  attributeFilter: ["class", "id"], // Only these attributes
  childList: true, // Watch children added/removed
  subtree: true, // Watch all descendants
  characterData: true, // Watch text changes
  characterDataOldValue: true, // Include old value
};

mutationObserver.observe(element, config);
mutationObserver.disconnect();

// ResizeObserver - detect element size changes
const resizeObserver = new ResizeObserver((entries) => {
  entries.forEach((entry) => {
    console.log("New size:", entry.contentRect.width, entry.contentRect.height);
  });
});

resizeObserver.observe(element);
resizeObserver.disconnect();
```

## Local & Session Storage

### localStorage

```javascript
// Set item (persists across sessions)
localStorage.setItem("user", "John");
localStorage.setItem("theme", "dark");

// Get item
const user = localStorage.getItem("user"); // "John"
const theme = localStorage.getItem("theme"); // "dark"

// Check exists
if (localStorage.getItem("user")) {
  console.log("User found");
}

// Remove item
localStorage.removeItem("user");

// Clear all
localStorage.clear();

// Get all keys
for (let i = 0; i < localStorage.length; i++) {
  const key = localStorage.key(i);
  const value = localStorage.getItem(key);
}

// Store objects
const user = { name: "John", age: 30 };
localStorage.setItem("user", JSON.stringify(user));

const retrieved = JSON.parse(localStorage.getItem("user"));
// {name: 'John', age: 30}

// Listen for changes
window.addEventListener("storage", (event) => {
  console.log("Storage changed:", event.key, event.newValue);
});
```

### sessionStorage

```javascript
// Same API as localStorage, but cleared when tab closes
sessionStorage.setItem("tempData", "value");
const data = sessionStorage.getItem("tempData");
sessionStorage.removeItem("tempData");
sessionStorage.clear();
```

## AJAX & Fetch

### Fetch GET

```javascript
// Basic GET
fetch("/api/users")
  .then((response) => response.json())
  .then((data) => console.log(data))
  .catch((error) => console.error(error));

// With async/await
async function getUsers() {
  try {
    const response = await fetch("/api/users");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error("Error:", error);
  }
}

// With query parameters
const params = new URLSearchParams({ page: 1, limit: 10 });
fetch(`/api/users?${params}`);

// With headers
fetch("/api/users", {
  headers: {
    Accept: "application/json",
    Authorization: "Bearer token",
  },
});
```

### Fetch POST

```javascript
// POST with JSON
fetch("/api/users", {
  method: "POST",
  headers: {
    "Content-Type": "application/json",
  },
  body: JSON.stringify({
    name: "John",
    email: "john@example.com",
  }),
})
  .then((response) => response.json())
  .then((data) => console.log(data));

// POST with FormData
const formData = new FormData();
formData.append("name", "John");
formData.append("file", fileInput.files[0]);

fetch("/api/upload", {
  method: "POST",
  body: formData,
});

// PUT / DELETE
fetch("/api/users/1", {
  method: "PUT",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ name: "Jane" }),
});

fetch("/api/users/1", {
  method: "DELETE",
});
```
