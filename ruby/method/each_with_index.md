## each_with_index
* 要素の繰り返し処理と同時に、その要素が何番目に処理されたのかも表す
```ruby
  fruits = ["メロン", "バナナ", "アップル"]
  
  fruits.each_with_index do |item, i|
   puts "#{i}番目のフルーツは、#{item}です。"
  end
```
