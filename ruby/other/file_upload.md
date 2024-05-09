 ## ファイルアップロード機能をつける
 
 `Active Storage` : 画像などのファイルのアップロードを簡単にするメソッドが使用できたり画像を保存するテーブルを簡単に作成できる  
 `ImageMagick` : 画像の作成やサイズ変更、保存形式の変更などの処理を加えることができるツール（Gem ではなくソフトウェアのためHomebrewからインストール）  
 `MiniMagick` : ImageMagick の機能をRubyで扱えるようにしてくれるGem  
 `ImageProcessing` : MiniMagick では提供できない画像サイズを調整する機能を提供するGem  

```
        brew install imagemagick

        → gem 'mini_magick'                  #2行をgemfileに記入
          gem 'image_processing', '~> 1.2'

        → bundle install

        → 画像処理にMiniMagickを使用するため設定ファイルに記述を行う（config/apprication.rb）
          module ChatApp
          class Application < Rails::Application
            # Initialize configuration defaults for originally generated Rails version.
            config.load_defaults 7.0
            config.i18n.default_locale = :ja
            config.time_zone = 'Tokyo'
            config.active_storage.variant_processor = :mini_magick
        → rails s 再起動
        → rails active_storage:install
        → rails db:migrate
        → DB テーブルにactive_strage_attachments,active_storage_blobsが追加される
```
