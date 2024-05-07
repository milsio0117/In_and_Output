# gem deviseの導入手順
gemfileにgem'devise'を入れる
→bundle install
→rails s    で再起動
→rails g devise:install
→rails g devise モデル名
→rails db:migrate   ←migrate/xxxx_devise_create_users.rbでテーブルの設計確認後
→rails sで再起動
→rails g devise:views   ←必要なら編集
→rails g migration AddNicknameToUsers nickname:string   カラム追加（詳細↓）
→rails db:migrate
→rails sで再起動


#deviseの削除手順
逆を行う
rails db:migrate:statusで状態を確認
rails db:rollback（downの場合。upならrails db:rollbackする）
→rails d dvise:views
→rails d devise user
→rails d devise:install

controllerは普通に生成しないといけないのでrails g controller usersをする。(その前にresources :users をrouteに設定する→そしたらpathが出る)
→ views/users/ も自動的に作られる
