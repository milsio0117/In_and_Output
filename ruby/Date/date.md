## 日付を扱う
```ruby
require "date"

date1 = Date.new(2024.6.20)  #出力 2024-06-20
puts date1.Sunday?  # false

date2 = Date.today
puts date2  # 今日の日付

date3 = Date.today.wday
puts date3 # 今日の曜日
```
