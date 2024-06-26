## to_a
### 配列に変換する
範囲オブジェクトに使う場合
```ruby
  (1..10).to_a
  => [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  
  ("a".."g").to_a
  => ["a", "b", "c", "d", "e", "f", "g"]
```

## sub
### マッチした最初の一箇所を置換する
` 文字列.sub(/正規表現/, '変換後の文字') `
```ruby
string = "ruby ruby ruby"
puts string.sub(/ruby/, 'python')  # python ruby ruby
```

## gsub
### マッチした部分をすべて置換する
```ruby
string = "ruby ruby ruby"
puts string.gsub(/ruby/, 'python')  # python python python
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

## slice
### 配列や文字列から指定した要素を取り出す。元の配列は変わらない
```ruby
array = [0,1,2,3,4,5,6]

ele = array.slice(1)
puts ele  # 1
```
これはsliceがなくても同じ

```ruby
ele = array[1]
puts ele  # 1
```

引数の時はsliceを使わないと取れない
```ruby
def example(str)
    puts str.slice(1)
end

example('Hello')  # e


def example(str)
    puts str(1)
end

example('Hello') # error!
```

## slice!(破壊的Slice)
### 指定した範囲を文字列から取り除いたうえ、取り除いた部分文字列を返す  
```ruby
array = [0, 1, 2, 3, 4, 5]
num = array.slice!(1)

p num  # 1
p array # [0, 2, 3, 4, 5]

```

## scan
### 引数で指定した正規表現のパターンからマッチした文字列を取得していき、配列として返す  
` 調べる元の文字列".scan"調べたい文字列or正規表現 `
```ruby
  "foobar".scan(/../)    # => ["fo", "ob", "ar"]　# (/ww/)も同じ
  "foobar".scan("o")     # => ["o", "o"]
  "foobarbazfoobarbaz".scan(/ba./)    # => ["bar", "baz", "bar", "baz"]
```

## index
### 文字列や配列の中に指定した文字列が含まれていた場合、その文字列の開始位置を整数の値で返す
` str.index(検索したい文字列, [開始する位置]) `
```ruby
  def count_code(str)
   puts str.index("code") +1  # 文字の0番目を1と表示させる場合
  end
  
  count_code("codexxcode") # 1
```

## even?
### 対象の数値が偶数かどうかを判断する。奇数はodd?
### 与えられた整数が偶数であればtrue、奇数であればfalseを返す。小数点(float)はNoMethodErrorとなる


## select
### 条件式に一致した要素を取得する。条件以外の時はreject
### 変数に要素を一つずつ格納しながら処理が真になったときの要素を取得していき、新しい配列として返す
` 配列.select { |変数| 処理 } `
```ruby
  array = [1,2,3,4,5]
  p array.select { |num| num > 3 }　# [4, 5]
```

include?と一緒に使う応用系
```ruby
  array = ["right","light","erect","elect"]
  p array.select{|a| a.include?("ect")}  # ["erect", "elect"]
```


## map
### 要素に変更を加えて新たな配列を返す
```ruby
  array = [1,2,3,4,5]
  p array.select{|num| num > 3}  # [4,5] 要素の絞り込みを行うだけ
  p array.map{|num| num*3 if num > 3}  # [nil,nil,nil,12,15]
```

## digits
### 桁ごとの数字を一つずつ配列の中に入れる。対象は非負整数のみ
```ruby
  1234.digits　　# [4, 3, 2, 1]　逆から取られる
```

## chars
### 1文字ずつ分割し配列を作る
```ruby
  "hello".chars　　# ["h", "e", "l", "l", "o"]
```
文字列が数字だと、他のメソッドと組み合わせ「各位を足しあわせた合計値」が出せる
```ruby
  list = "12345".chars.map(&:to_i)
  p list    # [1, 2, 3, 4, 5]
  p list.sum    # 15
```

## format
### 引数をフォーマットした文字列を返す
format("フォーマット文字列", 形成元1, 形成元2, ...)
* %が開始記号
* #は数値が1桁の場合でも前にスペースを挿入する
* %dは整数を、%fは浮動小数点数を、%sは文字列を表す
* %,dは整数を3桁ごとにカンマで区切って出力する
```ruby
  number = 1000
  formatted_number = format("%,d", number)
  puts formatted_number  # 1,000
```

* %.2fは浮動小数点数を小数点以下2桁に丸めて出力する
```ruby
  pi = 3.14159265
  formatted_pi = format("%.2f", pi)
  puts formatted_pi  # 3.14
```

* パーセンテージ表記を出力する  
( %記号自体を出力するためには%%と2つ続けて使用 )
```ruby
  rate = 0.756
  formatted_rate = format("%.2f%%", rate * 100)
  puts formatted_rate
```

* 動的なフォーマット指定子を出力する
```ruby
  formatted_n = format("%.#{m}f", n)  # 変数が入れられる
  puts formatted_n
```

* 別の書き方
```ruby
  a = i * j
  formatted_string = format("%#2d", a)　# 数字を2桁に
　# 上下は同じ
  formatted_string = "%#2d" % (i * j)
```


## abs
### 絶対値を取得する
```ruby
  num = 5.abs    # 5
  
  num = (-5).abs    # 5
```

## abs
### 絶対値を取得する
```ruby
  num = 5.abs    # 5
  
  num = (-5).abs    # 5
```

## abs
### 絶対値を取得する
```ruby
  num = 5.abs    # 5
  
  num = (-5).abs    # 5
```
