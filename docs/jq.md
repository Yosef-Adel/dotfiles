# jq Reference

Quick reference for jq (JSON query). Use `/` to search in vim.

## Table of Contents

- [Basics](#basics)
  - [Identity](#identity)
  - [Pipe](#pipe)
  - [Comma](#comma)
- [Selectors](#selectors)
  - [Index](#index)
  - [Slice](#slice)
  - [Recursive Descent](#recursive-descent)
  - [Optional](#optional)
- [Array & Object Operations](#array--object-operations)
  - [keys / keys_unsorted](#keys--keys_unsorted)
  - [values](#values)
  - [length](#length)
  - [reverse](#reverse)
  - [sort / sort_by](#sort--sort_by)
  - [group_by](#group_by)
  - [unique / unique_by](#unique--unique_by)
  - [min / max / min_by / max_by](#min--max--min_by--max_by)
  - [add](#add)
  - [map](#map)
  - [select](#select)
  - [empty](#empty)
- [Type Operations](#type-operations)
  - [type](#type)
  - [has](#has)
  - [in](#in)
  - [contains / inside](#contains--inside)
  - [startswith / endswith](#startswith--endswith)
- [String Operations](#string-operations)
  - [split / join](#split--join)
  - [ltrimstr / rtrimstr](#ltrimstr--rtrimstr)
  - [ascii_downcase / ascii_upcase](#ascii_downcase--ascii_upcase)
  - [tostring / tonumber](#tostring--tonumber)
  - [test / match / capture](#test--match--capture)
  - [sub / gsub](#sub--gsub)
- [Math Operations](#math-operations)
  - [add](#add-1)
  - [min / max](#min--max)
  - [floor / ceil / round](#floor--ceil--round)
- [Conditionals](#conditionals)
  - [if-then-else](#if-then-else)
  - [and / or / not](#and--or--not)
- [Reduce & Recursion](#reduce--recursion)
  - [reduce](#reduce)
  - [recurse](#recurse)
  - [walk](#walk)
- [Variable Binding](#variable-binding)
  - [as](#as)
  - [def](#def)
- [Input/Output](#inputoutput)
  - [input / inputs](#input--inputs)
  - [@base64 / @uri / @csv / @json](#base64--uri--csv--json)
- [Advanced](#advanced)
  - [try-catch](#try-catch)
  - [path / paths](#path--paths)
  - [getpath / setpath / delpaths](#getpath--setpath--delpaths)
  - [to_entries / from_entries / with_entries](#to_entries--from_entries--with_entries)
  - [limit](#limit)
  - [first / last / nth](#first--last--nth)

## Basics

### Identity

The `.` operator returns the entire input.

```bash
echo '{"name": "John"}' | jq '.'
# {"name":"John"}

echo '[1,2,3]' | jq '.'
# [1,2,3]
```

### Pipe

Chain operations with `|`.

```bash
echo '{"user": {"name": "John"}}' | jq '.user | .name'
# "John"

echo '[1,2,3]' | jq '.[] | . * 2'
# 2, 4, 6
```

### Comma

Output multiple values with `,`.

```bash
echo '{"a":1,"b":2}' | jq '.a, .b'
# 1
# 2

echo '[1,2,3]' | jq '.[] | ., . * 2'
# 1, 2, 2, 4, 3, 6
```

## Selectors

### Index

Access object properties or array elements.

```bash
echo '{"name": "John", "age": 30}' | jq '.name'
# "John"

echo '["a","b","c"]' | jq '.[0]'
# "a"

echo '["a","b","c"]' | jq '.[-1]'
# "c"

# Iterate array
echo '["a","b","c"]' | jq '.[]'
# "a", "b", "c"
```

### Slice

Extract array subsequences.

```bash
echo '[0,1,2,3,4,5]' | jq '.[2:4]'
# [2,3]

echo '[0,1,2,3,4,5]' | jq '.[2:]'
# [2,3,4,5]

echo '[0,1,2,3,4,5]' | jq '.[:3]'
# [0,1,2]

echo '[0,1,2,3,4,5]' | jq '.[-2:]'
# [4,5]
```

### Recursive Descent

Search all levels with `..`.

```bash
echo '{"a":{"b":{"c":1}}}' | jq '.. | numbers'
# 1

echo '{"a":1,"b":{"c":2}}' | jq '[.. | objects]'
# [{"a":1,"b":{"c":2}},{"c":2}]
```

### Optional

Use `?` to suppress errors.

```bash
echo '{"name":"John"}' | jq '.age'
# null

echo '{"name":"John"}' | jq '.age?'
# null

echo 'null' | jq '.foo'
# error

echo 'null' | jq '.foo?'
# null
```

## Array & Object Operations

### keys / keys_unsorted

Get object keys or array indices.

```bash
echo '{"b":2,"a":1}' | jq 'keys'
# ["a","b"]

echo '{"b":2,"a":1}' | jq 'keys_unsorted'
# ["b","a"]

echo '[10,20,30]' | jq 'keys'
# [0,1,2]
```

### values

Get all values from object or array.

```bash
echo '{"a":1,"b":2}' | jq '.[]'
# 1, 2

echo '{"a":1,"b":2}' | jq '[.[]]'
# [1,2]
```

### length

Get length of array, object, string, or null.

```bash
echo '[1,2,3]' | jq 'length'
# 3

echo '"hello"' | jq 'length'
# 5

echo '{"a":1,"b":2}' | jq 'length'
# 2

echo 'null' | jq 'length'
# null
```

### reverse

Reverse array or string.

```bash
echo '[1,2,3]' | jq 'reverse'
# [3,2,1]

echo '"hello"' | jq 'reverse'
# "olleh"
```

### sort / sort_by

Sort array.

```bash
echo '[3,1,4,1,5]' | jq 'sort'
# [1,1,3,4,5]

echo '[{"age":30},{"age":20}]' | jq 'sort_by(.age)'
# [{"age":20},{"age":30}]

echo '[{"name":"Bob"},{"name":"Alice"}]' | jq 'sort_by(.name)'
# [{"name":"Alice"},{"name":"Bob"}]
```

### group_by

Group array by expression.

```bash
echo '[{"type":"a","val":1},{"type":"b","val":2},{"type":"a","val":3}]' | jq 'group_by(.type)'
# [[{"type":"a","val":1},{"type":"a","val":3}],[{"type":"b","val":2}]]
```

### unique / unique_by

Remove duplicates.

```bash
echo '[1,2,1,3,2]' | jq 'unique'
# [1,2,3]

echo '[{"id":1,"n":"a"},{"id":1,"n":"b"},{"id":2,"n":"c"}]' | jq 'unique_by(.id)'
# [{"id":1,"n":"a"},{"id":2,"n":"c"}]
```

### min / max / min_by / max_by

Find minimum or maximum.

```bash
echo '[3,1,4,1,5]' | jq 'min'
# 1

echo '[3,1,4,1,5]' | jq 'max'
# 5

echo '[{"age":30},{"age":20},{"age":25}]' | jq 'min_by(.age)'
# {"age":20}

echo '[{"age":30},{"age":20},{"age":25}]' | jq 'max_by(.age)'
# {"age":30}
```

### add

Sum array elements or concatenate.

```bash
echo '[1,2,3]' | jq 'add'
# 6

echo '["a","b","c"]' | jq 'add'
# "abc"

echo '[[1,2],[3,4]]' | jq 'add'
# [1,2,3,4]
```

### map

Transform each element.

```bash
echo '[1,2,3]' | jq 'map(. * 2)'
# [2,4,6]

echo '[{"name":"John","age":30}]' | jq 'map(.name)'
# ["John"]
```

### select

Filter elements by condition.

```bash
echo '[1,2,3,4,5]' | jq '[.[] | select(. > 2)]'
# [3,4,5]

echo '[{"name":"John","age":30},{"name":"Jane","age":17}]' | jq '[.[] | select(.age >= 18)]'
# [{"name":"John","age":30}]
```

### empty

Produce no output.

```bash
echo '[1,2,3]' | jq '[.[] | if . == 2 then empty else . end]'
# [1,3]
```

## Type Operations

### type

Get type of value.

```bash
echo '123' | jq 'type'
# "number"

echo '"hello"' | jq 'type'
# "string"

echo '[]' | jq 'type'
# "array"

echo 'null' | jq 'type'
# "null"
```

### has

Check if object has key or array has index.

```bash
echo '{"a":1,"b":2}' | jq 'has("a")'
# true

echo '{"a":1,"b":2}' | jq 'has("c")'
# false

echo '[1,2,3]' | jq 'has(1)'
# true
```

### in

Check if key exists in object.

```bash
echo '{"a":1}' | jq '"a" | in({"a":1,"b":2})'
# true
```

### contains / inside

Check if value contains or is inside another.

```bash
echo '"foobar"' | jq 'contains("foo")'
# true

echo '[1,2,3]' | jq 'contains([2])'
# true

echo '{"a":1,"b":2}' | jq 'contains({"a":1})'
# true
```

### startswith / endswith

Check string prefix/suffix.

```bash
echo '"hello"' | jq 'startswith("he")'
# true

echo '"hello"' | jq 'endswith("lo")'
# true
```

## String Operations

### split / join

Split string or join array.

```bash
echo '"a,b,c"' | jq 'split(",")'
# ["a","b","c"]

echo '["a","b","c"]' | jq 'join(",")'
# "a,b,c"

echo '["a","b","c"]' | jq 'join("-")'
# "a-b-c"
```

### ltrimstr / rtrimstr

Remove prefix or suffix.

```bash
echo '"hello"' | jq 'ltrimstr("he")'
# "llo"

echo '"hello"' | jq 'rtrimstr("lo")'
# "hel"
```

### ascii_downcase / ascii_upcase

Change case.

```bash
echo '"Hello World"' | jq 'ascii_downcase'
# "hello world"

echo '"Hello World"' | jq 'ascii_upcase'
# "HELLO WORLD"
```

### tostring / tonumber

Convert types.

```bash
echo '123' | jq 'tostring'
# "123"

echo '"123"' | jq 'tonumber'
# 123
```

### test / match / capture

Test regex or extract matches.

```bash
echo '"test123"' | jq 'test("[0-9]+")'
# true

echo '"test123abc"' | jq 'match("[0-9]+")'
# {"offset":4,"length":3,"string":"123","captures":[]}

echo '"test123"' | jq '[match("[0-9]+"; "g")] | map(.string)'
# ["123"]

echo '"foo123bar"' | jq 'capture("foo(?<num>[0-9]+)")'
# {"num":"123"}
```

### sub / gsub

Replace first or all occurrences.

```bash
echo '"hello world"' | jq 'sub("world"; "earth")'
# "hello earth"

echo '"hello world world"' | jq 'gsub("world"; "earth")'
# "hello earth earth"
```

## Math Operations

### add

Sum array.

```bash
echo '[1,2,3,4]' | jq 'add'
# 10
```

### min / max

Find minimum or maximum.

```bash
echo '[3,1,4,1,5]' | jq 'min'
# 1

echo '[3,1,4,1,5]' | jq 'max'
# 5
```

### floor / ceil / round

Round numbers.

```bash
echo '3.7' | jq 'floor'
# 3

echo '3.2' | jq 'ceil'
# 4

echo '3.5' | jq 'round'
# 4
```

## Conditionals

### if-then-else

Conditional execution.

```bash
echo '5' | jq 'if . > 3 then "big" else "small" end'
# "big"

echo '[1,2,3,4,5]' | jq '[.[] | if . % 2 == 0 then "even" else "odd" end]'
# ["odd","even","odd","even","odd"]
```

### and / or / not

Logical operators.

```bash
echo 'null' | jq 'true and false'
# false

echo 'null' | jq 'true or false'
# true

echo 'true' | jq 'not'
# false
```

## Reduce & Recursion

### reduce

Accumulate values.

```bash
echo '[1,2,3,4]' | jq 'reduce .[] as $x (0; . + $x)'
# 10

echo '[{"name":"John","age":30},{"name":"Jane","age":25}]' | jq 'reduce .[] as $person ({}; .[$person.name] = $person.age)'
# {"John":30,"Jane":25}
```

### recurse

Recursively apply function.

```bash
echo '{"a":{"b":{"c":1}}}' | jq 'recurse(.a?, .b?, .c?)'
# {"a":{"b":{"c":1}}}, {"b":{"c":1}}, {"c":1}, 1

echo '2' | jq '[., 1] | recurse(.[0] - 1; . >= 0)'
# [2,1], [1,1], [0,1]
```

### walk

Recursively transform structure.

```bash
echo '{"a":{"b":1}}' | jq 'walk(if type == "number" then . * 2 else . end)'
# {"a":{"b":2}}
```

## Variable Binding

### as

Bind value to variable.

```bash
echo '[1,2,3]' | jq '.[] as $x | $x * $x'
# 1, 4, 9

echo '{"a":1,"b":2}' | jq '.a as $x | .b as $y | $x + $y'
# 3
```

### def

Define reusable function.

```bash
echo '[1,2,3]' | jq 'def double: . * 2; map(double)'
# [2,4,6]

echo '[1,2,3,4]' | jq 'def is_even: . % 2 == 0; map(select(is_even))'
# [2,4]
```

## Input/Output

### input / inputs

Read additional inputs.

```bash
# Multiple JSON objects
echo -e '1\n2\n3' | jq -s 'add'
# 6

# First input
echo -e '1\n2\n3' | jq '[., input]'
# [1,2]

# All inputs
echo -e '{"a":1}\n{"b":2}' | jq -s 'add'
# {"a":1,"b":2}
```

### @base64 / @uri / @csv / @json

Format output.

```bash
echo '"hello"' | jq '@base64'
# "aGVsbG8="

echo '"hello world"' | jq '@uri'
# "hello%20world"

echo '["a","b","c"]' | jq '@csv'
# "\"a\",\"b\",\"c\""

echo '{"a":1}' | jq '@json'
# "{\"a\":1}"
```

## Advanced

### try-catch

Handle errors.

```bash
echo '{"a":1}' | jq 'try .b.c catch "error"'
# null

echo '"not a number"' | jq 'try tonumber catch "invalid"'
# "invalid"
```

### path / paths

Get paths to all values.

```bash
echo '{"a":{"b":1,"c":2}}' | jq 'paths'
# ["a"], ["a","b"], ["a","c"]

echo '{"a":{"b":1,"c":2}}' | jq 'paths(scalars)'
# ["a","b"], ["a","c"]
```

### getpath / setpath / delpaths

Manipulate nested structures.

```bash
echo '{"a":{"b":1}}' | jq 'getpath(["a","b"])'
# 1

echo '{"a":{"b":1}}' | jq 'setpath(["a","c"]; 2)'
# {"a":{"b":1,"c":2}}

echo '{"a":{"b":1,"c":2}}' | jq 'delpaths([["a","b"]])'
# {"a":{"c":2}}
```

### to_entries / from_entries / with_entries

Transform between objects and key-value pairs.

```bash
echo '{"a":1,"b":2}' | jq 'to_entries'
# [{"key":"a","value":1},{"key":"b","value":2}]

echo '[{"key":"a","value":1}]' | jq 'from_entries'
# {"a":1}

echo '{"a":1,"b":2}' | jq 'with_entries(.value = .value * 2)'
# {"a":2,"b":4}
```

### limit

Limit output count.

```bash
echo 'null' | jq '[limit(3; range(10))]'
# [0,1,2]

echo '[1,2,3,4,5]' | jq '[limit(2; .[])]'
# [1,2]
```

### first / last / nth

Get specific elements.

```bash
echo 'null' | jq 'first(range(10))'
# 0

echo '[1,2,3,4,5]' | jq 'first(.[])'
# 1

echo '[1,2,3,4,5]' | jq 'last(.[])'
# 5

echo 'null' | jq 'nth(2; range(10))'
# 2
```
