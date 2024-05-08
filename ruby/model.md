## 親モデルと関連している子モデルに対する挙動を指定する
dependent: をつけるとTweet（親）にいるcomments（子）も一緒に動く。親につける
```ruby
      class Tweet < ApplicationRecord
        has_many :comments, dependent: :destroy
      end
```
→親を削除したら子も削除される
<br><br><br>

## 各レコードとファイルを1対1の関係で紐づける
`has_one_attached`を記述したモデルの各レコードは1つのファイルを添付できる
```ruby
        class モデル < ApplicationRecord
          has_one_attached :ファイル名
        end
```
この記述により、モデル.ファイル名 で添付されたファイルにアクセスできるようになる  
例
```ruby
        class Message < ApplicationRecord
          has_one_attached :image
        end
```
Messageテーブルにimageファイルが１つ添付できる状態  
このときmessagesテーブルにカラムを追加する必要はない
<br><br><br>

## レコードの検索
`モデル.where('検索対象となるカラムを含む条件式')`
* テーブルとのやりとりに関するメソッドはモデルに置く！  
* コントローラーはあくまでモデルの機能を利用し処理を呼ぶだけで、複雑な処理は組まない  
* モデルが使用できる、ActiveRecordメソッド.テーブル内の「条件に一致したレコードのインスタンス」を配列の形で取得できる  

```ruby
          def self.search(search)
            if search != ""
              Tweet.where('text LIKE(?)', "%#{search}%")
            else
              Tweet.all
            end
          end
```

モデル名.where.not("条件") は条件に一致したレコード以外の値を配列として取得できる
```ruby
          User.where.not(id: current_user.id).each do |user|
```
 ↑ 現在ログイン中のユーザー以外のすべてを取得(all -自分)

> [!TIP]
> LIKE句:　% :任意の文字列、　_ :任意の文字(1文字)
```ruby
        where('title LIKE(?)', "a%")	aから始まるタイトル
        where('title LIKE(?)', "%b")	bで終わるタイトル
        where('title LIKE(?)', "%c%")	cが含まれるタイトル
        where('title LIKE(?)', "d_")	dで始まる2文字のタイトル
        where('title LIKE(?)', "_e")	eで終わる2文字のタイトル
```
