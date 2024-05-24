## 導入
1. gem 'gon'
2. bundle install
3. 使用したいviewのページすべてに`<%= include_gon %>`を記述
```ruby
      def show
        @user = User.find(1)
        gon.username = @user.name #これをJSに渡す
      end
```
4. jsファイルで使える
```js
      let name = gon.username
```
[Gon公式](https://github.com/gazay/gon)
