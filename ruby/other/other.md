## カラムの操作
### カラム名の変更
`rails g migration rename_[変更前のカラム名]_ column_to_ [モデル名(複数形)]` でファイルを生成  
```ruby
      class RenameUserrIdColumnToUsers < ActiveRecord::Migration[5.2]
        def change
          rename_column :users, :userr_ id, :user_ id
        end
      end
```
`rename_column :テーブル名, :変更前のカラム名, :変更後のカラム名` で記述
<br><br>
### 
