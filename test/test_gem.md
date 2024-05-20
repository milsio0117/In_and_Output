# FactoryBot
```ruby
      FactoryBot.define do
        factory :user do
            nick_name { Faker::Name.name }
        end
      end
```

# Faker
## パスワードの設定
```ruby
      password { Faker::Internet.password(min_length: 8) }
```
1. min_length: 最低文字数
2. max_length: 最大文字数
3. mix_case: false,　　　大文字を混ぜる・混ぜない
4. special_characters: 　特殊記号入れる・入れない
<br><br>

### パスワードに英数文字を含める
最低アルファベット１、数字１を含める
```ruby
      password { Faker::Lorem.characters(min_alpha: 1, min_numric: 1) }
```

### パスワードの文字数を指定
ランダムな10文字を生成、最低4文字以上はアルファベットを含める
```ruby
      Faker::Lorem.characters(number: 10, min_alpha: 4) #=> "ang9cbhoa8"
```

<br><br><br>
# Gimei
名前、ふりがな、住所を漢字、カナ、ひらがな、ローマ字で返す
```ruby
      gimei = Gimei.name
      gimei.kanji          #=> "斎藤 陽菜"
      gimei.hiragana       #=> "さいとう はるな"
      gimei.katakana       #=> "サイトウ ハルナ"
      gimei.romaji         #=> "Haruna Saitou"
      gimei.gender         #=> :female
      gimei.male?          #=> false
      gimei.female?        #=> true
      gimei.last.kanji     #=> "斎藤"
      gimei.last.hiragana  #=> "さいとう"
      gimei.last.katakana  #=> "サイトウ"
      gimei.last.romaji    #=> "Saitou"
      gimei.first.kanji    #=> "陽菜"
      gimei.first.hiragana #=> "はるな"
      gimei.first.katakana #=> "ハルナ"
      gimei.first.romaji   #=> "Haruna"
```

```ruby
      address = Gimei.address
      address.kanji                 # => 岡山県大島郡大和村稲木町
      address.to_s                  # => 岡山県大島郡大和村稲木町
      address.hiragana              # => おかやまけんおおしまぐんやまとそんいなぎちょう
      address.katakana              # => オカヤマケンオオシマグンヤマトソンイナギチョウ
      address.romaji                # => Okayamaken Ooshimagunyamatoson Inagicho
      
      Gimei.prefecture.kanji        # => 青森県
      Gimei.prefecture.to_s         # => 滋賀県
      Gimei.prefecture.hiragana     # => やまがたけん
      Gimei.prefecture.katakana     # => チバケン
      Gimei.prefecture.romaji       # => Wakayamaken
      
      Gimei.city.kanji              # => 利根郡昭和村
      Gimei.city.hiragana           # => うべし
      Gimei.city.katakana           # => カモグンヤオツチョウ
      Gimei.city.romaji             # => Itanogunaizumichou
      
      Gimei.town.kanji              # => 竹野
      Gimei.town.to_s               # => 富久山町南小泉
      Gimei.town.hiragana           # => じょうしんでん
      Gimei.town.katakana           # => イケナイ
      Gimei.town.romaji             # => Heisei
```

### 漢字かひらがなのどちらかを返す
```ruby
      last_name { [japanese_user.last.kanji, japanese_user.last.hiragana].sample }
```
