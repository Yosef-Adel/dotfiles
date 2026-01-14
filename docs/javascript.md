*javascript.txt*  JavaScript Reference

==============================================================================
CONTENTS                                              *javascript-contents*

1. Basics ................................ |javascript-basics|
2. Arrays ................................ |javascript-arrays|
3. Promises & Async ...................... |javascript-async|
4. Objects ............................... |javascript-objects|
5. Strings ............................... |javascript-strings|
6. Destructuring ......................... |javascript-destructuring|
7. Operators ............................. |javascript-operators|
8. Timers ................................ |javascript-timers|
9. Fetch API ............................. |javascript-fetch|
10. Error Handling ....................... |javascript-errors|
11. Modern Features ...................... |javascript-modern|
12. Closures & Scope ..................... |javascript-closures|
13. this Binding ......................... |javascript-this|

==============================================================================
1. Basics                                                  *javascript-basics*

Variables~                                             *javascript-variables*
>
    // let - block scoped, reassignable
    let count = 0;
    count = 1;

    // const - block scoped, not reassignable
    const name = 'John';
    const user = { name: 'John' };
    user.name = 'Jane';              // OK - object is mutable
    // user = {};                    // Error - can't reassign

    // var - function scoped, hoisted (avoid)
    var old = 'legacy';
<

Functions~                                             *javascript-functions*
>
    // Function declaration
    function add(a, b) {
      return a + b;
    }

    // Arrow function
    const multiply = (a, b) => a * b;
    const square = x => x * x;       // Single param, no parens needed
    const greet = () => 'Hello';     // No params

    // Arrow with block body
    const process = (data) => {
      const result = data * 2;
      return result;
    };

    // Function expression
    const subtract = function(a, b) {
      return a - b;
    };

    // Default parameters
    function greet(name = 'Guest') {
      return `Hello ${name}`;
    }

    // Rest parameters
    function sum(...numbers) {
      return numbers.reduce((a, b) => a + b, 0);
    }
    sum(1, 2, 3, 4);                 // 10
<

Classes~                                               *javascript-classes*
>
    class Person {
      constructor(name, age) {
        this.name = name;
        this.age = age;
      }

      greet() {
        return `Hello, I'm ${this.name}`;
      }

      static create(name) {
        return new Person(name, 0);
      }
    }

    const john = new Person('John', 30);
    john.greet();                    // "Hello, I'm John"

    // Inheritance
    class Employee extends Person {
      constructor(name, age, role) {
        super(name, age);
        this.role = role;
      }

      greet() {
        return `${super.greet()}, I'm a ${this.role}`;
      }
    }

    const emp = new Employee('Jane', 25, 'Developer');
<

Modules~                                               *javascript-modules*
>
    // Export
    export const PI = 3.14;
    export function add(a, b) { return a + b; }
    export class User {}

    // Default export
    export default function main() {}

    // Import
    import main from './main.js';
    import { add, PI } from './math.js';
    import { add as sum } from './math.js';
    import * as math from './math.js';

    // Re-export
    export { add } from './math.js';
    export * from './utils.js';
<

Control Flow~                                          *javascript-control-flow*
>
    // if/else
    if (condition) {
      // code
    } else if (other) {
      // code
    } else {
      // code
    }

    // Ternary
    const result = condition ? 'yes' : 'no';

    // switch
    switch (value) {
      case 'a':
        // code
        break;
      case 'b':
      case 'c':
        // code
        break;
      default:
        // code
    }

    // for loop
    for (let i = 0; i < 10; i++) {
      console.log(i);
    }

    // while loop
    while (condition) {
      // code
    }

    // do-while
    do {
      // code
    } while (condition);

    // for...of (values)
    for (const item of array) {
      console.log(item);
    }

    // for...in (keys)
    for (const key in object) {
      console.log(key, object[key]);
    }

    // break and continue
    for (let i = 0; i < 10; i++) {
      if (i === 5) break;            // Exit loop
      if (i === 3) continue;         // Skip iteration
    }
<

Operators~                                             *javascript-operators-basic*
>
    // Arithmetic
    +  -  *  /  %  **                // Add, subtract, multiply, divide, modulo, exponent

    // Comparison
    ===  !==                         // Strict equality (use these)
    ==   !=                          // Loose equality (avoid)
    >    <    >=    <=

    // Logical
    &&                               // AND
    ||                               // OR
    !                                // NOT

    // Unary
    typeof value                     // Type of value
    ++count                          // Increment
    --count                          // Decrement

    // Assignment
    =                                // Assign
    +=  -=  *=  /=                   // Compound assignment
    x += 5;                          // Same as: x = x + 5;
<

Truthy and Falsy~                                      *javascript-truthy-falsy*
    Falsy values: false, 0, '', null, undefined, NaN
    Everything else is truthy.
>
    if (value) {}                    // Truthy check

    // Common patterns
    const name = user.name || 'Guest';           // Default with ||
    const name = user.name ?? 'Guest';           // Default with ?? (only null/undefined)

    // Short-circuit evaluation
    user && user.greet();            // Only call if user exists
    isValid && save();               // Only save if valid
<

Type Checking~                                         *javascript-typeof*
>
    typeof 'hello';                  // 'string'
    typeof 42;                       // 'number'
    typeof true;                     // 'boolean'
    typeof undefined;                // 'undefined'
    typeof null;                     // 'object' (quirk)
    typeof {};                       // 'object'
    typeof [];                       // 'object' (use Array.isArray)
    typeof function() {};            // 'function'

    // Check for array
    Array.isArray([]);               // true
    Array.isArray({});               // false

    // Check for null
    value === null
<

==============================================================================
2. Arrays                                              *javascript-arrays*

map()~                                                 *javascript-map()*
    Transform each element. Returns new array.
>
    const doubled = [1, 2, 3].map(n => n * 2);
    // [2, 4, 6]

    const names = users.map(u => u.name);
<

filter()~                                              *javascript-filter()*
    Keep elements matching predicate. Returns new array.
>
    const evens = [1, 2, 3, 4].filter(n => n % 2 === 0);
    // [2, 4]

    const adults = users.filter(u => u.age >= 18);
<

reduce()~                                              *javascript-reduce()*
    Reduce to single value. Accumulator pattern.
>
    const sum = [1, 2, 3, 4].reduce((acc, n) => acc + n, 0);
    // 10

    const grouped = items.reduce((acc, item) => {
      acc[item.category] = acc[item.category] || [];
      acc[item.category].push(item);
      return acc;
    }, {});
<

find()~                                                *javascript-find()*
    Find first matching element. Returns element or undefined.
>
    const user = users.find(u => u.id === 5);
    const first = [1, 2, 3].find(n => n > 1);  // 2
<

findIndex()~                                           *javascript-findIndex()*
    Find index of first match. Returns index or -1.
>
    const idx = users.findIndex(u => u.id === 5);
<

some()~                                                *javascript-some()*
    Test if any element matches. Returns boolean.
>
    const hasAdults = users.some(u => u.age >= 18);
<

every()~                                               *javascript-every()*
    Test if all elements match. Returns boolean.
>
    const allAdults = users.every(u => u.age >= 18);
<

sort()~                                                *javascript-sort()*
    Sort in place. Mutates array.
>
    const nums = [3, 1, 4, 2];
    nums.sort((a, b) => a - b);        // [1, 2, 3, 4]
    nums.sort((a, b) => b - a);        // [4, 3, 2, 1]

    users.sort((a, b) => a.name.localeCompare(b.name));
<

slice()~                                               *javascript-slice()*
    Extract portion. Returns new array.
>
    const arr = [1, 2, 3, 4, 5];
    arr.slice(1, 3);         // [2, 3]
    arr.slice(2);            // [3, 4, 5]
    arr.slice(-2);           // [4, 5]
<

splice()~                                              *javascript-splice()*
    Add/remove elements. Mutates array.
>
    const arr = [1, 2, 3, 4];
    arr.splice(1, 2);        // Remove 2 elements at index 1
    arr.splice(1, 0, 'a');   // Insert 'a' at index 1
    arr.splice(1, 1, 'b');   // Replace element at index 1
<

flat()~                                                *javascript-flat()*
    Flatten nested arrays.
>
    [1, [2, 3], [4, [5]]].flat();       // [1, 2, 3, 4, [5]]
    [1, [2, [3]]].flat(2);              // [1, 2, 3]
    [1, [2, [3]]].flat(Infinity);       // [1, 2, 3]
<

flatMap()~                                             *javascript-flatMap()*
    Map then flatten one level.
>
    ['hello', 'world'].flatMap(s => s.split(''));
    // ['h','e','l','l','o','w','o','r','l','d']
<

includes()~                                            *javascript-includes()*
    Check if array contains value.
>
    [1, 2, 3].includes(2);               // true
    ['a', 'b'].includes('c');            // false
<

join()~                                                *javascript-join()*
    Join elements into string.
>
    [1, 2, 3].join(', ');                // '1, 2, 3'
    ['a', 'b', 'c'].join('');            // 'abc'
<

concat()~                                              *javascript-concat()*
    Combine arrays. Returns new array.
>
    [1, 2].concat([3, 4]);               // [1, 2, 3, 4]
    [1].concat(2, [3, 4]);               // [1, 2, 3, 4]
<

push()~                                                *javascript-push()*
    Add element(s) to end. Mutates array. Returns new length.
>
    const arr = [1, 2];
    arr.push(3);                         // arr is [1, 2, 3]
    arr.push(4, 5);                      // arr is [1, 2, 3, 4, 5]
<

pop()~                                                 *javascript-pop()*
    Remove last element. Mutates array. Returns removed element.
>
    const arr = [1, 2, 3];
    const last = arr.pop();              // last is 3, arr is [1, 2]
<

unshift()~                                             *javascript-unshift()*
    Add element(s) to beginning. Mutates array. Returns new length.
>
    const arr = [2, 3];
    arr.unshift(1);                      // arr is [1, 2, 3]
    arr.unshift(-1, 0);                  // arr is [-1, 0, 1, 2, 3]
<

shift()~                                               *javascript-shift()*
    Remove first element. Mutates array. Returns removed element.
>
    const arr = [1, 2, 3];
    const first = arr.shift();           // first is 1, arr is [2, 3]
<

forEach()~                                             *javascript-forEach()*
    Execute function for each element. No return value.
>
    [1, 2, 3].forEach((item, index) => {
      console.log(index, item);
    });

    users.forEach(user => console.log(user.name));
<

indexOf()~                                             *javascript-indexOf()*
    Find index of element. Returns -1 if not found.
>
    const arr = ['a', 'b', 'c', 'b'];
    arr.indexOf('b');                    // 1 (first occurrence)
    arr.indexOf('d');                    // -1 (not found)
    arr.indexOf('b', 2);                 // 3 (start from index 2)
<

lastIndexOf()~                                         *javascript-lastIndexOf()*
    Find last index of element. Returns -1 if not found.
>
    const arr = ['a', 'b', 'c', 'b'];
    arr.lastIndexOf('b');                // 3 (last occurrence)
<

reverse()~                                             *javascript-reverse()*
    Reverse array in place. Mutates array.
>
    const arr = [1, 2, 3];
    arr.reverse();                       // arr is [3, 2, 1]
<

Array.isArray()~                                       *javascript-Array.isArray()*
    Check if value is an array.
>
    Array.isArray([]);                   // true
    Array.isArray({});                   // false
    Array.isArray('string');             // false
<

Array.from()~                                          *javascript-Array.from()*
    Create array from iterable or array-like object.
>
    Array.from('hello');                 // ['h', 'e', 'l', 'l', 'o']
    Array.from([1, 2, 3], x => x * 2);   // [2, 4, 6]
    Array.from({ length: 3 }, (_, i) => i);  // [0, 1, 2]
<

==============================================================================
2. Promises & Async                                    *javascript-async*

Promise Basics~                                        *javascript-promise*
>
    const promise = new Promise((resolve, reject) => {
      if (success) {
        resolve(value);
      } else {
        reject(error);
      }
    });

    promise
      .then(result => console.log(result))
      .catch(error => console.error(error))
      .finally(() => console.log('Done'));
<

async/await~                                           *javascript-async-await*
>
    async function fetchUser(id) {
      const response = await fetch(`/api/users/${id}`);
      const data = await response.json();
      return data;
    }

    // Error handling
    async function getUser(id) {
      try {
        const user = await fetchUser(id);
        return user;
      } catch (error) {
        console.error(error);
        return null;
      }
    }
<

Promise.all()~                                         *javascript-Promise.all()*
    Wait for all promises. Fails if any fails.
>
    const [users, posts, comments] = await Promise.all([
      fetch('/users').then(r => r.json()),
      fetch('/posts').then(r => r.json()),
      fetch('/comments').then(r => r.json())
    ]);
<

Promise.race()~                                        *javascript-Promise.race()*
    First to complete wins.
>
    const result = await Promise.race([
      fetch('/api/fast'),
      fetch('/api/slow')
    ]);
<

Promise.allSettled()~                                  *javascript-Promise.allSettled()*
    Wait for all, never fails.
>
    const results = await Promise.allSettled([
      fetch('/api/1'),
      fetch('/api/2'),
      fetch('/api/3')
    ]);

    results.forEach(result => {
      if (result.status === 'fulfilled') {
        console.log(result.value);
      } else {
        console.error(result.reason);
      }
    });
<

Promise.any()~                                         *javascript-Promise.any()*
    First successful promise.
>
    const first = await Promise.any([
      fetch('/api/1'),
      fetch('/api/2')
    ]);
<

==============================================================================
3. Objects                                             *javascript-objects*

Object Literals~                                       *javascript-object-literals*
>
    // Creating objects
    const user = {
      name: 'John',
      age: 30,
      email: 'john@example.com'
    };

    // Empty object
    const empty = {};

    // Computed property names
    const key = 'name';
    const obj = {
      [key]: 'John',
      ['user_' + 123]: 'value'
    };

    // Shorthand property names
    const name = 'John';
    const age = 30;
    const user = { name, age };          // Same as { name: name, age: age }
<

Property Access~                                       *javascript-property-access*
>
    const user = { name: 'John', age: 30 };

    // Dot notation (preferred)
    user.name;                           // 'John'
    user.age;                            // 30

    // Bracket notation (for dynamic access)
    user['name'];                        // 'John'
    const key = 'age';
    user[key];                           // 30

    // Bracket notation required for:
    const obj = {
      'first-name': 'John',              // Hyphenated keys
      'user name': 'Jane',               // Spaces in keys
      123: 'numeric key'                 // Numeric keys
    };
    obj['first-name'];
    obj['user name'];
    obj[123];

    // Nested access
    user.address.city;
    user['address']['city'];
<

Method Definitions~                                    *javascript-methods*
>
    // Method shorthand (ES6)
    const user = {
      name: 'John',
      greet() {
        return `Hello, I'm ${this.name}`;
      },
      sayAge() {
        return `I'm ${this.age}`;
      }
    };

    user.greet();                        // "Hello, I'm John"

    // Traditional function
    const user2 = {
      name: 'Jane',
      greet: function() {
        return `Hello, I'm ${this.name}`;
      }
    };

    // Arrow functions (no 'this' binding)
    const obj = {
      name: 'John',
      greet: () => {
        // 'this' refers to outer scope, not obj
        return 'Hello';
      }
    };
<

Getters and Setters~                                   *javascript-getters-setters*
>
    const user = {
      firstName: 'John',
      lastName: 'Doe',

      // Getter
      get fullName() {
        return `${this.firstName} ${this.lastName}`;
      },

      // Setter
      set fullName(value) {
        [this.firstName, this.lastName] = value.split(' ');
      }
    };

    user.fullName;                       // 'John Doe' (calls getter)
    user.fullName = 'Jane Smith';        // Calls setter
    user.firstName;                      // 'Jane'

    // In classes
    class Temperature {
      constructor(celsius) {
        this._celsius = celsius;
      }

      get fahrenheit() {
        return this._celsius * 1.8 + 32;
      }

      set fahrenheit(value) {
        this._celsius = (value - 32) / 1.8;
      }
    }

    const temp = new Temperature(0);
    temp.fahrenheit;                     // 32
    temp.fahrenheit = 68;
    temp._celsius;                       // 20
<

Object.keys()~                                         *javascript-Object.keys()*
    Get object keys as array.
>
    const obj = { a: 1, b: 2, c: 3 };
    Object.keys(obj);                    // ['a', 'b', 'c']
<

Object.values()~                                       *javascript-Object.values()*
    Get object values as array.
>
    Object.values(obj);                  // [1, 2, 3]
<

Object.entries()~                                      *javascript-Object.entries()*
    Get key-value pairs as array of arrays.
>
    Object.entries(obj);                 // [['a',1], ['b',2], ['c',3]]

    for (const [key, value] of Object.entries(obj)) {
      console.log(key, value);
    }
<

Object.fromEntries()~                                  *javascript-Object.fromEntries()*
    Convert entries to object.
>
    const entries = [['a', 1], ['b', 2]];
    Object.fromEntries(entries);         // { a: 1, b: 2 }
<

Object.assign()~                                       *javascript-Object.assign()*
    Merge objects. Mutates target.
>
    const target = { a: 1 };
    Object.assign(target, { b: 2 }, { c: 3 });
    // target is now { a: 1, b: 2, c: 3 }

    // Copy object
    const copy = Object.assign({}, original);
<

Spread Operator~                                       *javascript-spread-object*
    Copy/merge objects. Prefer over Object.assign.
>
    const merged = { ...obj1, ...obj2 };
    const copy = { ...original };
    const updated = { ...user, name: 'John' };
<

Object.freeze()~                                       *javascript-Object.freeze()*
    Make object immutable (shallow).
>
    const obj = Object.freeze({ name: 'John', age: 30 });
    obj.age = 31;                        // Fails silently (strict mode: error)
    obj.name = 'Jane';                   // Fails silently
<

Object.seal()~                                         *javascript-Object.seal()*
    Prevent adding/removing properties. Can modify existing.
>
    const obj = Object.seal({ name: 'John', age: 30 });
    obj.age = 31;                        // OK - can modify
    obj.email = 'a@b.com';               // Fails - can't add
    delete obj.age;                      // Fails - can't delete
<

Object.hasOwnProperty()~                               *javascript-hasOwnProperty()*
    Check if object has own property (not inherited).
>
    const obj = { name: 'John' };
    obj.hasOwnProperty('name');          // true
    obj.hasOwnProperty('toString');      // false (inherited)
<

JSON~                                                  *javascript-JSON*
>
    // Convert to JSON string
    const json = JSON.stringify({ name: 'John', age: 30 });
    // '{"name":"John","age":30}'

    // With formatting
    JSON.stringify(obj, null, 2);        // Pretty print with 2 spaces

    // Parse JSON string
    const obj = JSON.parse('{"name":"John","age":30}');

    // Handle errors
    try {
      const obj = JSON.parse(invalidJson);
    } catch (error) {
      console.error('Invalid JSON');
    }
<

==============================================================================
4. Strings                                             *javascript-strings*

Template Literals~                                     *javascript-template-literals*
>
    const name = 'John';
    const greeting = `Hello, ${name}!`;

    const multiline = `
      Line 1
      Line 2
    `;
<

includes()~                                            *javascript-String.includes()*
    Check if string contains substring.
>
    'hello world'.includes('world');     // true
    'hello'.includes('x');               // false
<

startsWith()~                                          *javascript-startsWith()*
endsWith()~                                            *javascript-endsWith()*
>
    'hello world'.startsWith('hello');   // true
    'hello world'.endsWith('world');     // true
<

split()~                                               *javascript-split()*
    Split string into array.
>
    'a,b,c'.split(',');                  // ['a', 'b', 'c']
    'hello'.split('');                   // ['h','e','l','l','o']
<

trim()~                                                *javascript-trim()*
    Remove whitespace from both ends.
>
    '  hello  '.trim();                  // 'hello'
    '  hello  '.trimStart();             // 'hello  '
    '  hello  '.trimEnd();               // '  hello'
<

replace()~                                             *javascript-replace()*
replaceAll()~                                          *javascript-replaceAll()*
>
    'hello world'.replace('world', 'there');
    // 'hello there'

    'a-b-c'.replaceAll('-', '_');
    // 'a_b_c'
<

padStart()~                                            *javascript-padStart()*
padEnd()~                                              *javascript-padEnd()*
>
    '5'.padStart(3, '0');                // '005'
    '5'.padEnd(3, '0');                  // '500'
<

repeat()~                                              *javascript-repeat()*
>
    'ha'.repeat(3);                      // 'hahaha'
<

charAt()~                                              *javascript-charAt()*
    Get character at index.
>
    'hello'.charAt(0);                   // 'h'
    'hello'.charAt(1);                   // 'e'
    'hello'[0];                          // 'h' (alternative)
<

charCodeAt()~                                          *javascript-charCodeAt()*
    Get character code at index.
>
    'A'.charCodeAt(0);                   // 65
    'hello'.charCodeAt(0);               // 104
<

indexOf()~                                             *javascript-String.indexOf()*
    Find index of substring. Returns -1 if not found.
>
    'hello world'.indexOf('world');      // 6
    'hello world'.indexOf('foo');        // -1
    'hello hello'.indexOf('hello', 1);   // 6 (start from index 1)
<

lastIndexOf()~                                         *javascript-String.lastIndexOf()*
    Find last index of substring.
>
    'hello hello'.lastIndexOf('hello');  // 6
<

slice()~                                               *javascript-String.slice()*
    Extract portion of string.
>
    'hello world'.slice(0, 5);           // 'hello'
    'hello world'.slice(6);              // 'world'
    'hello world'.slice(-5);             // 'world'
<

substring()~                                           *javascript-substring()*
    Extract portion of string. Similar to slice.
>
    'hello world'.substring(0, 5);       // 'hello'
    'hello world'.substring(6);          // 'world'
<

toLowerCase()~                                         *javascript-toLowerCase()*
toUpperCase()~                                         *javascript-toUpperCase()*
>
    'Hello World'.toLowerCase();         // 'hello world'
    'Hello World'.toUpperCase();         // 'HELLO WORLD'
<

concat()~                                              *javascript-String.concat()*
    Concatenate strings. Prefer template literals.
>
    'hello'.concat(' ', 'world');        // 'hello world'
    'a'.concat('b', 'c');                // 'abc'
<

match()~                                               *javascript-match()*
    Match against regex. Returns array or null.
>
    'hello 123 world 456'.match(/\d+/);  // ['123']
    'hello 123 world 456'.match(/\d+/g); // ['123', '456']
<

search()~                                              *javascript-search()*
    Search with regex. Returns index or -1.
>
    'hello world'.search(/world/);       // 6
    'hello world'.search(/foo/);         // -1
<

==============================================================================
5. Destructuring                                       *javascript-destructuring*

Array Destructuring~                                   *javascript-destructuring-array*
>
    const [a, b] = [1, 2];
    const [first, ...rest] = [1, 2, 3, 4];
    // first = 1, rest = [2, 3, 4]

    // Skip elements
    const [, , third] = [1, 2, 3];

    // Default values
    const [x = 10, y = 20] = [5];
    // x = 5, y = 20

    // Swap
    [a, b] = [b, a];
<

Object Destructuring~                                  *javascript-destructuring-object*
>
    const { name, age } = user;

    // Rename
    const { name: userName, age: userAge } = user;

    // Default values
    const { name = 'Anonymous', age = 0 } = user;

    // Nested
    const { address: { city, zip } } = user;

    // Rest
    const { id, ...rest } = user;
<

Function Parameters~                                   *javascript-destructuring-params*
>
    function greet({ name, age = 0 }) {
      console.log(`${name} is ${age}`);
    }

    greet({ name: 'John', age: 30 });
<

==============================================================================
6. Operators                                           *javascript-operators*

Spread~                                                *javascript-spread*
>
    // Array
    const arr = [1, 2, 3];
    const arr2 = [...arr, 4, 5];
    Math.max(...arr);

    // Object
    const obj = { ...obj1, ...obj2 };
<

Rest~                                                  *javascript-rest*
>
    function sum(...numbers) {
      return numbers.reduce((a, b) => a + b, 0);
    }

    sum(1, 2, 3, 4);                     // 10
<

Optional Chaining~                                     *javascript-optional-chaining*
>
    const city = user?.address?.city;
    const result = obj.method?.();
    const item = arr?.[0];
<

Nullish Coalescing~                                    *javascript-nullish-coalescing*
>
    const value = input ?? 'default';
    // Only 'default' if input is null/undefined

    const port = config.port ?? 3000;
    // 0 is valid, unlike ||

    // Assignment
    value ??= 10;
<

==============================================================================
7. Timers                                              *javascript-timers*

setTimeout()~                                          *javascript-setTimeout()*
>
    const id = setTimeout(() => {
      console.log('After 1 second');
    }, 1000);

    clearTimeout(id);

    // With parameters
    setTimeout((name) => console.log(name), 1000, 'John');
<

setInterval()~                                         *javascript-setInterval()*
>
    const id = setInterval(() => {
      console.log('Every second');
    }, 1000);

    clearInterval(id);
<

Debounce~                                              *javascript-debounce*
    Delay execution until after inactivity.
>
    function debounce(func, wait) {
      let timeout;
      return function(...args) {
        clearTimeout(timeout);
        timeout = setTimeout(() => func(...args), wait);
      };
    }

    const handleSearch = debounce(search, 300);
<

Throttle~                                              *javascript-throttle*
    Limit execution rate.
>
    function throttle(func, wait) {
      let inThrottle;
      return function(...args) {
        if (!inThrottle) {
          func.apply(this, args);
          inThrottle = true;
          setTimeout(() => inThrottle = false, wait);
        }
      };
    }

    const handleScroll = throttle(onScroll, 200);
<

==============================================================================
8. Fetch API                                           *javascript-fetch*

GET Request~                                           *javascript-fetch-get*
>
    const response = await fetch('/api/users');
    const data = await response.json();

    // With options
    const response = await fetch('/api/users', {
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer token'
      }
    });
<

POST Request~                                          *javascript-fetch-post*
>
    const response = await fetch('/api/users', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ name: 'John', age: 30 })
    });

    const data = await response.json();
<

Error Handling~                                        *javascript-fetch-error*
>
    try {
      const response = await fetch('/api/users');
      if (!response.ok) {
        throw new Error(`HTTP ${response.status}`);
      }
      const data = await response.json();
    } catch (error) {
      console.error('Fetch error:', error);
    }
<

==============================================================================
9. Error Handling                                      *javascript-errors*

try/catch/finally~                                     *javascript-try-catch*
>
    try {
      const result = riskyOperation();
    } catch (error) {
      console.error('Error:', error.message);
    } finally {
      cleanup();
    }
<

Custom Errors~                                         *javascript-custom-error*
>
    class ValidationError extends Error {
      constructor(message) {
        super(message);
        this.name = 'ValidationError';
      }
    }

    throw new ValidationError('Invalid input');
<

==============================================================================
10. Modern Features                                    *javascript-modern*

BigInt~                                                *javascript-BigInt*
    Arbitrary-precision integers.
>
    const big = 123456789012345678901234567890n;
    const big2 = BigInt('123456789012345678901234567890');

    const sum = 100n + 50n;
    const power = 2n ** 100n;

    // Cannot mix with Number
    10n + BigInt(5);                     // 15n
<

Dynamic Import~                                        *javascript-dynamic-import*
>
    const module = await import('./module.js');
    module.doSomething();

    // Conditional
    if (condition) {
      const { feature } = await import('./feature.js');
      feature();
    }
<

Private Fields~                                        *javascript-private-fields*
>
    class BankAccount {
      #balance = 0;

      deposit(amount) {
        this.#balance += amount;
      }

      getBalance() {
        return this.#balance;
      }
    }

    const account = new BankAccount();
    account.#balance;                    // SyntaxError
<

Top-level await~                                       *javascript-top-level-await*
    Use await outside async function (in modules).
>
    const config = await fetch('/config').then(r => r.json());
    export const apiUrl = config.apiUrl;
<

Numeric Separators~                                    *javascript-numeric-separators*
>
    const billion = 1_000_000_000;
    const bytes = 0b1111_1111_1111_1111;
    const hex = 0xFF_FF_FF_FF;
<

Generators~                                            *javascript-generators*
    Functions that can pause and resume execution.
>
    function* numberGenerator() {
      yield 1;
      yield 2;
      yield 3;
    }

    const gen = numberGenerator();
    gen.next();                      // { value: 1, done: false }
    gen.next();                      // { value: 2, done: false }
    gen.next();                      // { value: 3, done: false }
    gen.next();                      // { value: undefined, done: true }

    // Iterate with for...of
    for (const num of numberGenerator()) {
      console.log(num);              // 1, 2, 3
    }

    // Infinite generator
    function* idGenerator() {
      let id = 0;
      while (true) {
        yield id++;
      }
    }
<

Map~                                                   *javascript-Map*
    Key-value pairs. Keys can be any type.
>
    const map = new Map();
    map.set('name', 'John');
    map.set(123, 'numeric key');
    map.set({ id: 1 }, 'object key');

    map.get('name');                 // 'John'
    map.has('name');                 // true
    map.delete('name');
    map.size;                        // Number of entries
    map.clear();                     // Remove all

    // Iterate
    for (const [key, value] of map) {
      console.log(key, value);
    }

    map.forEach((value, key) => console.log(key, value));
<

Set~                                                   *javascript-Set*
    Collection of unique values.
>
    const set = new Set([1, 2, 3, 3, 3]);
    console.log(set);                // Set(3) {1, 2, 3}

    set.add(4);
    set.has(2);                      // true
    set.delete(2);
    set.size;                        // Number of elements
    set.clear();                     // Remove all

    // Iterate
    for (const value of set) {
      console.log(value);
    }

    // Convert to array
    const arr = [...set];
    const arr2 = Array.from(set);

    // Remove duplicates from array
    const unique = [...new Set([1, 2, 2, 3, 3])];  // [1, 2, 3]
<

Symbol~                                                *javascript-Symbol*
    Unique primitive value.
>
    const sym1 = Symbol('description');
    const sym2 = Symbol('description');
    sym1 === sym2;                   // false (always unique)

    // As object key
    const obj = {
      [sym1]: 'value',
      name: 'John'
    };

    obj[sym1];                       // 'value'
    Object.keys(obj);                // ['name'] (symbols not enumerable)

    // Well-known symbols
    Symbol.iterator
    Symbol.toStringTag
    Symbol.hasInstance
<

Proxy~                                                 *javascript-Proxy*
    Intercept and customize object operations.
>
    const target = { name: 'John', age: 30 };

    const handler = {
      get(target, prop) {
        console.log(`Getting ${prop}`);
        return target[prop];
      },
      set(target, prop, value) {
        console.log(`Setting ${prop} to ${value}`);
        target[prop] = value;
        return true;
      }
    };

    const proxy = new Proxy(target, handler);
    proxy.name;                      // Logs: Getting name
    proxy.age = 31;                  // Logs: Setting age to 31
<

Reflect~                                               *javascript-Reflect*
    Default object operations as functions.
>
    const obj = { name: 'John', age: 30 };

    Reflect.get(obj, 'name');        // 'John'
    Reflect.set(obj, 'age', 31);     // true
    Reflect.has(obj, 'name');        // true
    Reflect.deleteProperty(obj, 'age');

    // With Proxy
    const handler = {
      get(target, prop) {
        console.log(`Get ${prop}`);
        return Reflect.get(target, prop);
      }
    };
<

for...of vs for...in~                                 *javascript-for-of-in*
>
    const arr = ['a', 'b', 'c'];

    // for...of - iterates values
    for (const value of arr) {
      console.log(value);            // 'a', 'b', 'c'
    }

    // for...in - iterates keys/indices
    for (const index in arr) {
      console.log(index);            // '0', '1', '2'
    }

    const obj = { name: 'John', age: 30 };

    // for...in - iterates object keys
    for (const key in obj) {
      console.log(key, obj[key]);    // name John, age 30
    }

    // for...of with Object.entries
    for (const [key, value] of Object.entries(obj)) {
      console.log(key, value);
    }
<

Number Conversion~                                     *javascript-number-conversion*
>
    // parseInt - parse string to integer
    parseInt('123');                 // 123
    parseInt('123.45');              // 123 (truncates decimal)
    parseInt('123px');               // 123 (stops at non-digit)
    parseInt('abc');                 // NaN

    // With radix (base)
    parseInt('10', 10);              // 10 (decimal)
    parseInt('10', 2);               // 2 (binary)
    parseInt('ff', 16);              // 255 (hexadecimal)

    // parseFloat - parse string to floating point
    parseFloat('123.45');            // 123.45
    parseFloat('123.45.67');         // 123.45 (stops at second dot)
    parseFloat('123px');             // 123
    parseFloat('abc');               // NaN

    // Number() - convert to number
    Number('123');                   // 123
    Number('123.45');                // 123.45
    Number('');                      // 0
    Number(' ');                     // 0
    Number('abc');                   // NaN
    Number(true);                    // 1
    Number(false);                   // 0
    Number(null);                    // 0
    Number(undefined);               // NaN

    // Unary plus operator (shorthand)
    +'123';                          // 123
    +'123.45';                       // 123.45

    // Check for NaN
    isNaN('abc');                    // true
    Number.isNaN(NaN);               // true (more reliable)
    Number.isNaN('abc');             // false (doesn't coerce)

    // Convert to string
    String(123);                     // '123'
    (123).toString();                // '123'
    123 + '';                        // '123'
<

Math Object~                                           *javascript-Math*
>
    // Constants
    Math.PI;                         // 3.141592653589793
    Math.E;                          // 2.718281828459045

    // Rounding
    Math.round(4.5);                 // 5
    Math.round(4.4);                 // 4
    Math.ceil(4.1);                  // 5 (round up)
    Math.floor(4.9);                 // 4 (round down)
    Math.trunc(4.9);                 // 4 (remove decimal)

    // Min/Max
    Math.min(1, 5, 3);               // 1
    Math.max(1, 5, 3);               // 5
    Math.min(...[1, 5, 3]);          // 1 (with array)

    // Power and roots
    Math.pow(2, 3);                  // 8 (2³)
    2 ** 3;                          // 8 (exponentiation operator)
    Math.sqrt(16);                   // 4 (square root)
    Math.cbrt(27);                   // 3 (cube root)

    // Absolute value
    Math.abs(-5);                    // 5
    Math.abs(5);                     // 5

    // Random
    Math.random();                   // Random between 0 and 1
    Math.floor(Math.random() * 10);  // Random 0-9
    Math.floor(Math.random() * 100) + 1;  // Random 1-100

    // Trigonometry (radians)
    Math.sin(Math.PI / 2);           // 1
    Math.cos(0);                     // 1
    Math.tan(Math.PI / 4);           // 1

    // Sign
    Math.sign(-5);                   // -1
    Math.sign(0);                    // 0
    Math.sign(5);                    // 1
<

Date Object~                                           *javascript-Date*
>
    // Create dates
    const now = new Date();
    const date = new Date('2024-03-15');
    const date2 = new Date('2024-03-15T10:30:00');
    const date3 = new Date(2024, 2, 15);  // Month is 0-indexed (2 = March)
    const date4 = new Date(2024, 2, 15, 10, 30, 0);

    // Get components
    const date = new Date();
    date.getFullYear();              // 2024
    date.getMonth();                 // 0-11 (0 = January)
    date.getDate();                  // 1-31 (day of month)
    date.getDay();                   // 0-6 (0 = Sunday)
    date.getHours();                 // 0-23
    date.getMinutes();               // 0-59
    date.getSeconds();               // 0-59
    date.getMilliseconds();          // 0-999
    date.getTime();                  // Timestamp (ms since 1970)

    // Set components
    date.setFullYear(2025);
    date.setMonth(0);                // January
    date.setDate(15);
    date.setHours(10);
    date.setMinutes(30);

    // Format
    date.toString();                 // Full date string
    date.toDateString();             // 'Mon Jan 15 2024'
    date.toTimeString();             // '10:30:00 GMT+0000'
    date.toISOString();              // '2024-01-15T10:30:00.000Z'
    date.toLocaleDateString();       // '1/15/2024' (locale-dependent)
    date.toLocaleTimeString();       // '10:30:00 AM' (locale-dependent)

    // Timestamp
    Date.now();                      // Current timestamp
    new Date().getTime();            // Same as Date.now()

    // Calculate difference
    const diff = date2.getTime() - date1.getTime();
    const days = diff / (1000 * 60 * 60 * 24);

    // Compare dates
    date1 < date2;                   // true/false
    date1.getTime() === date2.getTime();  // Compare exact times
<

==============================================================================
11. Closures & Scope                                   *javascript-closures*

Closure~                                               *javascript-closure*
>
    function outer() {
      const count = 0;
      return function inner() {
        count++;
        return count;
      };
    }

    const counter = outer();
    counter();                           // 1
    counter();                           // 2
<

IIFE~                                                  *javascript-iife*
    Immediately Invoked Function Expression.
>
    (function() {
      const private = 'secret';
      console.log(private);
    })();

    // Arrow function
    (() => {
      console.log('IIFE');
    })();
<

Module Pattern~                                        *javascript-module-pattern*
>
    const module = (function() {
      let private = 0;

      return {
        increment() { private++; },
        getValue() { return private; }
      };
    })();

    module.increment();
    module.getValue();                   // 1
<

==============================================================================
12. this Binding                                       *javascript-this*

this in Methods~                                       *javascript-this-method*
>
    const obj = {
      name: 'John',
      greet() {
        console.log(this.name);          // 'John'
      }
    };
<

Arrow Functions~                                       *javascript-this-arrow*
    Inherit this from parent scope.
>
    const obj = {
      name: 'John',
      greet: () => {
        console.log(this.name);          // undefined (lexical this)
      }
    };
<

call/apply/bind~                                       *javascript-call-apply-bind*
>
    function greet(greeting) {
      console.log(`${greeting}, ${this.name}`);
    }

    const user = { name: 'John' };

    greet.call(user, 'Hello');           // Hello, John
    greet.apply(user, ['Hi']);           // Hi, John

    const boundGreet = greet.bind(user, 'Hey');
    boundGreet();                        // Hey, John
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
