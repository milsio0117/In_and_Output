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
<br><br><br>

## テーブルを使わずカラムに保存する
**選択肢が少数で頻繁に変わることがない場合**
1. enum  
postage_payerカラムにsellerまたはbuyerという2つの状態を設定  
→ データベースには0と1として保存され、コード上ではsellerやbuyerとして扱うことができる

```ruby
      class Product < ApplicationRecord
        enum postage_payer: { seller: 0, buyer: 1 }
      end
```

例えば上のような販売者、購入者の設定なら商品情報モデル`model/product.rb`などに記述  
<br>
2. ActiveHashを使う（Gem）
<br><br>

**将来カテゴリの数が増える可能性があり、管理者が自由にカテゴリを追加・削除できるようにしたい場合**  
<br>
categoryテーブルにnameというカラムを作り、nameに"インテリア・住まい"、"本・ゲーム"などの値を保存  
→ 商品テーブルにcategory_idカラムを作成する
```ruby
class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.integer :parent_id, null: true, index: true

      t.timestamps
    end
  end
end
```

カテゴリーが階層構造を持つ場合（大カテゴリー、小カテゴリーなど）、parent_id のようなカラムを使って親子関係を表現することもある  
→ この場合、parent_id は自身のテーブルの id を参照する
<br><br><br>

## 共通のバリデーションをまとめる
```ruby
      with_options presence: true do
        validates :user, length: { minimum: 6 }
        validates :item
        validates :price, format: { with: /\A[0-9]+\z/ }
        validates :email
      end
```
presence:true をつけたうえで個別にバリデーションを追加

```ruby
      with_options presence: true do
        validates :user
        validates :item
        with_options uniqueness: true do
          validates :price
          validates :email
        end
      end
```
presence:trueをつけたうえでuniqueness:trueもまとめる
<br><br><br>

## format

|正規表現|	意味|
|:---|:---|
|/\A[ぁ-んァ-ヶ一-龥々ー]+\z/	|1字以上の全角ひらがな、全角カタカナ、漢字|
|/\A[ァ-ヶー]+\z/	|1字以上の全角カタカナ|
|/\A[a-z0-9]+\z/i	|1字以上の半角英数（大文字小文字問わない）|
|/\A\d{3}[-]\d{4}\z/ |郵便番号（「-」を含む且つ7桁）|
|greater_than_or_equal_to: 〇〇|〇〇と同じかそれ以上の数値|
|less_than_or_equal_to: △△|	△△と同じかそれ以下の数値|

```ruby
  class Donation < ApplicationRecord
      validates :price, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 1000000, message: "is invalid"}
  end
```
numericality →　数値かどうかを検証

<br><br><br>
