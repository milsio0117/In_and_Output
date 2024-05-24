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

## 環境変数の設定
1. vim ~/.profile
2. e(edit) → i(insert)
3. インサートモードで一番下に記述（十字キーで移動）
```
      export PAYJP_SECRET_KEY='sk_test_*************'
      export PAYJP_PUBLIC_KEY='pk_test_*************'
```

4. 編集が終わったらescキーを押してから:wqと入力して保存して終了
5. source ~/.profileを実行して編集を反映
<br>
→ コントローラーに記述していた秘密鍵をENV["PAYJP_SECRET_KEY"]に置き換える
