## keyword list

```elixir
list = [{:a, 1}, {:b, 2}]
i list
```

查看变量 list 的信息: 

```
Term
  [a: 1, b: 2]
Data type
  List
Description
  This is what is referred to as a "keyword list". A keyword list is a list
  of two-element tuples where the first element of each tuple is an atom.
Reference modules
  Keyword, List
Implemented protocols
  Collectable, Enumerable, IEx.Info, Inspect, List.Chars, String.Chars
```

关键字列表 `[{:a, 1}, {:b, 2}]` 可以简写为 `[a: 1, b: 2]`:

```elixir
list == [a: 1, b: 2]
true
```

`{:a, 1}` 是键值对儿形式, 其中键是一个 Atom。



```elixir
if true, do: :this, else: :that
```

`do: :this` 和 `else: :that` 是关键字了列表。

```
iex(257)> i do: :this
Term
  [do: :this]
Data type
  List
Description
  This is what is referred to as a "keyword list". A keyword list is a list
  of two-element tuples where the first element of each tuple is an atom.
Reference modules
  Keyword, List
Implemented protocols
  Collectable, Enumerable, IEx.Info, Inspect, List.Chars, String.Chars
```

上面的表达式相当于:

```elixir
if(true, [do: :this, else: :that])
:this
```

上面的表达式还相当于:

```elixir
if(true, [{:do, :this}, {:else, :that}])
:this
```

`v` 是上一次计算的结果。

## map

```elixir
map = %{:a => 1, :b => 2, :c => 3}

# use | notation to update a map
%{map | a: 0}

# key must exist when update a map
%{map | z: :opps}

# get value from map
map[:a] # 1
map[:z] # nil
```

Map 允许任何值作为键。

Map 在模式匹配时比关键字列表更有用。Map 可以对给定值的子集做模式匹配:

```elixir
%{:a => x} = map
%{a: x} = map
```

a map matches as long as the keys in the pattern exist in the given map.

变量可以作为 Map 的键:

```elixir
n = "name"
map = %{n => "Larry Wall", :language => "Perl 6", released: ~D[2015-12-25]}
```

字符串作为 Map 的键时, 无法使用点号和 atom 标记获取键值:

```elixir
map.name     # key :name not found
map[:name]   # nil
map["name"]  # "Larry Wall"
map[n]       # "Larry Wall" 
map.language # "Perl6"
map.released # ~D[2015-12-25]

%{^n => x} = map        # pattern match with pin variable
Map.get(map, "name")    # "Larry Wall"
Map.get(map, n)         # "Larry Wall"
Map.get(map, :language) # "Perl 6"

# use put to update a map
Map.put(map, n, "Bill")
Map.put(map, "name", "Bill")
Map.put(map, :language, "Raku")

# put a new entry into map
Map.put(map, :version, "6.d")

# convert Map to List
Map.to_list(map)
```

## 嵌套数据结构

- put_in/2
- update_in/2

```elixir
users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

# get nested filed from nested data strcuture
users[:john].age

# update a nested data structre
put_in(user[:john].age, 31)

# remove a value from inner data strucure
update_in(users[:mary].languages, fn language -> List.delete(language, "F#") end)
```