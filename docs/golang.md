# Go (Golang) Reference

Quick reference for Go programming language. Use `/` to search in vim.

## Table of Contents

- [Go (Golang) Reference](#go-golang-reference)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Basics](#basics)
    - [Hello World](#hello-world)
    - [Variables](#variables)
    - [Constants](#constants)
    - [Data Types](#data-types)
  - [Functions](#functions)
    - [Basic Function](#basic-function)
    - [Multiple Return Values](#multiple-return-values)
    - [Named Return Values](#named-return-values)
    - [Variadic Functions](#variadic-functions)
    - [Deferred Functions](#deferred-functions)
  - [Control Flow](#control-flow)
    - [if/else](#ifelse)
    - [switch](#switch)
    - [for Loop](#for-loop)
    - [range](#range)
    - [break/continue](#breakcontinue)
  - [Arrays \& Slices](#arrays--slices)
    - [Arrays](#arrays)
    - [Slices](#slices)
    - [Slice Operations](#slice-operations)
  - [Maps](#maps)
  - [Structs](#structs)
    - [Define Struct](#define-struct)
    - [Struct Methods](#struct-methods)
    - [Pointers](#pointers)
    - [Receivers](#receivers)
  - [Interfaces](#interfaces)
  - [Error Handling](#error-handling)
    - [Error Type](#error-type)
    - [Panic \& Recover](#panic--recover)
  - [Goroutines \& Channels](#goroutines--channels)
    - [Goroutines](#goroutines)
    - [Channels](#channels)
    - [Select](#select)
    - [Buffered Channels](#buffered-channels)
  - [Packages](#packages)
    - [Import](#import)
    - [Creating Packages](#creating-packages)
  - [Common Packages](#common-packages)
    - [fmt](#fmt)
    - [strings](#strings)
    - [io](#io)
    - [json](#json)
    - [time](#time)
    - [http](#http)
  - [Testing](#testing)
  - [Build \& Run](#build--run)

## Installation

Install Go.

```bash
# macOS (Homebrew)
brew install go

# Ubuntu/Debian
sudo apt-get install golang-go

# From source
# Download from https://go.dev/dl/

# Verify installation
go version
go env

# Setup GOPATH (Go workspace)
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
```

## Basics

### Hello World

```go
package main

import "fmt"

func main() {
  fmt.Println("Hello, World!")
}
```

Run:

```bash
go run main.go
```

### Variables

```go
// Declare variable with explicit type
var name string = "John"
var age int = 30
var height float64 = 5.9

// Declare without initialization (zero value)
var count int     // 0
var text string   // ""
var flag bool     // false

// Short declaration (inside functions only)
name := "John"
age := 30
salary := 50000.50

// Multiple declaration
var (
  a int = 1
  b string = "hello"
  c bool = true
)

// Blank identifier (discard value)
_, err := someFunction()
```

### Constants

```go
// Basic constant
const pi = 3.14159
const maxSize = 1000

// Typed constant
const name string = "John"
const version int = 1

// Multiple constants
const (
  Sunday = iota    // 0
  Monday           // 1
  Tuesday          // 2
  Wednesday        // 3
)

// Constant expression
const billion = 1_000_000_000
```

### Data Types

```go
// Numeric
int, int8, int16, int32, int64
uint, uint8, uint16, uint32, uint64
float32, float64
complex64, complex128

// String
string

// Boolean
bool

// Byte and rune
byte        // Alias for uint8
rune        // Alias for int32 (Unicode character)

// Zero values
var i int           // 0
var f float64       // 0.0
var s string        // ""
var b bool          // false
var p *int          // nil (pointer)

// Type conversion
var i int = 42
var f float64 = float64(i)
var s string = "42"
var n, _ = strconv.Atoi(s)
```

## Functions

### Basic Function

```go
func add(a int, b int) int {
  return a + b
}

// Shorthand parameter types
func add(a, b int) int {
  return a + b
}

// Calling function
result := add(5, 3)
```

### Multiple Return Values

```go
// Return multiple values
func divide(a, b float64) (float64, error) {
  if b == 0 {
    return 0, errors.New("division by zero")
  }
  return a / b, nil
}

// Use multiple returns
result, err := divide(10, 2)
if err != nil {
  log.Fatal(err)
}
```

### Named Return Values

```go
// Named return values (implicit return)
func swap(a, b string) (x, y string) {
  x = b
  y = a
  return    // Automatically returns x, y
}

first, second := swap("hello", "world")
// first = "world", second = "hello"
```

### Variadic Functions

```go
// Variadic function (variable number of arguments)
func sum(numbers ...int) int {
  total := 0
  for _, num := range numbers {
    total += num
  }
  return total
}

sum(1, 2, 3, 4, 5)         // 15

// Passing slice
nums := []int{1, 2, 3}
sum(nums...)               // Unpack slice
```

### Deferred Functions

```go
// Defer - execute function when surrounding function returns
func main() {
  defer fmt.Println("World")
  fmt.Println("Hello")
}
// Output:
// Hello
// World

// Deferred stack (LIFO - last in, first out)
func main() {
  defer fmt.Println("1")
  defer fmt.Println("2")
  defer fmt.Println("3")
}
// Output: 3, 2, 1

// Common use: cleanup
func readFile(filename string) {
  file, _ := os.Open(filename)
  defer file.Close()   // Always close, even if error
  // Process file
}
```

## Control Flow

### if/else

```go
// Basic if
if x > 0 {
  fmt.Println("Positive")
}

// if/else
if x > 0 {
  fmt.Println("Positive")
} else if x < 0 {
  fmt.Println("Negative")
} else {
  fmt.Println("Zero")
}

// if with short statement
if x := getValue(); x > 0 {
  fmt.Println("Positive:", x)
}

// Logical operators
if x > 0 && x < 10 {
  fmt.Println("Between 0 and 10")
}

if x > 0 || y > 0 {
  fmt.Println("At least one positive")
}

if !flag {
  fmt.Println("Flag is false")
}
```

### switch

```go
// Basic switch
switch day := getDayOfWeek(); day {
case 0:
  fmt.Println("Sunday")
case 1:
  fmt.Println("Monday")
case 2, 3:          // Multiple cases
  fmt.Println("Tuesday or Wednesday")
default:
  fmt.Println("Other day")
}

// Switch with no expression (like if/else)
switch {
case x < 0:
  fmt.Println("Negative")
case x == 0:
  fmt.Println("Zero")
default:
  fmt.Println("Positive")
}

// Type switch
switch v := i.(type) {
case int:
  fmt.Println("Integer:", v)
case string:
  fmt.Println("String:", v)
case bool:
  fmt.Println("Boolean:", v)
default:
  fmt.Println("Unknown type")
}
```

### for Loop

```go
// Basic for loop
for i := 0; i < 10; i++ {
  fmt.Println(i)
}

// While-style loop
for x < 10 {
  fmt.Println(x)
  x++
}

// Infinite loop
for {
  fmt.Println("Infinite")
  if done {
    break
  }
}

// Loop with multiple variables
for i, j := 0, 10; i < j; i, j = i+1, j-1 {
  fmt.Println(i, j)
}
```

### range

```go
// Range over array
arr := []int{1, 2, 3, 4, 5}
for i, v := range arr {
  fmt.Println(i, v)  // Index, Value
}

// Range over slice
for i := range arr {
  fmt.Println(i)     // Index only
}

// Range over string
str := "hello"
for i, ch := range str {
  fmt.Println(i, ch) // Index, Character (rune)
}

// Range over map
person := map[string]int{"John": 30, "Jane": 25}
for k, v := range person {
  fmt.Println(k, v)  // Key, Value
}

// Range over channel
for val := range ch {
  fmt.Println(val)
}
```

### break/continue

```go
// Break out of loop
for i := 0; i < 10; i++ {
  if i == 5 {
    break
  }
  fmt.Println(i)
}

// Continue to next iteration
for i := 0; i < 10; i++ {
  if i%2 == 0 {
    continue
  }
  fmt.Println(i)     // Only odd numbers
}

// Break with label
OuterLoop:
for i := 0; i < 3; i++ {
  for j := 0; j < 3; j++ {
    if i == 1 && j == 1 {
      break OuterLoop
    }
  }
}
```

## Arrays & Slices

### Arrays

```go
// Array with fixed length
var arr [5]int          // [0 0 0 0 0]
var names [3]string     // ["" "" ""]

// Array initialization
arr := [5]int{1, 2, 3, 4, 5}
arr := [...]int{1, 2, 3, 4, 5}  // Length inferred

// Access element
arr[0] = 10
fmt.Println(arr[0])

// Array length
len(arr)

// Iterate array
for i := 0; i < len(arr); i++ {
  fmt.Println(arr[i])
}

// Multidimensional array
matrix := [2][3]int{
  {1, 2, 3},
  {4, 5, 6},
}
```

### Slices

```go
// Slice (dynamic array)
var s []int                    // nil slice
s := []int{1, 2, 3, 4, 5}     // Slice literal

// Create with make
s := make([]int, 5)            // Length 5, capacity 5
s := make([]int, 5, 10)        // Length 5, capacity 10

// Get length and capacity
len(s)      // Length
cap(s)      // Capacity

// Append to slice
s = append(s, 6)
s = append(s, 7, 8, 9)

// Slice of slice (view)
arr := []int{1, 2, 3, 4, 5}
s1 := arr[1:4]        // [2 3 4] (indices 1, 2, 3)
s2 := arr[:3]         // [1 2 3] (from start to 2)
s3 := arr[2:]         // [3 4 5] (from 2 to end)
s4 := arr[:]          // [1 2 3 4 5] (entire array)

// Copy slice
src := []int{1, 2, 3}
dst := make([]int, len(src))
copy(dst, src)        // Copy src into dst
```

### Slice Operations

```go
// Create and populate
s := []int{1, 2, 3}

// Append
s = append(s, 4, 5)           // [1 2 3 4 5]

// Insert
s = append(s[:2], append([]int{10}, s[2:]...)...)  // Insert 10 at index 2

// Remove
s = append(s[:1], s[2:]...)   // Remove element at index 1

// Delete range
s = append(s[:2], s[5:]...)   // Remove elements 2-4

// Clear slice
s = s[:0]

// Reverse slice
for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
  s[i], s[j] = s[j], s[i]
}
```

## Maps

Maps are key-value pairs (like dictionaries or objects).

```go
// Declare map
var person map[string]int      // nil map

// Create with make
person := make(map[string]int)

// Map literal
person := map[string]int{
  "Alice": 30,
  "Bob":   25,
}

// Add/Set
person["John"] = 35
person["Jane"] = 28

// Get value
age := person["Alice"]         // 30
age := person["Unknown"]       // 0 (zero value)

// Check if key exists
age, exists := person["John"]
if exists {
  fmt.Println("John's age:", age)
}

// Delete key
delete(person, "John")

// Length
len(person)

// Iterate map
for name, age := range person {
  fmt.Println(name, age)
}

// Nested map
scores := map[string]map[string]int{
  "Alice": {"Math": 90, "English": 85},
  "Bob":   {"Math": 80, "English": 95},
}
```

## Structs

### Define Struct

```go
// Define struct
type Person struct {
  Name string
  Age  int
  City string
}

// Create instance
p := Person{"John", 30, "New York"}

// Create with field names
p := Person{
  Name: "John",
  Age:  30,
  City: "New York",
}

// Partial initialization
p := Person{Name: "John"}  // Age and City are zero values

// Access fields
fmt.Println(p.Name)
p.Age = 31

// Embedded struct
type Employee struct {
  Person      // Embedded type
  EmployeeID  int
  Salary      float64
}

emp := Employee{
  Person: Person{"John", 30, "New York"},
  EmployeeID: 12345,
  Salary: 50000,
}

// Access embedded field
fmt.Println(emp.Name)  // Works directly
```

### Struct Methods

```go
// Method (function with receiver)
func (p Person) String() string {
  return fmt.Sprintf("%s (%d)", p.Name, p.Age)
}

// Call method
p := Person{"John", 30}
fmt.Println(p.String())   // John (30)

// Value receiver vs Pointer receiver
func (p Person) increaseAge() {    // Value receiver - doesn't modify
  p.Age++
}

func (p *Person) increaseAge() {   // Pointer receiver - modifies
  p.Age++
}

p := Person{"John", 30}
p.increaseAge()        // Use pointer receiver
```

### Pointers

```go
// Declare pointer
var p *int
var person *Person

// Address of (&)
x := 10
p := &x            // Pointer to x
fmt.Println(p)     // 0xc0000160a8

// Dereference (*)
fmt.Println(*p)    // 10
*p = 20            // Change value at pointer

// Pointer to struct
person := &Person{"John", 30}
(*person).Age = 31
person.Age = 31    // Shorthand (automatic dereferencing)

// nil pointer
var p *int         // p is nil
if p != nil {
  fmt.Println(*p)
}
```

### Receivers

```go
// Value receiver - operates on copy
func (p Person) changeName(newName string) {
  p.Name = newName  // Doesn't affect original
}

// Pointer receiver - operates on original
func (p *Person) changeName(newName string) {
  p.Name = newName  // Modifies original
}

// Method chaining with pointer receiver
func (p *Person) setAge(age int) *Person {
  p.Age = age
  return p
}

func (p *Person) setCity(city string) *Person {
  p.City = city
  return p
}

p := &Person{"John", 0, ""}
p.setAge(30).setCity("New York")
```

## Interfaces

```go
// Define interface
type Writer interface {
  Write(data []byte) (int, error)
}

type Reader interface {
  Read(data []byte) (int, error)
}

// Implement interface (implicit)
type File struct {
  name string
}

func (f File) Write(data []byte) (int, error) {
  fmt.Printf("Writing to %s\n", f.name)
  return len(data), nil
}

// Interface as type
var w Writer = File{"output.txt"}
w.Write([]byte("Hello"))

// Empty interface (any type)
var i interface{}
i = 42
i = "hello"
i = true

// Type assertion
value, ok := i.(string)
if ok {
  fmt.Println("String:", value)
}

// Type switch
switch v := i.(type) {
case int:
  fmt.Println("Integer:", v)
case string:
  fmt.Println("String:", v)
default:
  fmt.Println("Unknown type")
}

// Multiple interfaces
type ReadWriter interface {
  Read([]byte) (int, error)
  Write([]byte) (int, error)
}
```

## Error Handling

### Error Type

```go
// Error interface
type error interface {
  Error() string
}

// Return error
func divide(a, b float64) (float64, error) {
  if b == 0 {
    return 0, errors.New("division by zero")
  }
  return a / b, nil
}

// Handle error
result, err := divide(10, 0)
if err != nil {
  fmt.Println("Error:", err)
  return
}
fmt.Println("Result:", result)

// Custom error
type MyError struct {
  Code    int
  Message string
}

func (e MyError) Error() string {
  return fmt.Sprintf("[%d] %s", e.Code, e.Message)
}

// Use custom error
return MyError{400, "Bad request"}
```

### Panic & Recover

```go
// Panic (like exception, stops execution)
if x == 0 {
  panic("x cannot be zero")
}

// Recover (catch panic)
defer func() {
  if r := recover(); r != nil {
    fmt.Println("Recovered from:", r)
  }
}()

panic("Something went wrong")
fmt.Println("This won't execute")
```

## Goroutines & Channels

### Goroutines

```go
// Launch goroutine
go func() {
  fmt.Println("Hello from goroutine")
}()

// Named function as goroutine
func sayHello() {
  fmt.Println("Hello")
}

go sayHello()

// Wait for goroutines with WaitGroup
import "sync"

var wg sync.WaitGroup

wg.Add(1)
go func() {
  defer wg.Done()
  fmt.Println("Hello from goroutine")
}()

wg.Wait()  // Wait for all goroutines
```

### Channels

```go
// Create channel
var ch chan int           // nil channel
ch := make(chan int)      // Unbuffered channel
ch := make(chan int, 5)   // Buffered channel (capacity 5)

// Send to channel
ch <- 42

// Receive from channel
value := <-ch

// Close channel
close(ch)

// Receive and check if closed
value, ok := <-ch
if !ok {
  fmt.Println("Channel closed")
}

// Range over channel (until closed)
for value := range ch {
  fmt.Println(value)
}

// Send-only and receive-only channels
send := make(chan<- int)    // Send-only
recv := make(<-chan int)    // Receive-only
```

### Select

```go
// Select waits on multiple channel operations
select {
case msg := <-ch1:
  fmt.Println("Received from ch1:", msg)
case msg := <-ch2:
  fmt.Println("Received from ch2:", msg)
case ch3 <- msg:
  fmt.Println("Sent to ch3")
default:
  fmt.Println("No message received")
}

// Timeout with select
select {
case msg := <-ch:
  fmt.Println("Message:", msg)
case <-time.After(1 * time.Second):
  fmt.Println("Timeout")
}
```

### Buffered Channels

```go
// Buffered channel doesn't block if not full
ch := make(chan int, 2)

ch <- 1
ch <- 2        // Doesn't block (buffer has space)

// This would block (buffer is full)
// ch <- 3

value := <-ch  // Now buffer has space
ch <- 3        // Can send
```

## Packages

### Import

```go
// Import single package
import "fmt"
import "os"

// Import multiple
import (
  "fmt"
  "os"
  "strings"
)

// Alias import
import (
  f "fmt"
  "strings"
)

f.Println("Hello")

// Blank import (execute init())
import _ "database/sql/driver"
```

### Creating Packages

```
myproject/
├── main.go
├── math/
│   └── calc.go
└── go.mod
```

```go
// math/calc.go
package math

// Exported function (capitalized)
func Add(a, b int) int {
  return a + b
}

// Unexported function (lowercase)
func internal(x int) int {
  return x * 2
}

// main.go
package main

import (
  "fmt"
  "myproject/math"
)

func main() {
  result := math.Add(5, 3)
  fmt.Println(result)
}
```

## Common Packages

### fmt

```go
import "fmt"

// Print
fmt.Print("Hello")           // No newline
fmt.Println("Hello")         // With newline
fmt.Printf("%s: %d\n", "Age", 30)

// Formatted strings
str := fmt.Sprintf("Name: %s", "John")

// Format verbs
%v    // Value (default)
%d    // Integer
%f    // Float
%s    // String
%t    // Boolean
%T    // Type
```

### strings

```go
import "strings"

s := "Hello, World!"

// Length
len(s)                                // 13
strings.Count(s, "l")                 // 3

// Search
strings.Contains(s, "World")          // true
strings.HasPrefix(s, "Hello")         // true
strings.HasSuffix(s, "!")             // true
strings.Index(s, "World")             // 7

// Transform
strings.ToUpper(s)                    // "HELLO, WORLD!"
strings.ToLower(s)                    // "hello, world!"
strings.Title(s)                      // "Hello, World!"
strings.TrimSpace("  hello  ")        // "hello"

// Split/Join
parts := strings.Split(s, ", ")       // ["Hello" "World!"]
strings.Join(parts, "-")              // "Hello-World!"

// Replace
strings.Replace(s, "World", "Go", 1)  // "Hello, Go!"
strings.ReplaceAll(s, "l", "L")       // "HeLLo, WorLd!"

// Compare
strings.EqualFold("Hello", "hello")   // true (case-insensitive)
```

### io

```go
import "io"

// io.Reader interface
type Reader interface {
  Read(p []byte) (n int, err error)
}

// io.Writer interface
type Writer interface {
  Write(p []byte) (n int, err error)
}

// Copy from reader to writer
io.Copy(writer, reader)

// WriteString
io.WriteString(w, "Hello")
```

### json

```go
import "encoding/json"

// Struct with JSON tags
type Person struct {
  Name string `json:"name"`
  Age  int    `json:"age"`
}

// Marshal (Go to JSON)
p := Person{"John", 30}
data, err := json.Marshal(p)
// data = []byte(`{"name":"John","age":30}`)

// Pretty print
data, _ := json.MarshalIndent(p, "", "  ")

// Unmarshal (JSON to Go)
var person Person
json.Unmarshal(data, &person)

// JSON tags
type User struct {
  Name  string `json:"name"`
  Email string `json:"email,omitempty"`    // Omit if empty
  ID    int    `json:"-"`                   // Ignore
}
```

### time

```go
import "time"

// Current time
now := time.Now()
fmt.Println(now)

// Parse time
t, _ := time.Parse("2006-01-02", "2024-01-12")

// Format time
fmt.Println(now.Format("2006-01-02 15:04:05"))

// Duration
d := 5 * time.Second
time.Sleep(d)

// Time arithmetic
future := now.Add(24 * time.Hour)
past := now.AddDate(0, 0, -1)

// Compare
if now.Before(future) {
  fmt.Println("future is later")
}
```

### http

```go
import (
  "net/http"
  "io"
)

// Simple server
http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
  io.WriteString(w, "Hello, World!")
})

http.ListenAndServe(":8080", nil)

// Make request
resp, err := http.Get("http://example.com")
defer resp.Body.Close()

body, _ := io.ReadAll(resp.Body)
fmt.Println(string(body))

// POST request
http.Post("http://example.com/api", "application/json", bodyReader)
```

## Testing

```go
// file_test.go
package main

import "testing"

func TestAdd(t *testing.T) {
  result := Add(2, 3)
  if result != 5 {
    t.Errorf("Add(2, 3) = %d; want 5", result)
  }
}

// Run tests
go test

// Verbose output
go test -v

// Run specific test
go test -run TestAdd

// Benchmark
func BenchmarkAdd(b *testing.B) {
  for i := 0; i < b.N; i++ {
    Add(2, 3)
  }
}

// Run benchmark
go test -bench=.
```

## Build & Run

```bash
# Run directly
go run main.go

# Build executable
go build                    # Outputs executable named after module
go build -o myapp          # Specify output name

# Install (build and place in GOBIN)
go install

# Get dependencies
go get package-name
go get -u                   # Update all

# Module initialization
go mod init mymodule        # Create go.mod

# Clean build cache
go clean -cache

# Format code
go fmt ./...

# Lint
go vet ./...

# Dependencies
go mod tidy                 # Clean up unused
go mod download             # Download dependencies
go mod vendor                # Create vendor directory
```
