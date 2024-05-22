 ## ファイルアップロード機能をつける
 
 `Active Storage` : 画像などのファイルのアップロードを簡単にするメソッドが使用できたり画像を保存するテーブルを簡単に作成できる  
 <br>
 `ImageMagick` : 画像の作成やサイズ変更、保存形式の変更などの処理を加えることができるツール（Gem ではなくソフトウェアのためHomebrewからインストール）  
 <br>
 `MiniMagick` : ImageMagick の機能をRubyで扱えるようにしてくれるGem  
 <br>
 `ImageProcessing` : MiniMagick では提供できない画像サイズを調整する機能を提供するGem  
 
<br>
手順：  

1. brew install imagemagick

2. 以下2行をgemfileに記入  
   gem 'mini_magick'                  
   gem 'image_processing', '~> 1.2'

3. bundle install

4. 画像処理にMiniMagickを使用するため設定ファイルに記述を行う（config/apprication.rb）

```ruby
          module ChatApp
          class Application < Rails::Application
            # Initialize configuration defaults for originally generated Rails version.
            config.load_defaults 7.0
            config.active_storage.variant_processor = :mini_magick 　ここ
```


5. rails s 再起動

6. rails active_storage:install

7. rails db:migrate

8. DB テーブルにactive_strage_attachments,active_storage_blobsが追加される

9. ファイル添付したいモデルにhas_one_attachedを記述
```ruby
class Message < ApplicationRecord
      has_one_attached :image(#ファイル名)
     end
```
