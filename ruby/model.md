## 親モデルと関連している子モデルに対する挙動を指定する
dependent: をつけるとTweet（親）にいるcomments（子）も一緒に動く。親につける
```
      class Tweet < ApplicationRecord
        has_many :comments, dependent: :destroy
      end
```
→親を削除したら子も削除される
<br><br><br>

## 各レコードとファイルを1対1の関係で紐づける
`has_one_attached`を記述したモデルの各レコードは1つのファイルを添付できる
```
        class モデル < ApplicationRecord
          has_one_attached :ファイル名
        end
```
この記述により、モデル.ファイル名 で添付されたファイルにアクセスできるようになる  
例
```
        class Message < ApplicationRecord
          has_one_attached :image
        end
```
Messageテーブルにimageファイルが１つ添付できる状態  
このときmessagesテーブルにカラムを追加する必要はない
