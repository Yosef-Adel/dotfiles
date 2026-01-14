*jq.txt*  jq Reference

==============================================================================
CONTENTS                                                          *jq-contents*

1. Basics ................................ |jq-basics|
   - Identity ............................ |jq-identity|
   - Pipe ................................ |jq-pipe|
   - Comma ............................... |jq-comma|
2. Selectors ............................. |jq-selectors|
   - Index ............................... |jq-index|
   - Slice ............................... |jq-slice|
   - Recursive Descent ................... |jq-recursive|
   - Optional ............................ |jq-optional|
3. Array & Object Operations ............. |jq-array-object|
   - keys / keys_unsorted ................ |jq-keys|
   - values .............................. |jq-values|
   - length .............................. |jq-length|
   - reverse ............................. |jq-reverse|
   - sort / sort_by ...................... |jq-sort|
   - group_by ............................ |jq-group-by|
   - unique / unique_by .................. |jq-unique|
   - min / max / min_by / max_by ......... |jq-min-max|
   - add ................................. |jq-add|
   - map ................................. |jq-map|
   - select .............................. |jq-select|
   - empty ............................... |jq-empty|
4. Type Operations ....................... |jq-type-ops|
   - type ................................ |jq-type|
   - has ................................. |jq-has|
   - in .................................. |jq-in|
   - contains / inside ................... |jq-contains|
   - startswith / endswith ............... |jq-startswith|
5. String Operations ..................... |jq-string-ops|
   - split / join ........................ |jq-split|
   - ltrimstr / rtrimstr ................. |jq-trimstr|
   - ascii_downcase / ascii_upcase ....... |jq-case|
   - tostring / tonumber ................. |jq-convert|
   - test / match / capture .............. |jq-regex|
   - sub / gsub .......................... |jq-sub|
6. Math Operations ....................... |jq-math-ops|
   - add ................................. |jq-math-add|
   - min / max ........................... |jq-math-minmax|
   - floor / ceil / round ................ |jq-round|
7. Conditionals .......................... |jq-conditionals|
   - if-then-else ........................ |jq-if|
   - and / or / not ...................... |jq-logical|
8. Reduce & Recursion .................... |jq-reduce-recursion|
   - reduce .............................. |jq-reduce|
   - recurse ............................. |jq-recurse|
   - walk ................................ |jq-walk|
9. Variable Binding ...................... |jq-variables|
   - as .................................. |jq-as|
   - def ................................. |jq-def|
10. Input/Output ......................... |jq-io|
    - input / inputs ..................... |jq-input|
    - @base64 / @uri / @csv / @json ...... |jq-format|
11. Advanced ............................. |jq-advanced|
    - try-catch .......................... |jq-try|
    - path / paths ....................... |jq-path|
    - getpath / setpath / delpaths ....... |jq-getpath|
    - to_entries / from_entries .......... |jq-entries|
    - limit .............................. |jq-limit|
    - first / last / nth ................. |jq-first|

==============================================================================
1. BASICS                                                          *jq-basics*

Identity~                                                       *jq-identity*
>
    The . operator returns the entire input.

    echo '{"name": "John"}' | jq '.'
    # {"name":"John"}

    echo '[1,2,3]' | jq '.'
    # [1,2,3]
<

Pipe~                                                              *jq-pipe*
>
    Chain operations with |.

    echo '{"user": {"name": "John"}}' | jq '.user | .name'
    # "John"

    echo '[1,2,3]' | jq '.[] | . * 2'
    # 2, 4, 6
<

Comma~                                                            *jq-comma*
>
    Output multiple values with ,.

    echo '{"a":1,"b":2}' | jq '.a, .b'
    # 1
    # 2

    echo '[1,2,3]' | jq '.[] | ., . * 2'
    # 1, 2, 2, 4, 3, 6
<

==============================================================================
2. SELECTORS                                                   *jq-selectors*

Index~                                                            *jq-index*
>
    Access object properties or array elements.

    echo '{"name": "John", "age": 30}' | jq '.name'
    # "John"

    echo '["a","b","c"]' | jq '.[0]'
    # "a"

    echo '["a","b","c"]' | jq '.[-1]'
    # "c"

    # Iterate array
    echo '["a","b","c"]' | jq '.[]'
    # "a", "b", "c"
<

Slice~                                                            *jq-slice*
>
    Extract array subsequences.

    echo '[0,1,2,3,4,5]' | jq '.[2:4]'
    # [2,3]

    echo '[0,1,2,3,4,5]' | jq '.[2:]'
    # [2,3,4,5]

    echo '[0,1,2,3,4,5]' | jq '.[:3]'
    # [0,1,2]

    echo '[0,1,2,3,4,5]' | jq '.[-2:]'
    # [4,5]
<

Recursive Descent~                                           *jq-recursive*
>
    Search all levels with ..

    echo '{"a":{"b":{"c":1}}}' | jq '.. | numbers'
    # 1

    echo '{"a":1,"b":{"c":2}}' | jq '[.. | objects]'
    # [{"a":1,"b":{"c":2}},{"c":2}]
<

Optional~                                                       *jq-optional*
>
    Use ? to suppress errors.

    echo '{"name":"John"}' | jq '.age'
    # null

    echo '{"name":"John"}' | jq '.age?'
    # null

    echo 'null' | jq '.foo'
    # error

    echo 'null' | jq '.foo?'
    # null
<

==============================================================================
3. ARRAY & OBJECT OPERATIONS                              *jq-array-object*

keys / keys_unsorted~                                             *jq-keys*
>
    Get object keys or array indices.

    echo '{"b":2,"a":1}' | jq 'keys'
    # ["a","b"]

    echo '{"b":2,"a":1}' | jq 'keys_unsorted'
    # ["b","a"]

    echo '[10,20,30]' | jq 'keys'
    # [0,1,2]
<

values~                                                          *jq-values*
>
    Get all values from object or array.

    echo '{"a":1,"b":2}' | jq '.[]'
    # 1, 2

    echo '{"a":1,"b":2}' | jq '[.[]]'
    # [1,2]
<

length~                                                          *jq-length*
>
    Get length of array, object, string, or null.

    echo '[1,2,3]' | jq 'length'
    # 3

    echo '"hello"' | jq 'length'
    # 5

    echo '{"a":1,"b":2}' | jq 'length'
    # 2

    echo 'null' | jq 'length'
    # null
<

reverse~                                                        *jq-reverse*
>
    Reverse array or string.

    echo '[1,2,3]' | jq 'reverse'
    # [3,2,1]

    echo '"hello"' | jq 'reverse'
    # "olleh"
<

sort / sort_by~                                                   *jq-sort*
>
    Sort array.

    echo '[3,1,4,1,5]' | jq 'sort'
    # [1,1,3,4,5]

    echo '[{"age":30},{"age":20}]' | jq 'sort_by(.age)'
    # [{"age":20},{"age":30}]

    echo '[{"name":"Bob"},{"name":"Alice"}]' | jq 'sort_by(.name)'
    # [{"name":"Alice"},{"name":"Bob"}]
<

group_by~                                                      *jq-group-by*
>
    Group array by expression.

    echo '[{"type":"a","val":1},{"type":"b","val":2},{"type":"a","val":3}]' | jq 'group_by(.type)'
    # [[{"type":"a","val":1},{"type":"a","val":3}],[{"type":"b","val":2}]]
<

unique / unique_by~                                             *jq-unique*
>
    Remove duplicates.

    echo '[1,2,1,3,2]' | jq 'unique'
    # [1,2,3]

    echo '[{"id":1,"n":"a"},{"id":1,"n":"b"},{"id":2,"n":"c"}]' | jq 'unique_by(.id)'
    # [{"id":1,"n":"a"},{"id":2,"n":"c"}]
<

min / max / min_by / max_by~                                   *jq-min-max*
>
    Find minimum or maximum.

    echo '[3,1,4,1,5]' | jq 'min'
    # 1

    echo '[3,1,4,1,5]' | jq 'max'
    # 5

    echo '[{"age":30},{"age":20},{"age":25}]' | jq 'min_by(.age)'
    # {"age":20}

    echo '[{"age":30},{"age":20},{"age":25}]' | jq 'max_by(.age)'
    # {"age":30}
<

add~                                                               *jq-add*
>
    Sum array elements or concatenate.

    echo '[1,2,3]' | jq 'add'
    # 6

    echo '["a","b","c"]' | jq 'add'
    # "abc"

    echo '[[1,2],[3,4]]' | jq 'add'
    # [1,2,3,4]
<

map~                                                               *jq-map*
>
    Transform each element.

    echo '[1,2,3]' | jq 'map(. * 2)'
    # [2,4,6]

    echo '[{"name":"John","age":30}]' | jq 'map(.name)'
    # ["John"]
<

select~                                                          *jq-select*
>
    Filter elements by condition.

    echo '[1,2,3,4,5]' | jq '[.[] | select(. > 2)]'
    # [3,4,5]

    echo '[{"name":"John","age":30},{"name":"Jane","age":17}]' | jq '[.[] | select(.age >= 18)]'
    # [{"name":"John","age":30}]
<

empty~                                                            *jq-empty*
>
    Produce no output.

    echo '[1,2,3]' | jq '[.[] | if . == 2 then empty else . end]'
    # [1,3]
<

==============================================================================
4. TYPE OPERATIONS                                            *jq-type-ops*

type~                                                              *jq-type*
>
    Get type of value.

    echo '123' | jq 'type'
    # "number"

    echo '"hello"' | jq 'type'
    # "string"

    echo '[]' | jq 'type'
    # "array"

    echo 'null' | jq 'type'
    # "null"
<

has~                                                                *jq-has*
>
    Check if object has key or array has index.

    echo '{"a":1,"b":2}' | jq 'has("a")'
    # true

    echo '{"a":1,"b":2}' | jq 'has("c")'
    # false

    echo '[1,2,3]' | jq 'has(1)'
    # true
<

in~                                                                  *jq-in*
>
    Check if key exists in object.

    echo '{"a":1}' | jq '"a" | in({"a":1,"b":2})'
    # true
<

contains / inside~                                            *jq-contains*
>
    Check if value contains or is inside another.

    echo '"foobar"' | jq 'contains("foo")'
    # true

    echo '[1,2,3]' | jq 'contains([2])'
    # true

    echo '{"a":1,"b":2}' | jq 'contains({"a":1})'
    # true
<

startswith / endswith~                                      *jq-startswith*
>
    Check string prefix/suffix.

    echo '"hello"' | jq 'startswith("he")'
    # true

    echo '"hello"' | jq 'endswith("lo")'
    # true
<

==============================================================================
5. STRING OPERATIONS                                        *jq-string-ops*

split / join~                                                    *jq-split*
>
    Split string or join array.

    echo '"a,b,c"' | jq 'split(",")'
    # ["a","b","c"]

    echo '["a","b","c"]' | jq 'join(",")'
    # "a,b,c"

    echo '["a","b","c"]' | jq 'join("-")'
    # "a-b-c"
<

ltrimstr / rtrimstr~                                           *jq-trimstr*
>
    Remove prefix or suffix.

    echo '"hello"' | jq 'ltrimstr("he")'
    # "llo"

    echo '"hello"' | jq 'rtrimstr("lo")'
    # "hel"
<

ascii_downcase / ascii_upcase~                                    *jq-case*
>
    Change case.

    echo '"Hello World"' | jq 'ascii_downcase'
    # "hello world"

    echo '"Hello World"' | jq 'ascii_upcase'
    # "HELLO WORLD"
<

tostring / tonumber~                                           *jq-convert*
>
    Convert types.

    echo '123' | jq 'tostring'
    # "123"

    echo '"123"' | jq 'tonumber'
    # 123
<

test / match / capture~                                          *jq-regex*
>
    Test regex or extract matches.

    echo '"test123"' | jq 'test("[0-9]+")'
    # true

    echo '"test123abc"' | jq 'match("[0-9]+")'
    # {"offset":4,"length":3,"string":"123","captures":[]}

    echo '"test123"' | jq '[match("[0-9]+"; "g")] | map(.string)'
    # ["123"]

    echo '"foo123bar"' | jq 'capture("foo(?<num>[0-9]+)")'
    # {"num":"123"}
<

sub / gsub~                                                         *jq-sub*
>
    Replace first or all occurrences.

    echo '"hello world"' | jq 'sub("world"; "earth")'
    # "hello earth"

    echo '"hello world world"' | jq 'gsub("world"; "earth")'
    # "hello earth earth"
<

==============================================================================
6. MATH OPERATIONS                                            *jq-math-ops*

add~                                                           *jq-math-add*
>
    Sum array.

    echo '[1,2,3,4]' | jq 'add'
    # 10
<

min / max~                                                   *jq-math-minmax*
>
    Find minimum or maximum.

    echo '[3,1,4,1,5]' | jq 'min'
    # 1

    echo '[3,1,4,1,5]' | jq 'max'
    # 5
<

floor / ceil / round~                                            *jq-round*
>
    Round numbers.

    echo '3.7' | jq 'floor'
    # 3

    echo '3.2' | jq 'ceil'
    # 4

    echo '3.5' | jq 'round'
    # 4
<

==============================================================================
7. CONDITIONALS                                            *jq-conditionals*

if-then-else~                                                       *jq-if*
>
    Conditional execution.

    echo '5' | jq 'if . > 3 then "big" else "small" end'
    # "big"

    echo '[1,2,3,4,5]' | jq '[.[] | if . % 2 == 0 then "even" else "odd" end]'
    # ["odd","even","odd","even","odd"]
<

and / or / not~                                                 *jq-logical*
>
    Logical operators.

    echo 'null' | jq 'true and false'
    # false

    echo 'null' | jq 'true or false'
    # true

    echo 'true' | jq 'not'
    # false
<

==============================================================================
8. REDUCE & RECURSION                                   *jq-reduce-recursion*

reduce~                                                          *jq-reduce*
>
    Accumulate values.

    echo '[1,2,3,4]' | jq 'reduce .[] as $x (0; . + $x)'
    # 10

    echo '[{"name":"John","age":30},{"name":"Jane","age":25}]' | jq 'reduce .[] as $person ({}; .[$person.name] = $person.age)'
    # {"John":30,"Jane":25}
<

recurse~                                                        *jq-recurse*
>
    Recursively apply function.

    echo '{"a":{"b":{"c":1}}}' | jq 'recurse(.a?, .b?, .c?)'
    # {"a":{"b":{"c":1}}}, {"b":{"c":1}}, {"c":1}, 1
<

walk~                                                              *jq-walk*
>
    Recursively transform structure.

    echo '{"a":{"b":1}}' | jq 'walk(if type == "number" then . * 2 else . end)'
    # {"a":{"b":2}}
<

==============================================================================
9. VARIABLE BINDING                                          *jq-variables*

as~                                                                  *jq-as*
>
    Bind value to variable.

    echo '[1,2,3]' | jq '.[] as $x | $x * $x'
    # 1, 4, 9

    echo '{"a":1,"b":2}' | jq '.a as $x | .b as $y | $x + $y'
    # 3
<

def~                                                                *jq-def*
>
    Define reusable function.

    echo '[1,2,3]' | jq 'def double: . * 2; map(double)'
    # [2,4,6]

    echo '[1,2,3,4]' | jq 'def is_even: . % 2 == 0; map(select(is_even))'
    # [2,4]
<

==============================================================================
10. INPUT/OUTPUT                                                     *jq-io*

input / inputs~                                                  *jq-input*
>
    Read additional inputs.

    # Multiple JSON objects
    echo -e '1\n2\n3' | jq -s 'add'
    # 6

    # First input
    echo -e '1\n2\n3' | jq '[., input]'
    # [1,2]

    # All inputs
    echo -e '{"a":1}\n{"b":2}' | jq -s 'add'
    # {"a":1,"b":2}
<

@base64 / @uri / @csv / @json~                                  *jq-format*
>
    Format output.

    echo '"hello"' | jq '@base64'
    # "aGVsbG8="

    echo '"hello world"' | jq '@uri'
    # "hello%20world"

    echo '["a","b","c"]' | jq '@csv'
    # "\"a\",\"b\",\"c\""

    echo '{"a":1}' | jq '@json'
    # "{\"a\":1}"
<

==============================================================================
11. ADVANCED                                                   *jq-advanced*

try-catch~                                                          *jq-try*
>
    Handle errors.

    echo '{"a":1}' | jq 'try .b.c catch "error"'
    # null

    echo '"not a number"' | jq 'try tonumber catch "invalid"'
    # "invalid"
<

path / paths~                                                      *jq-path*
>
    Get paths to all values.

    echo '{"a":{"b":1,"c":2}}' | jq 'paths'
    # ["a"], ["a","b"], ["a","c"]

    echo '{"a":{"b":1,"c":2}}' | jq 'paths(scalars)'
    # ["a","b"], ["a","c"]
<

getpath / setpath / delpaths~                                   *jq-getpath*
>
    Manipulate nested structures.

    echo '{"a":{"b":1}}' | jq 'getpath(["a","b"])'
    # 1

    echo '{"a":{"b":1}}' | jq 'setpath(["a","c"]; 2)'
    # {"a":{"b":1,"c":2}}

    echo '{"a":{"b":1,"c":2}}' | jq 'delpaths([["a","b"]])'
    # {"a":{"c":2}}
<

to_entries / from_entries / with_entries~                       *jq-entries*
>
    Transform between objects and key-value pairs.

    echo '{"a":1,"b":2}' | jq 'to_entries'
    # [{"key":"a","value":1},{"key":"b","value":2}]

    echo '[{"key":"a","value":1}]' | jq 'from_entries'
    # {"a":1}

    echo '{"a":1,"b":2}' | jq 'with_entries(.value = .value * 2)'
    # {"a":2,"b":4}
<

limit~                                                            *jq-limit*
>
    Limit output count.

    echo 'null' | jq '[limit(3; range(10))]'
    # [0,1,2]

    echo '[1,2,3,4,5]' | jq '[limit(2; .[])]'
    # [1,2]
<

first / last / nth~                                              *jq-first*
>
    Get specific elements.

    echo 'null' | jq 'first(range(10))'
    # 0

    echo '[1,2,3,4,5]' | jq 'first(.[])'
    # 1

    echo '[1,2,3,4,5]' | jq 'last(.[])'
    # 5

    echo 'null' | jq 'nth(2; range(10))'
    # 2
<

==============================================================================
vim:tw=78:ts=8:ft=help:norl:
