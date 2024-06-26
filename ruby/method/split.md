## split
### 指定した文字列で分割し、それを配列で返す
### 構文："文字列".split(区切り文字, 分割数)
1. 引数なし（gets.split()の場合も同じ挙動）
```ruby
  gets.split
  apple orange
  => ["apple", "orange"]
```


2. 全てを１文字ずつ取り出す
```ruby
  gets.split("")
  apple orange
  => ["a", "p", "p", "l", "e", " ", "o", "r", "a", "n", "g", "e", "\n"]  #改行も含まれる
```

3. , で区切る
```ruby
   'Yamada, Satou, Itou, Suzuki'.split(',')
  => ["Yamada", " Satou", " Itou", " Suzuki"]
```

4. 分割数の指定
```ruby
   'Yamada, Satou, Itou, Suzuki'.split(',', 2)
  => ["Yamada", " Satou, Itou, Suzuki"]
```

5. 分割数の制限
```ruby
   'Yamada, Satou, Itou, Suzuki'.split(',').first
  => "Yamada"
```

6. 最初の要素だけを取り出す
```ruby
  first = "abc,def,g".split(',', 2).first
  => "abc"
```

7. mapと組み合わせる
```ruby
   "1,2,55,6,9,3".split(',').map(&:to_i)
  => [1, 2, 55, 6, 9, 3] #strからintに

  gets.split.map(&:to_i)
  300 456
  => [300, 456]
```
