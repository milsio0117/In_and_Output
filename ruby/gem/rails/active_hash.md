# データベースを使わないモデルを作成する
rails/
## 導入
`gem 'active_hash'` → bundle install

### 例：ジャンルgenreに紐づいた記事article
記事を書くときに複数のジャンルカテゴリーから選択して紐づける状態にしたい  
1. rails g model article<br><br>
2. modelディレクトリにgenre.rbファイルを手動生成<br><br>
3. ActiveHash::Baseを継承したclassを作る → ActiveRecordと同じようなメソッドを使用できるようになる  
models/genre.rb
```ruby
      class Genre < ActiveHash::Base
       self.data = [
         { id: 1, name: '---' },
         { id: 2, name: '経済' },
         { id: 3, name: '政治' },
         { id: 4, name: '地域' }
       ]
       end
```
<br><br>
4. マイグレーションファイルを編集
Articleテーブルの中でGenre疑似モデルのidを外部キーとして管理することで、その記事に紐付いたジャンルが取得できる  
db/migrate/~~~articles.rb
```ruby
      class CreateArticles < ActiveRecord::Migration[7.0]
       def change
         create_table :articles do |t|
           t.string     :title        , null: false
           t.text       :text         , null: false
           t.integer    :genre_id     , null: false      ←
           t.timestamps
         end
       end
      end
```
<br><br>
5. `rails db:migrate`<br><br>
6. articleのアソシエーションを設定
models/article.rb
```ruby
      class Article < ApplicationRecord
        extend ActiveHash::Associations::ActiveRecordExtensions
        belongs_to :genre
      end
```

7. genreのアソシエーションを設定
```ruby
      class Genre < ActiveHash::Base
       self.data = [
         { id: 1, name: '---' },
         { id: 2, name: '経済' },
         { id: 3, name: '政治' },
         { id: 4, name: '地域' }
       ]
      
        include ActiveHash::Associations    ←
        has_many :articles
      
       end
```
呼び出しは（例）@article.genre.name  

[active_hash](https://github.com/active-hash/active_hash)その他の設定・詳細
