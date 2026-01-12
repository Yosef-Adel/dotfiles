# TypeScript Reference

Quick reference for TypeScript. Use `/` to search in vim.

## Table of Contents

- [TypeScript Reference](#typescript-reference)
  - [Table of Contents](#table-of-contents)
  - [Utility Types](#utility-types)
    - [Partial](#partial)
    - [Required](#required)
    - [Readonly](#readonly)
    - [Pick\<Type, Keys\>](#picktype-keys)
    - [Omit\<Type, Keys\>](#omittype-keys)
    - [Record\<Keys, Type\>](#recordkeys-type)
    - [Exclude\<UnionType, ExcludedMembers\>](#excludeuniontype-excludedmembers)
    - [Extract\<Type, Union\>](#extracttype-union)
    - [NonNullable](#nonnullable)
    - [ReturnType](#returntype)
    - [Parameters](#parameters)
    - [Awaited](#awaited)
  - [Generics](#generics)
    - [Basic Generic Function](#basic-generic-function)
    - [Generic Interface](#generic-interface)
    - [Generic Constraints](#generic-constraints)
    - [Multiple Type Parameters](#multiple-type-parameters)
  - [Type Guards](#type-guards)
    - [typeof](#typeof)
    - [instanceof](#instanceof)
    - [Custom Type Guard](#custom-type-guard)
  - [Interfaces](#interfaces)
    - [Basic Interface](#basic-interface)
    - [Index Signatures](#index-signatures)
    - [Function Types](#function-types)
    - [Extending Interfaces](#extending-interfaces)
  - [Union and Intersection Types](#union-and-intersection-types)
    - [Union Types](#union-types)
    - [Intersection Types](#intersection-types)
  - [Mapped Types](#mapped-types)
    - [Basic Mapped Type](#basic-mapped-type)
    - [Mapping Over Object Keys](#mapping-over-object-keys)
  - [Conditional Types](#conditional-types)
    - [Basic Conditional Type](#basic-conditional-type)
    - [infer Keyword](#infer-keyword)
  - [Enums](#enums)
    - [Numeric Enum](#numeric-enum)
    - [String Enum](#string-enum)
    - [Const Enum (Inlined at compile time)](#const-enum-inlined-at-compile-time)
  - [Type Assertions](#type-assertions)
    - [as Syntax](#as-syntax)
    - [Angle Bracket Syntax (not in JSX)](#angle-bracket-syntax-not-in-jsx)
    - [Non-null Assertion](#non-null-assertion)
  - [Template Literal Types](#template-literal-types)

## Utility Types

### Partial<Type>

Makes all properties optional.

```typescript
interface User {
  name: string;
  age: number;
  email: string;
}

type PartialUser = Partial<User>;
// Result: { name?: string; age?: number; email?: string; }

// Usage
const updateUser = (user: User, updates: PartialUser): User => {
  return { ...user, ...updates };
};
```

### Required<Type>

Makes all properties required (opposite of Partial).

```typescript
interface Props {
  name?: string;
  age?: number;
}

type RequiredProps = Required<Props>;
// Result: { name: string; age: number; }
```

### Readonly<Type>

Makes all properties readonly.

```typescript
interface User {
  name: string;
  age: number;
}

const user: Readonly<User> = { name: "John", age: 30 };
// user.name = "Jane"; // Error: cannot assign to readonly property
```

### Pick<Type, Keys>

Pick specific properties from a type.

```typescript
interface User {
  name: string;
  age: number;
  email: string;
  password: string;
}

type PublicUser = Pick<User, "name" | "email">;
// Result: { name: string; email: string; }
```

### Omit<Type, Keys>

Remove specific properties from a type.

```typescript
interface User {
  name: string;
  age: number;
  email: string;
  password: string;
}

type UserWithoutPassword = Omit<User, "password">;
// Result: { name: string; age: number; email: string; }
```

### Record<Keys, Type>

Create an object type with specific keys and value type.

```typescript
type Role = "admin" | "user" | "guest";
type Permissions = Record<Role, string[]>;

const permissions: Permissions = {
  admin: ["read", "write", "delete"],
  user: ["read", "write"],
  guest: ["read"],
};
```

### Exclude<UnionType, ExcludedMembers>

Exclude types from a union.

```typescript
type T = "a" | "b" | "c";
type T1 = Exclude<T, "a">;
// Result: 'b' | 'c'

type T2 = Exclude<T, "a" | "b">;
// Result: 'c'
```

### Extract<Type, Union>

Extract types from a union.

```typescript
type T = "a" | "b" | "c";
type T1 = Extract<T, "a" | "f">;
// Result: 'a'
```

### NonNullable<Type>

Remove null and undefined from a type.

```typescript
type T = string | number | null | undefined;
type T1 = NonNullable<T>;
// Result: string | number
```

### ReturnType<Type>

Get the return type of a function.

```typescript
function getUser() {
  return { name: "John", age: 30 };
}

type User = ReturnType<typeof getUser>;
// Result: { name: string; age: number; }
```

### Parameters<Type>

Get the parameter types of a function as a tuple.

```typescript
function createUser(name: string, age: number) {
  return { name, age };
}

type Params = Parameters<typeof createUser>;
// Result: [name: string, age: number]
```

### Awaited<Type>

Unwrap Promise types.

```typescript
type A = Awaited<Promise<string>>;
// Result: string

type B = Awaited<Promise<Promise<number>>>;
// Result: number
```

## Generics

### Basic Generic Function

```typescript
function identity<T>(arg: T): T {
  return arg;
}

const num = identity<number>(42);
const str = identity<string>("hello");
// Type inference: identity(42) also works
```

### Generic Interface

```typescript
interface Box<T> {
  value: T;
}

const numberBox: Box<number> = { value: 42 };
const stringBox: Box<string> = { value: "hello" };
```

### Generic Constraints

```typescript
interface Lengthwise {
  length: number;
}

function logLength<T extends Lengthwise>(arg: T): T {
  console.log(arg.length);
  return arg;
}

logLength("hello"); // OK
logLength([1, 2, 3]); // OK
// logLength(42); // Error: number doesn't have length
```

### Multiple Type Parameters

```typescript
function pair<T, U>(first: T, second: U): [T, U] {
  return [first, second];
}

const result = pair("hello", 42);
// Result: [string, number]
```

## Type Guards

### typeof

```typescript
function printValue(val: string | number) {
  if (typeof val === "string") {
    console.log(val.toUpperCase()); // val is string here
  } else {
    console.log(val.toFixed(2)); // val is number here
  }
}
```

### instanceof

```typescript
class Dog {
  bark() {
    console.log("woof");
  }
}

class Cat {
  meow() {
    console.log("meow");
  }
}

function makeSound(animal: Dog | Cat) {
  if (animal instanceof Dog) {
    animal.bark();
  } else {
    animal.meow();
  }
}
```

### Custom Type Guard

```typescript
interface Fish {
  swim: () => void;
}

interface Bird {
  fly: () => void;
}

function isFish(pet: Fish | Bird): pet is Fish {
  return (pet as Fish).swim !== undefined;
}

function move(pet: Fish | Bird) {
  if (isFish(pet)) {
    pet.swim();
  } else {
    pet.fly();
  }
}
```

## Interfaces

### Basic Interface

```typescript
interface User {
  name: string;
  age: number;
  email?: string; // Optional
  readonly id: number; // Readonly
}

const user: User = {
  id: 1,
  name: "John",
  age: 30,
};
```

### Index Signatures

```typescript
interface StringMap {
  [key: string]: string;
}

const map: StringMap = {
  name: "John",
  email: "john@example.com",
};
```

### Function Types

```typescript
interface Comparator<T> {
  (a: T, b: T): number;
}

const numberComparator: Comparator<number> = (a, b) => a - b;
```

### Extending Interfaces

```typescript
interface Animal {
  name: string;
}

interface Dog extends Animal {
  breed: string;
}

const dog: Dog = {
  name: "Buddy",
  breed: "Golden Retriever",
};
```

## Union and Intersection Types

### Union Types

```typescript
type Status = "pending" | "success" | "error";

function handleStatus(status: Status) {
  // status can only be one of the three values
}
```

### Intersection Types

```typescript
interface Colorful {
  color: string;
}

interface Circle {
  radius: number;
}

type ColorfulCircle = Colorful & Circle;

const cc: ColorfulCircle = {
  color: "red",
  radius: 42,
};
```

## Mapped Types

### Basic Mapped Type

```typescript
type Flags = {
  [K in "option1" | "option2" | "option3"]: boolean;
};
// Result: { option1: boolean; option2: boolean; option3: boolean; }
```

### Mapping Over Object Keys

```typescript
type Options = {
  width: number;
  height: number;
};

type OptionsFlags = {
  [K in keyof Options]: boolean;
};
// Result: { width: boolean; height: boolean; }
```

## Conditional Types

### Basic Conditional Type

```typescript
type IsString<T> = T extends string ? true : false;

type A = IsString<string>; // true
type B = IsString<number>; // false
```

### infer Keyword

```typescript
type GetReturnType<T> = T extends (...args: any[]) => infer R ? R : never;

type Num = GetReturnType<() => number>; // number
type Str = GetReturnType<() => string>; // string
```

## Enums

### Numeric Enum

```typescript
enum Direction {
  Up = 1,
  Down,
  Left,
  Right,
}

const dir: Direction = Direction.Up; // 1
```

### String Enum

```typescript
enum Status {
  Success = "SUCCESS",
  Error = "ERROR",
  Pending = "PENDING",
}

const status: Status = Status.Success; // "SUCCESS"
```

### Const Enum (Inlined at compile time)

```typescript
const enum Color {
  Red,
  Green,

### Class Basics

```typescript
class Animal {
  name: string;
  age: number;

  constructor(name: string, age: number) {
    this.name = name;
    this.age = age;
  }

  move(): void {
    console.log("Moving...");
  }
}

const dog = new Animal("Buddy", 5);
dog.move();
```

### Inheritance

```typescript
class Dog extends Animal {
  breed: string;

  constructor(name: string, age: number, breed: string) {
    super(name, age); // Call parent constructor
    this.breed = breed;
  }

  move(): void {
    console.log("Dog is running");
  }

  bark(): void {
    console.log("Woof!");
  }
}

const myDog = new Dog("Max", 3, "Golden Retriever");
myDog.move(); // Dog is running
myDog.bark(); // Woof!
```

### Access Modifiers

```typescript
class Person {
  public name: string; // Accessible anywhere
  private age: number; // Only within this class
  protected email: string; // Within class and subclasses
  readonly id: number; // Cannot be changed after init

  constructor(name: string, age: number, email: string, id: number) {
    this.name = name;
    this.age = age;
    this.email = email;
    this.id = id;
  }

  // Private method
  private calculateBirthYear(): number {
    return new Date().getFullYear() - this.age;
  }

  // Protected method
  protected getEmail(): string {
    return this.email;
  }
}

class Employee extends Person {
  getEmployeeEmail(): string {
    return this.getEmail(); // Can access protected
    // return this.age;       // Error: private
  }
}
```

### Abstract Classes

```typescript
abstract class Shape {
  abstract getArea(): number;

  describe(): void {
    console.log(`Area: ${this.getArea()}`);
  }
}

class Circle extends Shape {
  radius: number;

  constructor(radius: number) {
    super();
    this.radius = radius;
  }

  getArea(): number {
    return Math.PI * this.radius ** 2;
  }
}

// const shape = new Shape(); // Error: Cannot instantiate abstract class
const circle = new Circle(5);
circle.describe(); // Area: 78.53981633974483
```

## Decorators

Decorators are functions that modify class definitions (used in Angular, NestJS).

```typescript
// Enable in tsconfig.json: "experimentalDecorators": true

// Class decorator
function Log(target: Function) {
  console.log(`Creating class ${target.name}`);
}

@Log
class User {
  constructor(public name: string) {}
}

// Property decorator
function Required(target: Object, propertyKey: string) {
  // Validation logic
}

class Product {
  @Required
  name: string;
}

// Method decorator
function Readonly(
  target: Object,
  propertyKey: string,
  descriptor: PropertyDescriptor
) {
  descriptor.writable = false;
}

class Config {
  @Readonly
  apiUrl = "https://api.example.com";
}
```

## Namespaces

Namespaces organize code into logical groups.

```typescript
namespace Geometry {
  export class Circle {
    constructor(public radius: number) {}

    area(): number {
      return Math.PI * this.radius ** 2;
    }
  }

  export function getPerimeter(radius: number): number {
    return 2 * Math.PI * radius;
  }
}

const circle = new Geometry.Circle(5);
console.log(circle.area());
console.log(Geometry.getPerimeter(5));
```

## Module System

```typescript
// math.ts - Export
export function add(a: number, b: number): number {
  return a + b;
}

export const PI = 3.14159;

export class Calculator {
  calculate() {}
}

// Default export
export default function greet(name: string) {
  return `Hello, ${name}`;
}

// main.ts - Import
import greet, { add, PI, Calculator } from "./math";
import * as Math from "./math"; // Import all

greet("John");
add(2, 3);
new Calculator();
```

## Type Narrowing

```typescript
// Discriminated unions
type Success = { status: "success"; data: string };
type Error = { status: "error"; error: string };
type Result = Success | Error;

function handleResult(result: Result) {
  if (result.status === "success") {
    console.log(result.data); // data is available
  } else {
    console.log(result.error); // error is available
  }
}

// typeof narrowing
function process(value: string | number) {
  if (typeof value === "string") {
    value.toUpperCase();
  } else {
    value.toFixed(2);
  }
}

// instanceof narrowing
class Dog {
  bark() {}
}
class Cat {
  meow() {}
}

function makePetSound(pet: Dog | Cat) {
  if (pet instanceof Dog) {
    pet.bark();
  } else {
    pet.meow();
  }
}
```

## Advanced Type Patterns

```typescript
// Readonly properties
type Point = {
  readonly x: number;
  readonly y: number;
};

const point: Point = { x: 10, y: 20 };
// point.x = 5;  // Error

// Type compatibility (structural typing)
type A = { name: string };
type B = { name: string; age: number };

const b: B = { name: "John", age: 30 };
const a: A = b; // OK: B has all properties of A

// Key remapping in mapped types
type Getters<T> = {
  [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K];
};

type Person = { name: string; age: number };
type PersonGetters = Getters<Person>;
// Result: { getName: () => string; getAge: () => number }
```

## Async/Await Typing

```typescript
// Typed async function
async function fetchUser(id: number): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  return response.json();
}

// Typing async callback
const fetchData = async (url: string): Promise<any> => {
  return fetch(url).then((r) => r.json());
};

// Error handling with types
type ApiResponse<T> =
  | { success: true; data: T }
  | { success: false; error: string };

async function getUser(id: number): Promise<ApiResponse<User>> {
  try {
    const user = await fetchUser(id);
    return { success: true, data: user };
  } catch (error) {
    return { success: false, error: String(error) };
  }
}
```

## tsconfig Options

Key `tsconfig.json` options:

```json
{
  "compilerOptions": {
    "target": "ES2020", // JavaScript version
    "module": "ESNext", // Module system (CommonJS, ES6, etc)
    "lib": ["ES2020", "DOM"], // Built-in types available
    "outDir": "./dist", // Compiled output
    "rootDir": "./src", // Source root
    "strict": true, // Enable all strict checks
    "esModuleInterop": true, // CommonJS <-> ES6 compat
    "skipLibCheck": true, // Skip type checking node_modules
    "forceConsistentCasingInFileNames": true, // Case-sensitive file checks
    "declaration": true, // Generate .d.ts files
    "declarationMap": true, // Source maps for declarations
    "sourceMap": true, // Source maps for debugging
    "noImplicitAny": true, // Error on implicit any
    "strictNullChecks": true, // Strict null/undefined checks
    "strictFunctionTypes": true, // Strict function type checks
    "noUnusedLocals": true, // Error on unused variables
    "noUnusedParameters": true, // Error on unused parameters
    "noImplicitReturns": true, // Error on missing returns
    "resolveJsonModule": true // Import JSON files
  },
  "include": ["src"],
  "exclude": ["node_modules", "dist", "**/*.spec.ts"]
}
```
````
