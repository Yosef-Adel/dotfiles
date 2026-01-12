# Jest Reference

Quick reference for Jest (testing framework). Use `/` to search in vim.

## Table of Contents

- [Installation & Setup](#installation--setup)
- [Configuration](#configuration)
  - [jest.config.js](#jestconfigjs)
  - [Common Options](#common-options)
- [Test Basics](#test-basics)
  - [describe](#describe)
  - [test / it](#test--it)
  - [beforeEach / afterEach](#beforeeach--aftereach)
  - [beforeAll / afterAll](#beforeall--afterall)
- [Assertions](#assertions)
  - [Basic Assertions](#basic-assertions)
  - [Truthiness](#truthiness)
  - [Number Comparisons](#number-comparisons)
  - [String Matching](#string-matching)
  - [Arrays & Objects](#arrays--objects)
  - [Exceptions](#exceptions)
  - [Async](#async)
- [Mocking](#mocking)
  - [jest.fn()](#jestfn)
  - [jest.mock()](#jestmock)
  - [jest.spyOn()](#jestspyon)
- [Async Testing](#async-testing)
  - [Callbacks](#callbacks)
  - [Promises](#promises)
  - [Async/Await](#asyncawait)
  - [Fake Timers](#fake-timers)
- [Coverage](#coverage)
- [Commands](#commands)
- [Common Patterns](#common-patterns)

## Installation & Setup

Install Jest and setup test environment.

```bash
# Install
npm install --save-dev jest

# Install with React Testing Library
npm install --save-dev jest @testing-library/react @testing-library/jest-dom

# Install with TypeScript support
npm install --save-dev jest ts-jest @types/jest

# Initialize config
npx jest --init
```

## Configuration

### jest.config.js

```javascript
module.exports = {
  // Test environment
  testEnvironment: "jsdom", // Browser environment (React)
  testEnvironment: "node", // Node environment (default)

  // Setup files
  setupFilesAfterEnv: ["<rootDir>/jest.setup.js"],

  // Module paths
  moduleNameMapper: {
    "^@/(.*)$": "<rootDir>/src/$1",
    "\\.(css|less|scss|sass)$": "identity-obj-proxy",
  },

  // Transform files
  transform: {
    "^.+\\.(js|jsx)$": "babel-jest",
    "^.+\\.(ts|tsx)$": "ts-jest",
  },

  // Test match patterns
  testMatch: ["**/__tests__/**/*.(test|spec).js", "**/*.(test|spec).js"],

  // Coverage
  collectCoverage: true,
  collectCoverageFrom: [
    "src/**/*.{js,jsx,ts,tsx}",
    "!src/index.js",
    "!src/**/*.d.ts",
  ],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },

  // Ignore patterns
  testPathIgnorePatterns: ["/node_modules/", "/build/"],
  moduleFileExtensions: ["js", "jsx", "ts", "tsx", "json"],

  // Verbose output
  verbose: true,
};
```

### Common Options

```javascript
module.exports = {
  // Environment
  testEnvironment: "jsdom",

  // Test timeout (ms)
  testTimeout: 10000,
  testTimeout: 5000,

  // Max workers for parallel testing
  maxWorkers: "50%",
  maxWorkers: 4,

  // Setup
  setupFilesAfterEnv: ["<rootDir>/jest.setup.js"],

  // Watch mode options
  watchPlugins: [
    "jest-watch-typeahead/filename",
    "jest-watch-typeahead/testname",
  ],

  // Clear mocks between tests
  clearMocks: true,

  // Restore mocks between tests
  restoreMocks: true,

  // Snapshot format
  snapshotFormat: {
    escapeString: true,
    printBasicPrototype: true,
  },
};
```

## Test Basics

### describe

Group related tests together.

```javascript
describe("Calculator", () => {
  // Nested describes
  describe("addition", () => {
    test("adds positive numbers", () => {
      expect(1 + 2).toBe(3);
    });
  });
});
```

### test / it

Individual test case.

```javascript
// test and it are aliases
test("adds 1 + 2 to equal 3", () => {
  expect(1 + 2).toBe(3);
});

it("should add numbers", () => {
  expect(1 + 2).toBe(3);
});
```

### beforeEach / afterEach

Run before/after each test.

```javascript
describe("Database", () => {
  let db;

  beforeEach(() => {
    db = createConnection();
  });

  afterEach(() => {
    db.close();
  });

  test("query works", () => {
    expect(db.query("SELECT")).toBeDefined();
  });
});
```

### beforeAll / afterAll

Run before/after all tests in suite.

```javascript
describe("Database", () => {
  let db;

  beforeAll(() => {
    db = createConnection();
  });

  afterAll(() => {
    db.close();
  });

  test("query works", () => {
    expect(db.query("SELECT")).toBeDefined();
  });
});
```

## Assertions

### Basic Assertions

```javascript
// Equality
expect(1).toBe(1); // Strict equality (===)
expect({ a: 1 }).toEqual({ a: 1 }); // Deep equality

// Identity
expect(obj).toBe(obj); // Same object reference
expect([]).toBe([]); // False - different objects
expect([]).toEqual([]); // True - same content
```

### Truthiness

```javascript
expect(true).toBeTruthy();
expect(false).toBeFalsy();
expect(null).toBeNull();
expect(undefined).toBeUndefined();
expect(1).toBeDefined();

// Combining
expect(value).toBeTruthy(); // true, 1, 'text', etc
expect(value).toBeFalsy(); // false, 0, '', null, undefined
```

### Number Comparisons

```javascript
expect(4).toBeGreaterThan(3);
expect(3).toBeGreaterThanOrEqual(3);
expect(2).toBeLessThan(3);
expect(2).toBeLessThanOrEqual(2);

// Floating point
expect(0.1 + 0.2).toBeCloseTo(0.3);
expect(0.1 + 0.2).toBeCloseTo(0.3, 5); // Decimal places
```

### String Matching

```javascript
expect("hello").toMatch("ell");
expect("hello").toMatch(/ell/);
expect("hello").toMatch(/^h/);

// Containing
expect("hello world").toContain("world");
expect("hello world").not.toContain("test");

// Exact
expect("hello").toEqual("hello");
expect("hello").not.toEqual("world");
```

### Arrays & Objects

```javascript
// Arrays
expect([1, 2, 3]).toHaveLength(3);
expect([1, 2, 3]).toContain(2);
expect([1, 2, 3]).toEqual(expect.arrayContaining([2, 1]));

// Objects
expect({ a: 1, b: 2 }).toHaveProperty("a");
expect({ a: 1, b: 2 }).toHaveProperty("a", 1);
expect({ a: 1, b: 2 }).toEqual(expect.objectContaining({ a: 1 }));

// Instances
expect(new User()).toBeInstanceOf(User);
```

### Exceptions

```javascript
// Throw error
expect(() => {
  throw new Error("Test");
}).toThrow();

expect(() => {
  throw new Error("Test");
}).toThrow("Test");

expect(() => {
  throw new Error("Test");
}).toThrow(Error);

// Promise rejection
expect(Promise.reject(new Error("Test"))).rejects.toThrow();
```

### Async

```javascript
// Promise resolves
expect(Promise.resolve(1)).resolves.toBe(1);

// Promise rejects
expect(Promise.reject(new Error())).rejects.toThrow();
```

## Mocking

### jest.fn()

Create mock function.

```javascript
// Basic mock
const mockFn = jest.fn();
mockFn("hello");
expect(mockFn).toHaveBeenCalled();
expect(mockFn).toHaveBeenCalledWith("hello");
expect(mockFn).toHaveBeenCalledTimes(1);

// Mock return value
const mockFn = jest.fn(() => 42);
expect(mockFn()).toBe(42);

// Different returns
const mockFn = jest
  .fn()
  .mockReturnValueOnce(1)
  .mockReturnValueOnce(2)
  .mockReturnValue(3);

expect(mockFn()).toBe(1);
expect(mockFn()).toBe(2);
expect(mockFn()).toBe(3);

// Mock implementation
const mockFn = jest.fn((x) => x * 2);
expect(mockFn(5)).toBe(10);
```

### jest.mock()

Mock entire module.

```javascript
// api.js
export const fetchUser = () => fetch("/api/user");

// api.test.js
jest.mock("./api");
import { fetchUser } from "./api";

test("mocks api", () => {
  fetchUser.mockReturnValue({ name: "John" });
  expect(fetchUser()).toEqual({ name: "John" });
});
```

```javascript
// Manual mock
jest.mock("./api", () => ({
  fetchUser: jest.fn(() => Promise.resolve({ name: "John" })),
  fetchPosts: jest.fn(() => Promise.resolve([])),
}));
```

### jest.spyOn()

Spy on existing function.

```javascript
const obj = {
  method: () => 42,
};

const spy = jest.spyOn(obj, "method");
spy.mockReturnValue(100);

obj.method();

expect(spy).toHaveBeenCalled();
expect(obj.method()).toBe(100);

spy.mockRestore(); // Restore original
```

## Async Testing

### Callbacks

```javascript
test("callback", (done) => {
  function callback(data) {
    expect(data).toBe("done");
    done(); // Signal completion
  }

  fetchData(callback);
});
```

### Promises

```javascript
test("promise resolves", () => {
  return expect(fetchData()).resolves.toEqual({});
});

test("promise rejects", () => {
  return expect(fetchData()).rejects.toThrow("Error");
});
```

### Async/Await

```javascript
test("async/await", async () => {
  const data = await fetchData();
  expect(data).toEqual({});
});

test("async error", async () => {
  await expect(fetchData()).rejects.toThrow();
});
```

### Fake Timers

```javascript
test("fake timers", () => {
  jest.useFakeTimers();

  const callback = jest.fn();
  setTimeout(callback, 1000);

  expect(callback).not.toHaveBeenCalled();

  jest.runAllTimers();
  expect(callback).toHaveBeenCalled();

  jest.useRealTimers();
});

test("advance timers", () => {
  jest.useFakeTimers();

  const callback = jest.fn();
  setInterval(callback, 1000);

  jest.advanceTimersByTime(3000);
  expect(callback).toHaveBeenCalledTimes(3);

  jest.useRealTimers();
});
```

## Coverage

Generate and analyze code coverage.

```bash
# Run tests with coverage
npm test -- --coverage

# Coverage threshold
npm test -- --coverage --coverageThreshold='{"global":{"branches":80,"functions":80,"lines":80,"statements":80}}'

# Specific file
npm test -- --coverage src/myfile.js

# Coverage report formats
npm test -- --coverage --coverageReporters=text
npm test -- --coverage --coverageReporters=lcov
npm test -- --coverage --coverageReporters=html
```

## Commands

```bash
# Run all tests
npm test

# Watch mode
npm test -- --watch

# Run specific test file
npm test -- calculator.test.js

# Run tests matching pattern
npm test -- --testNamePattern="addition"

# Run with coverage
npm test -- --coverage

# Update snapshots
npm test -- -u

# Verbose output
npm test -- --verbose

# No coverage
npm test -- --no-coverage

# Show test files
npm test -- --listTests

# Debug
node --inspect-brk node_modules/.bin/jest --runInBand
```

## Common Patterns

### Testing React Components

```javascript
import { render, screen, fireEvent } from "@testing-library/react";
import Button from "./Button";

test("button click", () => {
  const handleClick = jest.fn();
  render(<Button onClick={handleClick}>Click me</Button>);

  fireEvent.click(screen.getByText("Click me"));

  expect(handleClick).toHaveBeenCalled();
});

test("displays text", () => {
  render(<Button>Click me</Button>);
  expect(screen.getByText("Click me")).toBeInTheDocument();
});
```

### Testing Async Functions

```javascript
test("async function", async () => {
  const result = await asyncFunction();
  expect(result).toBe("done");
});

test("fetch data", async () => {
  const mock = jest.fn().mockResolvedValue({ id: 1 });
  const data = await mock();
  expect(data).toEqual({ id: 1 });
});
```

### Snapshot Testing

```javascript
test('snapshot', () => {
  const component = render(<MyComponent />);
  expect(component).toMatchSnapshot();
});

// Update snapshots
npm test -- -u
```
