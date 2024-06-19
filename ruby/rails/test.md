## テスト手順
1. Gemfileに記述
```ruby
    group :development, :test do
    
      gem 'rspec-rails'
      gem 'factory_bot_rails'
      gem 'faker'
    end

    gem 'pri-rails'
```

2. bundle install
3. rails g rspec:install
4. .rspecに`--format documentation`を追加記述（ログが文章で表示されて見やすくなる）
5. spec/rails_helper.rbに追記（エラーメッセージを英語にする）
```ruby
      I18n.locale = "en"　　←これ
      RSpec.configure do |config|
```
6. ファイル、フォルダを手動で作る
```
spec/factories/messages.rb
              /rooms.rb
              /users.rb
```
7. `rails g rspec:model user`などでモデルのテストファイルを作る
8. modelのvalidatesを確認してテスト項目を洗い出す
9. `factories/users.rb`などのファイルに必要なFaker項目を記述
```ruby
            FactoryBot.define do
                factory :user do
                  name                  {Faker::Name.last_name}
                  email                 {Faker::Internet.email}
                  password              {Faker::Internet.password(min_length: 6)}
                  password_confirmation {password}
                end
              end
```
10. `spec/models/user_spec.rb`などのファイルで事前にインスタンス変数を設定しておく
```ruby
            RSpec.describe User, type: :model do
              before do                                ←ここから下
                @user = FactoryBot.build(:user)
              end
```

`(例)bundle exec rspec spec/models/user_spec.rb`でテストコード実行

<br>

### expect().to matcher()
matcherにはinclude,eqなどの想定挙動が入る  
* include 例：expect(['りんご', 'バナナ', 'ぶどう', 'メロン']).to include('メロン')  
* eq 例     ：expect(1 + 1).to eq(2)  


### visit
`visit xxx_path visit`のように記述すると、xxxのページ（指定したビューファイル）に遷移できる

### fill_in
`fill_in 'フォームの名前', with: '入力する文字列'`のように記述することで、フォームへの入力を行うことができる
### have_content()
`expect(page).to have_content('X')`と記述すると、visitで訪れたpageの中に、Xという文字列があるかどうかを判断する

### have_no_content()
`have_content`の逆で、文字列が存在しないことを確かめる

### hover
`find('ブラウザ上の要素').hover`とすることで、特定の要素にカーソルをあわせたときの動作を再現できる

### find().click
`find('クリックしたい要素').click`と記述することで、実際にクリックができる

### click_on
`click_on ('ログイン')`とすると、「ログイン」というテキストリンクまたはvalue属性の値を持ったbutton要素をクリックする動作を再現できる。()はなくても可


### change
`expect{ 何かしらの動作 }.to change { モデル名.count }.by(1)`と記述することによって、モデルのレコードの数がいくつ変動するのかを確認できる  
changeマッチャでモデルのカウントをする場合のみ、expect()ではなくexpect{}となる  
  ↓ 送信した値がDBに保存されていることを確認する
```
expect {
 find('input[name="commit"]').click
}.to change { Message.count }.by(1)
```
### current_path
文字通り、現在いるページのパスを示す。`expect(current_path).to eq root_path`と記述すれば、今いるページがroot_pathであることを確認できる



```

```
user.birthday.year=""...
```
