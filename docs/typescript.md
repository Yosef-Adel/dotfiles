*typescript.txt*  TypeScript Reference

==============================================================================
CONTENTS                                                *typescript-contents*

1. Basic Types ........................... |typescript-types|
2. Utility Types ......................... |typescript-utility|
3. Generics .............................. |typescript-generics|
4. Type Guards ........................... |typescript-guards|
5. Interfaces ............................ |typescript-interfaces|
6. Union & Intersection .................. |typescript-unions|
7. Mapped Types .......................... |typescript-mapped|
8. Conditional Types ..................... |typescript-conditional|
9. Type Assertions ....................... |typescript-assertions|
10. Enums ................................ |typescript-enums|
11. Classes .............................. |typescript-classes|
12. Modern Features ...................... |typescript-modern|

==============================================================================
1. Basic Types                                          *typescript-types*

Primitive Types~                                        *typescript-primitives*
>
    // String
    let name: string = 'John';
    let message: string = `Hello ${name}`;

    // Number
    let age: number = 30;
    let price: number = 99.99;
    let hex: number = 0xf00d;
    let binary: number = 0b1010;

    // Boolean
    let isActive: boolean = true;
    let isValid: boolean = false;

    // Null and Undefined
    let nothing: null = null;
    let notDefined: undefined = undefined;

    // Symbol
    let sym: symbol = Symbol('key');
<

any~                                                    *typescript-any*
    Opt out of type checking. Avoid when possible.
>
    let value: any = 'hello';
    value = 123;
    value = true;
    value.foo.bar;                       // No error
<

unknown~                                                *typescript-unknown*
    Type-safe alternative to any. Must narrow before use.
>
    let value: unknown = 'hello';
    // value.toUpperCase();              // Error

    if (typeof value === 'string') {
      value.toUpperCase();               // OK
    }
<

void~                                                   *typescript-void*
    No return value.
>
    function log(message: string): void {
      console.log(message);
    }

    const callback: () => void = () => {
      console.log('done');
    };
<

never~                                                  *typescript-never*
    Never returns (throws or infinite loop).
>
    function throwError(message: string): never {
      throw new Error(message);
    }

    function infiniteLoop(): never {
      while (true) {}
    }

    // Exhaustive checks
    type Shape = 'circle' | 'square';
    function getArea(shape: Shape): number {
      switch (shape) {
        case 'circle': return 3.14;
        case 'square': return 4;
        default:
          const _exhaustive: never = shape;
          return _exhaustive;
      }
    }
<

Array Types~                                            *typescript-arrays*
>
    // Array syntax
    let numbers: number[] = [1, 2, 3];
    let names: string[] = ['a', 'b', 'c'];

    // Generic syntax
    let values: Array<number> = [1, 2, 3];

    // Readonly arrays
    let immutable: readonly number[] = [1, 2, 3];
    // immutable.push(4);                // Error

    // Mixed type arrays
    let mixed: (string | number)[] = [1, 'two', 3];

    // Array of objects
    let users: { name: string; age: number }[] = [
      { name: 'John', age: 30 }
    ];
<

Object Types~                                           *typescript-object-types*
>
    // Inline object type
    let user: { name: string; age: number } = {
      name: 'John',
      age: 30
    };

    // Optional properties
    let config: { host: string; port?: number } = {
      host: 'localhost'
    };

    // Readonly properties
    let point: { readonly x: number; readonly y: number } = {
      x: 10,
      y: 20
    };
    // point.x = 5;                      // Error
<

Type Annotations~                                       *typescript-annotations*
>
    // Variables
    let name: string = 'John';
    const age: number = 30;

    // Function parameters and return type
    function add(a: number, b: number): number {
      return a + b;
    }

    // Arrow functions
    const multiply = (a: number, b: number): number => a * b;

    // Optional parameters
    function greet(name: string, greeting?: string): string {
      return `${greeting || 'Hello'} ${name}`;
    }

    // Default parameters
    function greet2(name: string, greeting: string = 'Hello'): string {
      return `${greeting} ${name}`;
    }

    // Rest parameters
    function sum(...numbers: number[]): number {
      return numbers.reduce((a, b) => a + b, 0);
    }
<

Type Inference~                                         *typescript-inference*
    TypeScript infers types when not explicitly annotated.
>
    let name = 'John';                   // Inferred as string
    let age = 30;                        // Inferred as number
    let isActive = true;                 // Inferred as boolean

    const PI = 3.14;                     // Inferred as 3.14 (literal)
    let pi = 3.14;                       // Inferred as number

    function add(a: number, b: number) {
      return a + b;                      // Return type inferred as number
    }
<

Type Aliases~                                           *typescript-type-aliases*
>
    type ID = string | number;
    type Point = { x: number; y: number };
    type Callback = (data: string) => void;

    let userId: ID = '123';
    let point: Point = { x: 10, y: 20 };
    let handler: Callback = (data) => console.log(data);
<

==============================================================================
2. Utility Types                                        *typescript-utility*

Partial<T>~                                             *typescript-Partial*
    Make all properties optional.
>
    interface User { name: string; age: number; }
    type PartialUser = Partial<User>;
    // { name?: string; age?: number; }
<

Required<T>~                                            *typescript-Required*
    Make all properties required.
>
    interface Props { name?: string; age?: number; }
    type RequiredProps = Required<Props>;
    // { name: string; age: number; }
<

Readonly<T>~                                            *typescript-Readonly*
    Make all properties readonly.
>
    interface User { name: string; age: number; }
    type ReadonlyUser = Readonly<User>;
    // { readonly name: string; readonly age: number; }
<

Pick<T, Keys>~                                          *typescript-Pick*
    Select subset of properties.
>
    interface User { name: string; age: number; email: string; }
    type UserPreview = Pick<User, 'name' | 'age'>;
    // { name: string; age: number; }
<

Omit<T, Keys>~                                          *typescript-Omit*
    Exclude properties.
>
    interface User { name: string; age: number; password: string; }
    type SafeUser = Omit<User, 'password'>;
    // { name: string; age: number; }
<

Record<Keys, Type>~                                     *typescript-Record*
    Create object type with specific keys.
>
    type UserRoles = Record<'admin' | 'user' | 'guest', boolean>;
    // { admin: boolean; user: boolean; guest: boolean; }

    const roles: Record<string, number> = { admin: 1, user: 2 };
<

Exclude<Union, Excluded>~                               *typescript-Exclude*
    Remove types from union.
>
    type T = Exclude<'a' | 'b' | 'c', 'a'>;
    // 'b' | 'c'
<

Extract<Type, Union>~                                   *typescript-Extract*
    Extract types from union.
>
    type T = Extract<'a' | 'b' | 'c', 'a' | 'f'>;
    // 'a'
<

NonNullable<T>~                                         *typescript-NonNullable*
    Remove null and undefined.
>
    type T = NonNullable<string | number | null | undefined>;
    // string | number
<

ReturnType<T>~                                          *typescript-ReturnType*
    Extract function return type.
>
    function getUser() { return { name: 'John', age: 30 }; }
    type User = ReturnType<typeof getUser>;
    // { name: string; age: number; }
<

Parameters<T>~                                          *typescript-Parameters*
    Extract function parameter types as tuple.
>
    function greet(name: string, age: number) {}
    type Params = Parameters<typeof greet>;
    // [name: string, age: number]
<

Awaited<T>~                                             *typescript-Awaited*
    Extract promise resolved type.
>
    type A = Awaited<Promise<string>>;
    // string

    type B = Awaited<Promise<Promise<number>>>;
    // number
<

==============================================================================
2. Generics                                             *typescript-generics*

Basic Generic~                                          *typescript-generic-basic*
>
    function identity<T>(arg: T): T {
      return arg;
    }

    identity<string>('hello');
    identity(123);  // Type inferred
<

Generic Interface~                                      *typescript-generic-interface*
>
    interface Box<T> {
      value: T;
    }

    const stringBox: Box<string> = { value: 'hello' };
    const numberBox: Box<number> = { value: 123 };
<

Generic Constraints~                                    *typescript-generic-constraints*
>
    interface HasLength { length: number; }

    function getLength<T extends HasLength>(arg: T): number {
      return arg.length;
    }

    getLength('hello');      // OK
    getLength([1, 2, 3]);    // OK
    getLength(123);          // Error
<

Multiple Type Parameters~                               *typescript-generic-multiple*
>
    function pair<T, U>(first: T, second: U): [T, U] {
      return [first, second];
    }

    pair<string, number>('age', 30);
    pair('name', true);  // Inferred
<

Generic Classes~                                        *typescript-generic-class*
>
    class Container<T> {
      constructor(private value: T) {}
      getValue(): T { return this.value; }
    }

    const container = new Container<number>(123);
<

==============================================================================
3. Type Guards                                          *typescript-guards*

typeof~                                                 *typescript-typeof*
    Narrow primitive types.
>
    function process(value: string | number) {
      if (typeof value === 'string') {
        return value.toUpperCase();
      }
      return value.toFixed(2);
    }
<

instanceof~                                             *typescript-instanceof*
    Narrow class instances.
>
    class Dog { bark() {} }
    class Cat { meow() {} }

    function makeSound(animal: Dog | Cat) {
      if (animal instanceof Dog) {
        animal.bark();
      } else {
        animal.meow();
      }
    }
<

in~                                                     *typescript-in*
    Check property existence.
>
    type Fish = { swim: () => void };
    type Bird = { fly: () => void };

    function move(animal: Fish | Bird) {
      if ('swim' in animal) {
        animal.swim();
      } else {
        animal.fly();
      }
    }
<

Custom Type Guard~                                      *typescript-custom-guard*
>
    interface User { name: string; }
    interface Admin { name: string; role: string; }

    function isAdmin(user: User | Admin): user is Admin {
      return 'role' in user;
    }

    function greet(user: User | Admin) {
      if (isAdmin(user)) {
        console.log(user.role);  // OK
      }
    }
<

Discriminated Unions~                                   *typescript-discriminated*
>
    type Success = { status: 'success'; data: string };
    type Error = { status: 'error'; error: string };
    type Result = Success | Error;

    function handle(result: Result) {
      if (result.status === 'success') {
        console.log(result.data);
      } else {
        console.log(result.error);
      }
    }
<

Assertion Functions~                                    *typescript-assertion-functions*
    Use asserts keyword to narrow types.
>
    function assertIsString(value: unknown): asserts value is string {
      if (typeof value !== 'string') {
        throw new Error('Not a string');
      }
    }

    function process(value: unknown) {
      assertIsString(value);
      console.log(value.toUpperCase());  // value is string
    }

    function assert(condition: unknown): asserts condition {
      if (!condition) {
        throw new Error('Assertion failed');
      }
    }
<

==============================================================================
4. Interfaces                                           *typescript-interfaces*

Basic Interface~                                        *typescript-interface-basic*
>
    interface User {
      name: string;
      age: number;
      email?: string;           // Optional
      readonly id: string;      // Readonly
    }
<

Index Signatures~                                       *typescript-index-signature*
>
    interface StringMap {
      [key: string]: string;
    }

    const config: StringMap = {
      apiUrl: 'https://api.example.com',
      timeout: '5000'
    };
<

Function Types~                                         *typescript-function-types*
>
    interface Greeter {
      (name: string): string;
    }

    const greet: Greeter = (name) => `Hello ${name}`;
<

Function Overloads~                                     *typescript-function-overloads*
    Multiple function signatures for different parameter types.
>
    // Overload signatures
    function format(value: string): string;
    function format(value: number): string;
    function format(value: boolean): string;

    // Implementation signature
    function format(value: string | number | boolean): string {
      return String(value);
    }

    // Example with different return types
    function get(id: number): User;
    function get(email: string): User;
    function get(value: number | string): User {
      if (typeof value === 'number') {
        return findById(value);
      }
      return findByEmail(value);
    }
<

Extending Interfaces~                                   *typescript-extends*
>
    interface Person {
      name: string;
      age: number;
    }

    interface Employee extends Person {
      employeeId: string;
      department: string;
    }
<

Interface vs Type~                                      *typescript-interface-vs-type*
    When to use which: both can describe object shapes, but have differences.

    **Use Interface when:**
    - Defining object/class structure
    - Need declaration merging (extending third-party types)
    - Defining public API contracts
    - Working with classes and implements

    **Use Type when:**
    - Need unions, intersections, or primitives
    - Creating mapped types or conditional types
    - Working with tuples
    - Need type aliases for primitives or unions

>
    // Declaration merging - interfaces only
    interface User {
      name: string;
    }
    interface User {
      age: number;
    }
    // Merged: { name: string; age: number; }

    // Can't do with type:
    // type User = { name: string; }
    // type User = { age: number; }  // Error: duplicate identifier

    // Unions - types only
    type Status = 'active' | 'inactive';
    type ID = string | number;

    // Can't do with interface:
    // interface Status = 'active' | 'inactive';  // Error

    // Both can extend
    interface Animal { name: string; }
    interface Dog extends Animal { breed: string; }

    type Animal2 = { name: string; };
    type Dog2 = Animal2 & { breed: string; };

    // Interface with extends vs Type with intersection
    interface A { x: number; }
    interface B extends A { y: number; }  // B has x and y

    type A2 = { x: number; };
    type B2 = A2 & { y: number; };        // B2 has x and y

    // Types can alias primitives
    type Name = string;
    type Age = number;

    // Interfaces can't
    // interface Name = string;           // Error
<

Type Compatibility~                                     *typescript-compatibility*
    TypeScript uses structural typing (duck typing), not nominal typing.
>
    interface Point {
      x: number;
      y: number;
    }

    class Point2D {
      constructor(public x: number, public y: number) {}
    }

    const point: Point = new Point2D(10, 20);  // OK - same structure

    // Excess property checking (only on object literals)
    const p1: Point = { x: 10, y: 20, z: 30 };  // Error: excess property 'z'

    const obj = { x: 10, y: 20, z: 30 };
    const p2: Point = obj;                      // OK - no excess check

    // Assignability
    interface Named {
      name: string;
    }

    interface Person {
      name: string;
      age: number;
    }

    let named: Named;
    let person: Person = { name: 'John', age: 30 };

    named = person;                             // OK - Person has all Named properties
    // person = named;                          // Error - Named missing 'age'

    // Function compatibility
    type Handler = (id: number) => void;

    const handler1: Handler = (id) => {};       // OK
    const handler2: Handler = () => {};         // OK - fewer params allowed
    const handler3: Handler = (id, name) => {}; // Error - too many params
<

==============================================================================
5. Union & Intersection                                 *typescript-unions*

Union Types~                                            *typescript-union*
    Value can be one of several types.
>
    type ID = string | number;

    function printId(id: ID) {
      console.log(id);
    }

    printId(123);
    printId('abc');
<

Intersection Types~                                     *typescript-intersection*
    Combine multiple types.
>
    interface Name { name: string; }
    interface Age { age: number; }

    type Person = Name & Age;
    // { name: string; age: number; }

    const person: Person = { name: 'John', age: 30 };
<

Literal Types~                                          *typescript-literal*
>
    type Direction = 'north' | 'south' | 'east' | 'west';
    type Status = 'success' | 'error' | 'pending';

    function move(direction: Direction) {}
    move('north');  // OK
    move('up');     // Error
<

Tuple Types~                                            *typescript-tuple*
    Fixed-length arrays with specific types.
>
    // Basic tuple
    type Point = [number, number];
    const point: Point = [10, 20];

    // Named elements
    type User = [name: string, age: number];
    const user: User = ['John', 30];

    // Optional elements
    type Response = [success: boolean, data?: string];
    const res1: Response = [true, 'data'];
    const res2: Response = [false];

    // Rest elements
    type StringNumberBooleans = [string, number, ...boolean[]];
    const a: StringNumberBooleans = ['hello', 42];
    const b: StringNumberBooleans = ['world', 1, true, false, true];

    // Readonly tuples
    type Readonly3D = readonly [number, number, number];
<

==============================================================================
6. Mapped Types                                         *typescript-mapped*

Basic Mapped Type~                                      *typescript-mapped-basic*
>
    type Nullable<T> = {
      [P in keyof T]: T[P] | null;
    };

    interface User { name: string; age: number; }
    type NullableUser = Nullable<User>;
    // { name: string | null; age: number | null; }
<

Mapping Modifiers~                                      *typescript-mapped-modifiers*
>
    // Remove readonly
    type Mutable<T> = {
      -readonly [P in keyof T]: T[P];
    };

    // Remove optional
    type Concrete<T> = {
      [P in keyof T]-?: T[P];
    };
<

Key Remapping~                                          *typescript-key-remapping*
>
    type Getters<T> = {
      [K in keyof T as `get${Capitalize<string & K>}`]: () => T[K];
    };

    type Person = { name: string; age: number; };
    type PersonGetters = Getters<Person>;
    // { getName: () => string; getAge: () => number; }
<

Indexed Access Types~                                   *typescript-indexed-access*
    Access property types from another type.
>
    type Person = {
      name: string;
      age: number;
      address: {
        city: string;
        country: string;
      };
    };

    type Name = Person['name'];                  // string
    type Age = Person['age'];                    // number
    type City = Person['address']['city'];       // string

    // Union of multiple properties
    type NameOrAge = Person['name' | 'age'];     // string | number

    // All property types
    type PersonValue = Person[keyof Person];
    // string | number | { city: string; country: string; }

    // Array element type
    type StringArray = string[];
    type ArrayElement = StringArray[number];     // string
<

==============================================================================
7. Conditional Types                                    *typescript-conditional*

Basic Conditional~                                      *typescript-conditional-basic*
>
    type IsString<T> = T extends string ? true : false;

    type A = IsString<string>;   // true
    type B = IsString<number>;   // false
<

infer Keyword~                                          *typescript-infer*
    Extract types from conditional types.
>
    type ReturnType<T> = T extends (...args: any[]) => infer R ? R : never;

    function getUser() { return { name: 'John' }; }
    type User = ReturnType<typeof getUser>;
    // { name: string; }

    type ArrayElement<T> = T extends (infer E)[] ? E : never;
    type Num = ArrayElement<number[]>;  // number
<

Distributive Conditional~                               *typescript-distributive*
>
    type ToArray<T> = T extends any ? T[] : never;

    type A = ToArray<string | number>;
    // string[] | number[] (distributed over union)
<

==============================================================================
8. Type Assertions                                      *typescript-assertions*

as Syntax~                                              *typescript-as*
>
    const input = document.querySelector('input') as HTMLInputElement;
    input.value = 'hello';

    const user = data as User;
<

Non-null Assertion~                                     *typescript-non-null*
>
    function getLength(str: string | null) {
      return str!.length;  // Assert non-null
    }

    const element = document.getElementById('app')!;
<

const Assertion~                                        *typescript-const-assertion*
>
    const colors = ['red', 'green', 'blue'] as const;
    // readonly ['red', 'green', 'blue']

    const config = { apiUrl: 'https://api.com' } as const;
    // { readonly apiUrl: 'https://api.com' }
<

Angle Bracket Syntax~                                   *typescript-angle-bracket*
    Not usable in JSX.
>
    const input = <HTMLInputElement>document.querySelector('input');
<

==============================================================================
9. Enums                                                *typescript-enums*

Numeric Enum~                                           *typescript-enum-numeric*
>
    enum Direction {
      Up,      // 0
      Down,    // 1
      Left,    // 2
      Right    // 3
    }

    const dir: Direction = Direction.Up;
<

String Enum~                                            *typescript-enum-string*
>
    enum Status {
      Active = 'ACTIVE',
      Inactive = 'INACTIVE',
      Pending = 'PENDING'
    }

    const status: Status = Status.Active;
<

Const Enum~                                             *typescript-enum-const*
    Inlined at compile time. No runtime object.
>
    const enum Color {
      Red,
      Green,
      Blue
    }

    const color = Color.Red;
    // Compiles to: const color = 0;
<

Enum vs Union~                                          *typescript-enum-vs-union*
    Prefer string literal unions over enums.
>
    // Enum
    enum Status { Active = 'ACTIVE', Inactive = 'INACTIVE' }

    // Union (preferred)
    type Status = 'ACTIVE' | 'INACTIVE';
<

==============================================================================
10. Classes                                             *typescript-classes*

Basic Class~                                            *typescript-class-basic*
>
    class Person {
      name: string;
      age: number;

      constructor(name: string, age: number) {
        this.name = name;
        this.age = age;
      }

      greet(): string {
        return `Hello, I'm ${this.name}`;
      }
    }
<

Access Modifiers~                                       *typescript-access-modifiers*
>
    class User {
      public name: string;           // Default
      private password: string;      // Class only
      protected email: string;       // Class + subclasses
      readonly id: string;           // Immutable

      constructor(name: string, password: string) {
        this.name = name;
        this.password = password;
      }
    }
<

Parameter Properties~                                   *typescript-parameter-properties*
>
    class User {
      constructor(
        public name: string,
        private password: string,
        readonly id: string
      ) {}
    }
    // Properties declared and assigned automatically
<

Abstract Classes~                                       *typescript-abstract*
>
    abstract class Animal {
      abstract makeSound(): void;

      move(): void {
        console.log('Moving...');
      }
    }

    class Dog extends Animal {
      makeSound(): void {
        console.log('Woof!');
      }
    }
<

Implements~                                             *typescript-implements*
>
    interface Printable {
      print(): void;
    }

    class Document implements Printable {
      print(): void {
        console.log('Printing...');
      }
    }
<

Static Members~                                         *typescript-static*
>
    class MathUtils {
      static PI = 3.14;

      static add(a: number, b: number): number {
        return a + b;
      }
    }

    MathUtils.add(2, 3);
<

==============================================================================
11. Modern Features                                     *typescript-modern*

satisfies Operator~                                     *typescript-satisfies*
    Type-check without widening type.
>
    type Colors = 'red' | 'green' | 'blue';
    const palette = {
      red: [255, 0, 0],
      green: '#00ff00',
      blue: [0, 0, 255]
    } satisfies Record<Colors, string | number[]>;

    // palette.red is [number, number, number] (specific)
    // Without satisfies, it would be (string | number[])
<

Const Type Parameters~                                  *typescript-const-type-params*
    Preserve literal types in generics.
>
    function makeArray<const T>(items: T[]) {
      return items;
    }

    const arr = makeArray(['a', 'b', 'c']);
    // readonly ['a', 'b', 'c'] (literals preserved)

    function createConfig<const T extends Record<string, any>>(config: T) {
      return config;
    }

    const config = createConfig({
      apiUrl: 'https://api.com',
      timeout: 5000
    });
    // apiUrl is 'https://api.com' (literal)
    // timeout is 5000 (literal)
<

Template Literal Types~                                 *typescript-template-literal*
>
    type World = 'world';
    type Greeting = `hello ${World}`;
    // 'hello world'

    type Color = 'red' | 'green' | 'blue';
    type Quantity = 'one' | 'two';
    type ColorQuantity = `${Quantity} ${Color}`;
    // 'one red' | 'one green' | 'one blue' | 'two red' | ...

    type EventName = 'click' | 'focus' | 'blur';
    type EventHandler = `on${Capitalize<EventName>}`;
    // 'onClick' | 'onFocus' | 'onBlur'
<

String Utilities~                                       *typescript-string-utilities*
>
    type Upper = Uppercase<'hello'>;        // 'HELLO'
    type Lower = Lowercase<'HELLO'>;        // 'hello'
    type Cap = Capitalize<'hello'>;         // 'Hello'
    type Uncap = Uncapitalize<'Hello'>;     // 'hello'
<

Type Narrowing~                                         *typescript-narrowing*
>
    function process(value: string | number) {
      if (typeof value === 'string') {
        value.toUpperCase();  // string
      } else {
        value.toFixed(2);     // number
      }
    }

    type Success = { status: 'success'; data: string };
    type Error = { status: 'error'; error: string };

    function handle(result: Success | Error) {
      if (result.status === 'success') {
        console.log(result.data);   // Success type
      } else {
        console.log(result.error);  // Error type
      }
    }
<

Never Type~                                             *typescript-never*
>
    function throwError(message: string): never {
      throw new Error(message);
    }

    function infiniteLoop(): never {
      while (true) {}
    }

    type NonNullable<T> = T extends null | undefined ? never : T;
<

Unknown Type~                                           *typescript-unknown*
    Type-safe alternative to any.
>
    let value: unknown;
    value = 'hello';
    value = 123;

    // Must narrow before use
    if (typeof value === 'string') {
      console.log(value.toUpperCase());
    }
<

Module Augmentation~                                    *typescript-module-augmentation*
>
    // Extend existing module
    declare module 'express' {
      interface Request {
        user?: User;
      }
    }

    // Extend global
    declare global {
      interface Window {
        myApp: App;
      }
    }
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
