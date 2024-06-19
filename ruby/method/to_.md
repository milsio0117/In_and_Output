## to_a
### 配列に変換する

1. 範囲オブジェクトに使う
```ruby
  (1..10).to_a
  => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  
  ("a".."g").to_a
  => ["a", "b", "c", "d", "e", "f", "g"]
```
## join
### 配列を結合する
```ruby
  array = ['ruby', 'python']
  p array.join
   => "rubypython"
```

区切り文字を指定する
```ruby
  array = ['ruby', 'python','java']
  p array.join(',')
  => "ruby,python,java"
```

## concat
### 配列の末尾に要素を連結する
```ruby
  array = ['ruby', 'python','java']
  array2 = ["swift","php"]
  p array.concat(array2)
  => ["ruby", "python", "java", "swift", "php"]
```
