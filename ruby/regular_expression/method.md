## pre_match
### マッチした前の部分を取り出す
```ruby
str = "Rubyの勉強 および Raisの勉強をはじめましょう"
reg = /および/.match(str)
p reg.pre_match  # "Rubyの勉強 "
```

## post_match
### マッチした後ろの部分を取り出す
```ruby
str = "Rubyの勉強 および Raisの勉強をはじめましょう"
reg = /および/.match(str)
p reg.post_match  # " Raisの勉強をはじめましょう"
```

## =~
### マッチした部分のインデックスを返す
```ruby
p /aaa/ =~ "aaabbb"  # 0
p /aaa/ =~ "rubyaaa"  # 4
マッチしない場合はnilを返す
p /aaa/ =~ "ruby"  # nil
```

## !~
### マッチしなかったらtrueを返す
```ruby
p /aaa/ !~ "aaabbb"  # false
p /aaa/ !~ "rubyaaa"  # false
マッチしない場合はtrueを返す
p /aaa/ !~ "ruby"  # true
```
