# JavaScript Reference

Quick reference for JavaScript. Use `/` to search in vim.

## Table of Contents

- [Array Methods](#array-methods)
  - [map()](#map)
  - [filter()](#filter)
  - [reduce()](#reduce)
  - [find()](#find)
  - [findIndex()](#findindex)
  - [some()](#some)
  - [every()](#every)
  - [sort()](#sort)
  - [slice()](#slice)
  - [splice()](#splice)
  - [concat()](#concat)
  - [flat()](#flat)
  - [flatMap()](#flatmap)
  - [includes()](#includes)
  - [join()](#join)
- [Promises & Async/Await](#promises--asyncawait)
  - [Promise Basics](#promise-basics)
  - [Async/Await](#asyncawait)
  - [Promise.all()](#promiseall)
  - [Promise.race()](#promiserace)
  - [Promise.allSettled()](#promiseallsettled)
- [Destructuring](#destructuring)
  - [Array Destructuring](#array-destructuring)
  - [Object Destructuring](#object-destructuring)
  - [Function Parameters](#function-parameters)
- [Spread Operator](#spread-operator)
  - [Array Spread](#array-spread)
  - [Object Spread](#object-spread)
- [Object Methods](#object-methods)
  - [Object.keys()](#objectkeys)
  - [Object.values()](#objectvalues)
  - [Object.entries()](#objectentries)
  - [Object.fromEntries()](#objectfromentries)
  - [Object.assign()](#objectassign)
- [String Methods](#string-methods)
  - [Template Literals](#template-literals)
  - [includes()](#includes-1)
  - [startsWith() / endsWith()](#startswith--endswith)
  - [split()](#split)
  - [trim()](#trim)
  - [replace() / replaceAll()](#replace--replaceall)
- [Optional Chaining](#optional-chaining)
- [Nullish Coalescing](#nullish-coalescing)
- [setTimeout / setInterval](#settimeout--setinterval)
  - [setTimeout](#settimeout)
  - [setInterval](#setinterval)
- [Fetch API](#fetch-api)
  - [Basic GET](#basic-get)
  - [POST Request](#post-request)
  - [Error Handling](#error-handling)
- [Regular Expressions](#regular-expressions)
  - [Creating Regex](#creating-regex)
  - [Pattern Matching](#pattern-matching)
  - [Common Patterns](#common-patterns)
- [Error Handling](#error-handling-1)
  - [try/catch/finally](#trycatchfinally)
  - [Custom Errors](#custom-errors)
- [WeakMap & WeakSet](#weakmap--weakset)
- [Symbols](#symbols)
- [Proxy & Reflect](#proxy--reflect)
- [Generators](#generators)
- [Closures](#closures)
- [Event Loop](#event-loop)
- [this Binding](#this-binding)
- [Equality](#equality)

## Array Methods

### map()

Transform each element.

```javascript
const numbers = [1, 2, 3, 4];
const doubled = numbers.map((n) => n * 2);
// [2, 4, 6, 8]

const users = [
  { name: "John", age: 30 },
  { name: "Jane", age: 25 },
];
const names = users.map((u) => u.name);
// ['John', 'Jane']
```

### filter()

Keep elements that pass a test.

```javascript
const numbers = [1, 2, 3, 4, 5, 6];
const evens = numbers.filter((n) => n % 2 === 0);
// [2, 4, 6]

const users = [
  { name: "John", age: 30 },
  { name: "Jane", age: 17 },
];
const adults = users.filter((u) => u.age >= 18);
// [{name: 'John', age: 30}]
```

### reduce()

Reduce array to a single value.

```javascript
const numbers = [1, 2, 3, 4];
const sum = numbers.reduce((acc, n) => acc + n, 0);
// 10

const items = [{ price: 10 }, { price: 20 }, { price: 30 }];
const total = items.reduce((acc, item) => acc + item.price, 0);
// 60

// Group by
const people = [
  { name: "John", age: 30 },
  { name: "Jane", age: 25 },
  { name: "Bob", age: 30 },
];
const grouped = people.reduce((acc, person) => {
  const key = person.age;
  if (!acc[key]) acc[key] = [];
  acc[key].push(person);
  return acc;
}, {});
// {25: [{name: 'Jane', age: 25}], 30: [{name: 'John', age: 30}, {name: 'Bob', age: 30}]}
```

### find()

Find first element that matches.

```javascript
const users = [
  { id: 1, name: "John" },
  { id: 2, name: "Jane" },
];
const user = users.find((u) => u.id === 2);
// {id: 2, name: 'Jane'}
```

### findIndex()

Find index of first matching element.

```javascript
const users = [
  { id: 1, name: "John" },
  { id: 2, name: "Jane" },
];
const index = users.findIndex((u) => u.id === 2);
// 1
```

### some()

Check if at least one element passes test.

```javascript
const numbers = [1, 2, 3, 4];
const hasEven = numbers.some((n) => n % 2 === 0);
// true
```

### every()

Check if all elements pass test.

```javascript
const numbers = [2, 4, 6, 8];
const allEven = numbers.every((n) => n % 2 === 0);
// true
```

### sort()

Sort array (modifies original).

```javascript
const numbers = [3, 1, 4, 1, 5];
numbers.sort((a, b) => a - b); // Ascending
// [1, 1, 3, 4, 5]

numbers.sort((a, b) => b - a); // Descending
// [5, 4, 3, 1, 1]

const users = [{ name: "John" }, { name: "Alice" }, { name: "Bob" }];
users.sort((a, b) => a.name.localeCompare(b.name));
// [{name: 'Alice'}, {name: 'Bob'}, {name: 'John'}]
```

### slice()

Get a portion of array (doesn't modify original).

```javascript
const arr = [1, 2, 3, 4, 5];
const sub = arr.slice(1, 3);
// [2, 3]

const last2 = arr.slice(-2);
// [4, 5]
```

### splice()

Add/remove elements (modifies original).

```javascript
const arr = [1, 2, 3, 4, 5];

// Remove 2 elements starting at index 2
arr.splice(2, 2);
// arr is now [1, 2, 5]

// Insert elements at index 1
arr.splice(1, 0, "a", "b");
// arr is now [1, 'a', 'b', 2, 5]
```

### concat()

Merge arrays.

```javascript
const arr1 = [1, 2];
const arr2 = [3, 4];
const combined = arr1.concat(arr2);
// [1, 2, 3, 4]

// Or use spread
const combined2 = [...arr1, ...arr2];
// [1, 2, 3, 4]
```

### flat()

Flatten nested arrays.

```javascript
const nested = [1, [2, 3], [4, [5, 6]]];
const flat = nested.flat();
// [1, 2, 3, 4, [5, 6]]

const deepFlat = nested.flat(2);
// [1, 2, 3, 4, 5, 6]

const allFlat = nested.flat(Infinity);
// [1, 2, 3, 4, 5, 6]
```

### flatMap()

Map then flatten by one level.

```javascript
const arr = [1, 2, 3];
const result = arr.flatMap((n) => [n, n * 2]);
// [1, 2, 2, 4, 3, 6]
```

### includes()

Check if array contains value.

```javascript
const arr = [1, 2, 3];
arr.includes(2); // true
arr.includes(4); // false
```

### join()

Join array elements into string.

```javascript
const arr = ["Hello", "World"];
arr.join(" "); // "Hello World"
arr.join("-"); // "Hello-World"
```

## Promises & Async/Await

### Promise Basics

```javascript
const promise = new Promise((resolve, reject) => {
  setTimeout(() => {
    resolve("Success!");
    // or reject(new Error('Failed!'));
  }, 1000);
});

promise
  .then((result) => console.log(result))
  .catch((error) => console.error(error));
```

### Async/Await

```javascript
async function fetchUser(id) {
  try {
    const response = await fetch(`/api/users/${id}`);
    const user = await response.json();
    return user;
  } catch (error) {
    console.error("Error:", error);
    throw error;
  }
}

// Using it
fetchUser(1).then((user) => console.log(user));
```

### Promise.all()

Wait for all promises.

```javascript
const p1 = fetch("/api/users");
const p2 = fetch("/api/posts");
const p3 = fetch("/api/comments");

const [users, posts, comments] = await Promise.all([p1, p2, p3]);
```

### Promise.race()

Get first resolved/rejected promise.

```javascript
const timeout = new Promise((_, reject) =>
  setTimeout(() => reject(new Error("Timeout")), 5000)
);

const fetchData = fetch("/api/data");

try {
  const result = await Promise.race([fetchData, timeout]);
} catch (error) {
  console.error("Request failed or timed out");
}
```

### Promise.allSettled()

Wait for all to settle (resolve or reject).

```javascript
const promises = [
  fetch("/api/user"),
  fetch("/api/posts"),
  fetch("/api/comments"),
];

const results = await Promise.allSettled(promises);
results.forEach((result) => {
  if (result.status === "fulfilled") {
    console.log("Success:", result.value);
  } else {
    console.log("Error:", result.reason);
  }
});
```

## Destructuring

### Array Destructuring

```javascript
const arr = [1, 2, 3, 4];
const [first, second] = arr;
// first = 1, second = 2

const [, , third] = arr;
// third = 3

const [a, ...rest] = arr;
// a = 1, rest = [2, 3, 4]
```

### Object Destructuring

```javascript
const user = { name: "John", age: 30, email: "john@example.com" };

const { name, age } = user;
// name = 'John', age = 30

// Rename
const { name: userName, age: userAge } = user;
// userName = 'John', userAge = 30

// Default values
const { name, country = "USA" } = user;
// country = 'USA'

// Rest
const { name, ...otherProps } = user;
// otherProps = {age: 30, email: 'john@example.com'}
```

### Function Parameters

```javascript
function createUser({ name, age, email = "no-email" }) {
  return { name, age, email };
}

createUser({ name: "John", age: 30 });
```

## Spread Operator

### Array Spread

```javascript
const arr1 = [1, 2];
const arr2 = [3, 4];
const combined = [...arr1, ...arr2];
// [1, 2, 3, 4]

// Clone array
const copy = [...arr1];
```

### Object Spread

```javascript
const obj1 = { a: 1, b: 2 };
const obj2 = { c: 3, d: 4 };
const combined = { ...obj1, ...obj2 };
// {a: 1, b: 2, c: 3, d: 4}

// Override properties
const user = { name: "John", age: 30 };
const updatedUser = { ...user, age: 31 };
// {name: 'John', age: 31}
```

## Object Methods

### Object.keys()

```javascript
const obj = { a: 1, b: 2, c: 3 };
Object.keys(obj);
// ['a', 'b', 'c']
```

### Object.values()

```javascript
const obj = { a: 1, b: 2, c: 3 };
Object.values(obj);
// [1, 2, 3]
```

### Object.entries()

```javascript
const obj = { a: 1, b: 2, c: 3 };
Object.entries(obj);
// [['a', 1], ['b', 2], ['c', 3]]

// Use in for...of
for (const [key, value] of Object.entries(obj)) {
  console.log(`${key}: ${value}`);
}
```

### Object.fromEntries()

```javascript
const entries = [
  ["a", 1],
  ["b", 2],
];
Object.fromEntries(entries);
// {a: 1, b: 2}
```

### Object.assign()

```javascript
const target = { a: 1 };
const source = { b: 2, c: 3 };
Object.assign(target, source);
// target is now {a: 1, b: 2, c: 3}
```

## String Methods

### Template Literals

```javascript
const name = "John";
const age = 30;
const message = `Hello, ${name}! You are ${age} years old.`;
```

### includes()

```javascript
const str = "Hello World";
str.includes("World"); // true
str.includes("world"); // false
```

### startsWith() / endsWith()

```javascript
const str = "Hello World";
str.startsWith("Hello"); // true
str.endsWith("World"); // true
```

### split()

```javascript
const str = "a,b,c";
str.split(","); // ['a', 'b', 'c']
```

### trim()

```javascript
const str = "  hello  ";
str.trim(); // 'hello'
str.trimStart(); // 'hello  '
str.trimEnd(); // '  hello'
```

### replace() / replaceAll()

```javascript
const str = "hello world";
str.replace("world", "there"); // 'hello there'

const str2 = "a b a b";
str2.replaceAll("a", "x"); // 'x b x b'
```

## Optional Chaining

```javascript
const user = {
  name: "John",
  address: {
    city: "NYC",
  },
};

// Safe access
const city = user?.address?.city; // 'NYC'
const zip = user?.address?.zip; // undefined (no error)

// With functions
const result = obj.method?.(); // Only calls if method exists

// With arrays
const item = arr?.[0]; // Safe array access
```

## Nullish Coalescing

```javascript
const value = null ?? "default"; // 'default'
const value2 = undefined ?? "default"; // 'default'
const value3 = 0 ?? "default"; // 0 (not default!)
const value4 = "" ?? "default"; // '' (not default!)

// vs OR operator
const a = 0 || "default"; // 'default'
const b = 0 ?? "default"; // 0
```

## setTimeout / setInterval


### Creating Regex

```javascript
// Literal syntax
const regex1 = /hello/i; // Case-insensitive
const regex2 = /\d+/g; // Global flag (all matches)

// Constructor
const regex3 = new RegExp("hello", "i");

// Common flags
// i - case-insensitive
// g - global (all matches)
// m - multiline
// s - dotAll (. matches newline)
// u - unicode
// y - sticky (continue from last match)
```

### Pattern Matching

```javascript
const email = /^\S+@\S+\.\S+$/;
const password = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$/; // Min 8 chars, upper, lower, digit

const text = "Hello 123 World";

// Test (returns boolean)
text.match(/\d+/); // ['123']
text.replace(/\d+/g, "X"); // 'Hello X World'
text.search(/\d+/); // 6 (index)

// Exec (returns match object)
const regex = /(\d+)-(\d+)/g;
const result = regex.exec("123-456");
// result = ['123-456', '123', '456', ...]
```

### Common Patterns

```javascript
// Email validation
const emailRegex = /^\S+@\S+\.\S+$/;

// URL
const urlRegex = /^https?:\/\/.+/;

// Phone number (US format)
const phoneRegex = /^\(\d{3}\)-\d{3}-\d{4}$/; // (123)-456-7890

// Capture groups
const dateRegex = /(\d{4})-(\d{2})-(\d{2})/;
const date = "2024-01-12";
const [full, year, month, day] = dateRegex.exec(date);
// year = '2024', month = '01', day = '12'

// Replace with capture groups
const text = "John-Doe";
text.replace(/(\w+)-(\w+)/, "$2, $1"); // 'Doe, John'
```

## Error Handling

### try/catch/finally

```javascript
try {
  // Code that might throw
  const data = JSON.parse(invalidJSON);
  throw new Error("Custom error");
} catch (error) {
  // Handle error
  console.error("Caught:", error.message);
} finally {
  // Always runs (cleanup)
  console.log("Cleanup");
}

// Specific error handling
try {
  riskyOperation();
} catch (error) {
  if (error instanceof TypeError) {
    console.log("Type error:", error);
  } else if (error instanceof ReferenceError) {
    console.log("Reference error:", error);
  } else {
    console.log("Unknown error:", error);
  }
}
```

### Custom Errors

```javascript
class ValidationError extends Error {
  constructor(message, field) {
    super(message);
    this.name = "ValidationError";
    this.field = field;
  }
}

function validateEmail(email) {
  if (!email.includes("@")) {
    throw new ValidationError("Invalid email format", "email");
  }
}

try {
  validateEmail("invalid");
} catch (error) {
  if (error instanceof ValidationError) {
    console.log(`Field ${error.field}: ${error.message}`);
  }
}
```

## WeakMap & WeakSet

Collections that hold weak references (garbage collected when no other references exist).

```javascript
// WeakMap - keys must be objects
const privateData = new WeakMap();

const user = { name: "John" };
privateData.set(user, { password: "secret", role: "admin" });

console.log(privateData.get(user)); // { password: 'secret', role: 'admin' }
console.log(privateData.has(user)); // true
privateData.delete(user);

// When user is garbage collected, private data is freed

// WeakSet - only unique object references
const visitedObjects = new WeakSet();
const obj1 = { id: 1 };
const obj2 = { id: 2 };

visitedObjects.add(obj1);
visitedObjects.has(obj1); // true
visitedObjects.has(obj2); // false
```

## Symbols

Unique, immutable identifiers. Useful for object properties that won't clash.

```javascript
// Create symbol
const userId = Symbol("userId");
const userName = Symbol("userName");

// Use as object key
const user = {
  [userId]: 123,
  [userName]: "John",
  name: "John", // Regular property
};

console.log(user[userId]); // 123
console.log(user.name); // 'John'

// Symbols not enumerated
for (const key in user) {
  console.log(key); // Only 'name' (not symbols)
}

// Well-known symbols
const obj = {
  [Symbol.iterator]() {
    // Make object iterable
  },
  [Symbol.toString]() {
    return "Custom";
  },
};
```

## Proxy & Reflect

Meta-programming: intercept and customize operations on objects.

```javascript
// Proxy - intercept operations
const target = { name: "John", age: 30 };

const handler = {
  get(target, property) {
    console.log(`Getting ${property}`);
    return target[property];
  },
  set(target, property, value) {
    console.log(`Setting ${property} to ${value}`);
    if (property === "age" && value < 0) {
      throw new Error("Age cannot be negative");
    }
    target[property] = value;
    return true;
  },
};

const proxy = new Proxy(target, handler);
proxy.name; // Getting name
proxy.age = 31; // Setting age to 31
// proxy.age = -5;  // Error: Age cannot be negative

// Reflect - mirror of proxy handlers
const obj = { x: 1 };
Reflect.get(obj, "x"); // 1
Reflect.set(obj, "x", 2); // true
Reflect.has(obj, "x"); // true
Reflect.deleteProperty(obj, "x"); // true
Reflect.ownKeys(obj); // []
```

## Generators

Functions that can pause and resume execution.

```javascript
// Generator function
function* generateSequence() {
  yield 1;
  yield 2;
  yield 3;
}

const gen = generateSequence();
console.log(gen.next()); // { value: 1, done: false }
console.log(gen.next()); // { value: 2, done: false }
console.log(gen.next()); // { value: 3, done: false }
console.log(gen.next()); // { value: undefined, done: true }

// Used with for...of
for (const value of generateSequence()) {
  console.log(value); // 1, 2, 3
}

// Async generator
async function* fetchData() {
  for (let i = 1; i <= 3; i++) {
    const data = await fetch(`/api/item/${i}`).then((r) => r.json());
    yield data;
  }
}
```

## Closures

A function that remembers variables from its outer scope.

```javascript
function makeCounter() {
  let count = 0; // Private variable

  return {
    increment() {
      return ++count;
    },
    decrement() {
      return --count;
    },
    getCount() {
      return count;
    },
  };
}

const counter = makeCounter();
counter.increment(); // 1
counter.increment(); // 2
counter.decrement(); // 1
counter.getCount(); // 1

// Common closure gotcha
const functions = [];
for (var i = 0; i < 3; i++) {
  functions.push(() => i); // All reference same 'i'
}
console.log(functions[0]()); // 3 (not 0!)

// Fix: use let or IIFE
for (let i = 0; i < 3; i++) {
  functions.push(() => i); // Each has own 'i'
}
```

## Event Loop

Understanding how JavaScript handles async operations.

```javascript
// Call stack, microtask queue, macrotask queue

console.log("Start"); // Synchronous

setTimeout(() => {
  console.log("setTimeout"); // Macrotask
}, 0);

Promise.resolve()
  .then(() => console.log("Promise 1")) // Microtask
  .then(() => console.log("Promise 2"));

console.log("End"); // Synchronous

// Output order:
// Start
// End
// Promise 1
// Promise 2
// setTimeout

// Microtasks (higher priority):
// Promises, async/await, queueMicrotask

// Macrotasks:
// setTimeout, setInterval, setImmediate, I/O, UI rendering
```

## this Binding

Understanding how `this` works in different contexts.

```javascript
// Regular function - this is caller
const person = {
  name: "John",
  greet() {
    console.log(this.name); // John
  },
};
person.greet(); // John

// Arrow function - this is lexical (inherited from parent)
const person2 = {
  name: "Jane",
  greet: () => {
    console.log(this.name); // undefined (global this)
  },
};

// call(), apply(), bind() - explicit binding
function introduce(greeting) {
  console.log(`${greeting}, I'm ${this.name}`);
}

const user = { name: "Bob" };

introduce.call(user, "Hello"); // Hello, I'm Bob
introduce.apply(user, ["Hi"]); // Hi, I'm Bob
const greetBob = introduce.bind(user, "Hey");
greetBob(); // Hey, I'm Bob
```

## Equality

```javascript
// == vs === vs Object.is()

console.log(0 == "0"); // true (type coercion)
console.log(0 === "0"); // false (strict equality)
console.log(Object.is(0, "0")); // false

console.log(NaN == NaN); // false
console.log(NaN === NaN); // false
console.log(Object.is(NaN, NaN)); // true (special case)

console.log(-0 === +0); // true
console.log(Object.is(-0, +0)); // false (differentiates)

// Best practice: use === (strict equality) always
```
````
