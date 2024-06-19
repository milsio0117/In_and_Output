## クレジットカード利用機能をつける
1. 必要箇所のルーティングを行う
```ruby
      Rails.application.routes.draw do
        root to: 'orders#index'
        resources :orders, only:[:create,:index]
      end
```
<br><br>
2. controllerの記述
```ruby
      class OrdersController < ApplicationController
      
        def index
          @order = Order.new
        end
      
        def create
          @order = Order.new(order_params)
          if @order.valid?
            @order.save
            return redirect_to root_path
          else
            render 'index', status: :unprocessable_entity
          end
        end
      
        private
      
        def order_params
          params.require(:order).permit(:price)
        end
      
      end
```
<br><br>

3. PAY.JPのAPIを使用するためのjsを読み込む  
application.html.erb
```html
<script type="text/javascript" src="https://js.pay.jp/v2/pay.js"></script>
```
<br><br>

4. トークン化するファイルを作成
* app/javascript/card.js
* important.rb: ` pin "card", to: "card.js" `とapprication.js: `import "card" `　を追記
* Payjpインスタンスを作成  
　→ 公開鍵によりPAY.JPに登録されているかを確認  
　→ PAY.JPが提供する様々なサービスを操作するAPIを持つインスタンスとなる
```js
   const payjp = Payjp('pk_test_******************') //公開鍵
```
<br><br>

5. htmlを作成。任意のフォームを作成し、それぞれのidをjsで設定するとPAY.JPが用意した入力欄が現れる
* 例）カード番号: ` number-form `、有効期限: ` expiry-form ` 、cvc番号: ` cvc-form `
<br><br>

6. 5のjsでの設定
```js
  const elements = payjp.elements(); 
  const numberElement = elements.create('cardNumber');  //原型: payjp.elements().create('cardExpiry')
  const expiryElement = elements.create('cardExpiry');　//elements.create()で入力フォームを作成している。'type'は規定
  const cvcElement = elements.create('cardCvc');

  numberElement.mount('#number-form'); //Elementにidをつけている
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
```
<br><br>

7. トークンを取得
```js
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {  //response: PAY.JP側からのレスポンスとステータスコードが含まれている
      if (response.error) {
      } else {
        const token = response.id;　//response.id :トークンの値を取得
        console.log(token)
      }
    });
    e.preventDefault();
  });
```
<br><br>

8. トークンをフォームに含める
```js
      const renderDom = document.getElementById("charge-form");
      const tokenObj = `<input value=${token} name='token' type="hidden">`;
      renderDom.insertAdjacentHTML("beforeend", tokenObj);
```
<br><br>

9. クレジットカードの情報を削除しておき、サーバーに情報を送信
```js
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      document.getElementById("charge-form").submit();
```
<br><br>

10. ストロングパラメーターにtokenも含める
```ruby
      def order_params
        params.require(:order).permit(:price).merge(token: params[:token])
      end
```
<br><br>

11. orderモデルでtokenを使用できるようにする (Orderモデル(Orderクラス)にtokenという属性が存在しないためエラーになる)
```ruby
      class Order < ApplicationRecord
        attr_accessor :token
        validates :price, presence: true
      end
```
<br>

12. gem 'payjp' を入れる
<br><br>

13. 決済処理を記述
```ruby
 def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
      render 'index', status: :unprocessable_entity
    end
  end

  private
  def pay_item
      Payjp.api_key = "sk_test_***********"  # 秘密鍵。これと下のクラスｰメソッドはgemが提供
      Payjp::Charge.create(
        amount: order_params[:price],  # 商品の値段
        card: order_params[:token],    # カードトークン
        currency: 'jpy'                 # 通貨の種類（日本円）
      )
   end
```
<br><br>

14. バリデーションを設定
```ruby
      class Order < ApplicationRecord
        attr_accessor :token
        validates :price, presence: true
        validates :token, presence: true
      end
```
attr_accessor :tokenと記載したことにより、tokenについてのバリデーションを記述することができる
<br><br>

15. 環境変数の設定
* vim ~/.profile を実行
* i:インサートモードにし以下を記述
```
export PAYJP_SECRET_KEY='sk_test_*************'
export PAYJP_PUBLIC_KEY='pk_test_*************'
```
* escを押してから:wqと入力し終了
* source ~/.profile　を実行し設定を反映
* rails cで ENV["PAYJP_SECRET_KEY"]、ENV["PAYJP_PUBLIC_KEY"]を入力し鍵が出力されるか確認
<br><br>

16. コントローラーに環境変数を使用
```ruby
      def pay_item
         Payjp.api_key = ENV["PAYJP_SECRET_KEY"] //ここ
         Payjp::Charge.create(
           amount: order_params[:price],
           card: order_params[:token],
           currency:'jpy'
         )
      end
```
<br><br>

17. jsで環境変数（公開鍵だが一応）を読み込む
* gem 'gon' を入れる
* 表示したいビューファイルに<%= include_gon %>記述
* コントローラーで公開鍵を代入
```ruby
      class OrdersController < ApplicationController
        def index
          gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
          @order = Order.new
        end
```
* jsで公開鍵を読み込む
```js
      const publicKey = gon.public_key
      const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
```
<br><br>

18. エラーがありrenderされた時用の記述を追記
```ruby
      def create
        @order = Order.new(order_params)
        if @order.valid?
          pay_item
          @order.save
          return redirect_to root_path
        else
          gon.public_key = ENV["PAYJP_PUBLIC_KEY"] //indexアクションを通らないので設定し直しておく
          render 'index', status: :unprocessable_entity
        end
      end
```

```js
      window.addEventListener("turbo:load", pay);
      window.addEventListener("turbo:render", pay); //renderされたときにも読み込まれる
```
<br><br>

19. 必要ならRenderにも環境変数を設定
* dashboard → app → Environment
* 公開鍵(PAYJP_PUBLIC_KEY)、秘密鍵(PAYJP_SECRET_KEY)を入力
<br><br>

### 全体
js
```js
const pay = () => {
    const publicKey = gon.public_key
    const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵
    const elements = payjp.elements();
    const numberElement = elements.create('cardNumber');
    const expiryElement = elements.create('cardExpiry');
    const cvcElement = elements.create('cardCvc');
  
    numberElement.mount('#number-form');
    expiryElement.mount('#expiry-form');
    cvcElement.mount('#cvc-form');
  
    const form = document.getElementById('charge-form')
    form.addEventListener("submit", (e) => {
      payjp.createToken(numberElement).then(function (response) {
        if (response.error) {
        } else {
          const token = response.id;
          const renderDom = document.getElementById("charge-form");
          const tokenObj = `<input value=${token} name='token' type="hidden">`;
          renderDom.insertAdjacentHTML("beforeend", tokenObj);
        }
        numberElement.clear();
        expiryElement.clear();
        cvcElement.clear();
        document.getElementById("charge-form").submit();
      });
      e.preventDefault();
    });
  };
  
window.addEventListener("turbo:load", pay);
window.addEventListener("turbo:render", pay);
```

controller
```ruby
class OrdersController < ApplicationController
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order).permit(:price).merge(token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: order_params[:price],
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
```
