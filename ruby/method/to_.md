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

長さ3の配列を作り、改行を除いてgetsし、|でjoinする
```ruby
  puts Array.new(3) { gets.chomp }.join('|')
```

## concat
### 配列の末尾に要素を連結する
```ruby
  array = ['ruby', 'python','java']
  array2 = ["swift","php"]
  p array.concat(array2)
  => ["ruby", "python", "java", "swift", "php"]
```

## each_with_index
### 要素の繰り返し処理と同時に、その要素が何番目に処理されたのかも表す
```ruby
  fruits = ["メロン", "バナナ", "アップル"]
  
  fruits.each_with_index do |item, i|
   puts "#{i}番目のフルーツは、#{item}です。"
  end
```


## slice!
### 指定した範囲を文字列から取り除いたうえ、取り除いた部分文字列を返す
