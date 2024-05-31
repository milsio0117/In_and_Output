# エラーメッセージを日本語化する
1. configで日本語設定にする  
config/application.rb
```ruby
      module Pictweet
        class Application < Rails::Application
          # Initialize configuration defaults for originally generated Rails version.
          config.load_defaults 7.0

          config.i18n.default_locale = :ja  # 日本語の言語設定
            # 省略
          end
      end
```
<br>

2. ` gem 'rails-i18n' `を入れる
<br>

3. localeファイルにymlファイルを追加 
config/locales/devise.ja.yml　←ファイル作成  
[devise.ja.yml](https://github.com/tigrish/devise-i18n/blob/master/rails/locales/ja.yml)を丸ごと作成したファイルにコピー
<br>

4. 足りないところは手動で作成
例）
config/locales/ja.yml　←ファイル作成
```yml
ja:
  activerecord:
    attributes:
      user:
        nickname: ニックネーム
      tweet:
        text: テキスト
        image: 画像
```
<br>

5. エラーコードも日本語になるのでincludeを書き換える
