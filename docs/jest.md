*jest.txt*  Jest Reference

==============================================================================
CONTENTS                                                        *jest-contents*

1. Installation & Setup .................. |jest-installation|
2. Configuration ......................... |jest-configuration|
   - jest.config.js ...................... |jest-config-file|
   - Common Options ...................... |jest-config-options|
3. Test Basics ........................... |jest-basics|
   - describe ............................ |jest-describe|
   - test / it ........................... |jest-test|
   - beforeEach / afterEach .............. |jest-beforeeach|
   - beforeAll / afterAll ................ |jest-beforeall|
4. Assertions ............................ |jest-assertions|
   - Basic Assertions .................... |jest-assertions-basic|
   - Truthiness .......................... |jest-assertions-truthiness|
   - Number Comparisons .................. |jest-assertions-numbers|
   - String Matching ..................... |jest-assertions-strings|
   - Arrays & Objects .................... |jest-assertions-arrays|
   - Exceptions .......................... |jest-assertions-exceptions|
   - Async ............................... |jest-assertions-async|
5. Mocking ............................... |jest-mocking|
   - jest.fn() ........................... |jest-fn|
   - jest.mock() ......................... |jest-mock|
   - jest.spyOn() ........................ |jest-spyon|
6. Async Testing ......................... |jest-async|
   - Callbacks ........................... |jest-async-callbacks|
   - Promises ............................ |jest-async-promises|
   - Async/Await ......................... |jest-async-await|
   - Fake Timers ......................... |jest-async-timers|
7. Coverage .............................. |jest-coverage|
8. Commands .............................. |jest-commands|
9. Common Patterns ....................... |jest-patterns|

==============================================================================
1. INSTALLATION & SETUP                                   *jest-installation*

Install Jest and setup test environment.~              *jest-installation-npm*
>
    # Install
    npm install --save-dev jest

    # Install with React Testing Library
    npm install --save-dev jest @testing-library/react @testing-library/jest-dom

    # Install with TypeScript support
    npm install --save-dev jest ts-jest @types/jest

    # Initialize config
    npx jest --init
<

==============================================================================
2. CONFIGURATION                                          *jest-configuration*

jest.config.js~                                            *jest-config-file*
>
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
<

Common Options~                                          *jest-config-options*
>
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
<

==============================================================================
3. TEST BASICS                                                  *jest-basics*

describe~                                                      *jest-describe*
>
    Group related tests together.

    describe("Calculator", () => {
      // Nested describes
      describe("addition", () => {
        test("adds positive numbers", () => {
          expect(1 + 2).toBe(3);
        });
      });
    });
<

test / it~                                                         *jest-test*
>
    Individual test case.

    // test and it are aliases
    test("adds 1 + 2 to equal 3", () => {
      expect(1 + 2).toBe(3);
    });

    it("should add numbers", () => {
      expect(1 + 2).toBe(3);
    });
<

beforeEach / afterEach~                                      *jest-beforeeach*
>
    Run before/after each test.

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
<

beforeAll / afterAll~                                          *jest-beforeall*
>
    Run before/after all tests in suite.

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
<

==============================================================================
4. ASSERTIONS                                                *jest-assertions*

Basic Assertions~                                      *jest-assertions-basic*
>
    // Equality
    expect(1).toBe(1); // Strict equality (===)
    expect({ a: 1 }).toEqual({ a: 1 }); // Deep equality

    // Identity
    expect(obj).toBe(obj); // Same object reference
    expect([]).toBe([]); // False - different objects
    expect([]).toEqual([]); // True - same content
<

Truthiness~                                         *jest-assertions-truthiness*
>
    expect(true).toBeTruthy();
    expect(false).toBeFalsy();
    expect(null).toBeNull();
    expect(undefined).toBeUndefined();
    expect(1).toBeDefined();

    // Combining
    expect(value).toBeTruthy(); // true, 1, 'text', etc
    expect(value).toBeFalsy(); // false, 0, '', null, undefined
<

Number Comparisons~                                  *jest-assertions-numbers*
>
    expect(4).toBeGreaterThan(3);
    expect(3).toBeGreaterThanOrEqual(3);
    expect(2).toBeLessThan(3);
    expect(2).toBeLessThanOrEqual(2);

    // Floating point
    expect(0.1 + 0.2).toBeCloseTo(0.3);
    expect(0.1 + 0.2).toBeCloseTo(0.3, 5); // Decimal places
<

String Matching~                                     *jest-assertions-strings*
>
    expect("hello").toMatch("ell");
    expect("hello").toMatch(/ell/);
    expect("hello").toMatch(/^h/);

    // Containing
    expect("hello world").toContain("world");
    expect("hello world").not.toContain("test");

    // Exact
    expect("hello").toEqual("hello");
    expect("hello").not.toEqual("world");
<

Arrays & Objects~                                     *jest-assertions-arrays*
>
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
<

Exceptions~                                        *jest-assertions-exceptions*
>
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
<

Async~                                                  *jest-assertions-async*
>
    // Promise resolves
    expect(Promise.resolve(1)).resolves.toBe(1);

    // Promise rejects
    expect(Promise.reject(new Error())).rejects.toThrow();
<

==============================================================================
5. MOCKING                                                       *jest-mocking*

jest.fn()~                                                          *jest-fn*
>
    Create mock function.

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
<

jest.mock()~                                                      *jest-mock*
>
    Mock entire module.

    // api.js
    export const fetchUser = () => fetch("/api/user");

    // api.test.js
    jest.mock("./api");
    import { fetchUser } from "./api";

    test("mocks api", () => {
      fetchUser.mockReturnValue({ name: "John" });
      expect(fetchUser()).toEqual({ name: "John" });
    });

    // Manual mock
    jest.mock("./api", () => ({
      fetchUser: jest.fn(() => Promise.resolve({ name: "John" })),
      fetchPosts: jest.fn(() => Promise.resolve([])),
    }));
<

jest.spyOn()~                                                    *jest-spyon*
>
    Spy on existing function.

    const obj = {
      method: () => 42,
    };

    const spy = jest.spyOn(obj, "method");
    spy.mockReturnValue(100);

    obj.method();

    expect(spy).toHaveBeenCalled();
    expect(obj.method()).toBe(100);

    spy.mockRestore(); // Restore original
<

==============================================================================
6. ASYNC TESTING                                                 *jest-async*

Callbacks~                                              *jest-async-callbacks*
>
    test("callback", (done) => {
      function callback(data) {
        expect(data).toBe("done");
        done(); // Signal completion
      }

      fetchData(callback);
    });
<

Promises~                                                *jest-async-promises*
>
    test("promise resolves", () => {
      return expect(fetchData()).resolves.toEqual({});
    });

    test("promise rejects", () => {
      return expect(fetchData()).rejects.toThrow("Error");
    });
<

Async/Await~                                              *jest-async-await*
>
    test("async/await", async () => {
      const data = await fetchData();
      expect(data).toEqual({});
    });

    test("async error", async () => {
      await expect(fetchData()).rejects.toThrow();
    });
<

Fake Timers~                                              *jest-async-timers*
>
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
<

==============================================================================
7. COVERAGE                                                     *jest-coverage*

Generate and analyze code coverage.~                   *jest-coverage-commands*
>
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
<

==============================================================================
8. COMMANDS                                                     *jest-commands*

Common commands~                                          *jest-commands-list*
>
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
<

==============================================================================
9. COMMON PATTERNS                                              *jest-patterns*

Testing React Components~                            *jest-patterns-react*
>
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
<

Testing Async Functions~                              *jest-patterns-async*
>
    test("async function", async () => {
      const result = await asyncFunction();
      expect(result).toBe("done");
    });

    test("fetch data", async () => {
      const mock = jest.fn().mockResolvedValue({ id: 1 });
      const data = await mock();
      expect(data).toEqual({ id: 1 });
    });
<

Snapshot Testing~                                   *jest-patterns-snapshots*
>
    test('snapshot', () => {
      const component = render(<MyComponent />);
      expect(component).toMatchSnapshot();
    });

    // Update snapshots
    npm test -- -u
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
