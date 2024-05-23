## 部分テンプレートを作る
`<%= render partial: "部分テンプレートファイル名" %>`

* テンプレファイルは _ をファイル名の先頭につける
* localsというオプションを付けると部分テンプレート内でその変数を使えるようになる
```ruby
         <%= render partial: "sample", locals: { post: "hello!" } %>
```
post ="hello!" という変数が_sample.html.erbテンプレート内で使える状態
<br><br><br>

## 現在ログインしているユーザーをeachメソッドの処理から取り除く
`モデル名.where.not("条件")`
```ruby
         <% User.where.not(id: current_user.id).each do |user| %>
```

ログインしているユーザー以外のすべてのレコードを取得（all -current_user）
<br><br><br>


## form_with
データベースに保存しない場合
```ruby
         <%= form_with url: "パス" do |form| %>
            <!--内容 -->
         <% end %>
```
<br>

データベースに保存する場合
```ruby
         <%= form_with model: モデルクラスのインスタンス do |form| %>  #モデルクラスのインスタンス:コントローラーで定義
             <!--内容 -->
         <% end %>
```
<br>

例：投稿フォームの作成
```ruby
         <%= form_with model: @user do |form| %>
           <%= form.text_field :name %>  #form.htmlタグ名  :カラム名
           <%= form.submit %>
         <% end %>
```
<br><br><br>

## サインインの有無で条件分岐
`if user_signed_in?`  
例

```ruby
         <% if user_signed_in? %>
           <div class="user_nav grid-6">
              <%= link_to "ログアウト", destroy_user_session_path, data: { turbo_method: :delete } %>
              <%= link_to "投稿する", new_tweet_path, class: "post" %>
           </div>
         <% else %>
           <div class="grid-6">
              <%= link_to "ログイン", new_user_session_path, class: "post" %>
              <%= link_to "新規登録", new_user_registration_path, class: "post" %>
           </div>
         <% end %>
```
<br><br><br>

## 画像の表示方法
`<%= image_tag '画像へのパス' %>`  
例
```ruby
         <%= image_tag 'arrow_top.png' %>
```
<br><br><br>

## 画像のリンク
`<%= link_to image_tag('test.jpg'), 'パス' %>`  
スタイルもつけられる
```ruby
      <%= link_to image_tag('test.jpg', class: "contents"), 'パス' %>
```
<br><br><br>

## collection,member
  これは同じ処理
```ruby
    <% @hoges.each do |hoge|%>
      <%= render partial: 'hoge', locals: {hoge: hoge} %>
    <% end %>
```

```ruby
    <%= render partial: 'hoge', collection: @hoges %>
```
<br><br><br>

## エラー文を表示する
`pluralize`: エラーの数が1以外（0や2以上）なら"error"に適切な複数形の"エラー"という単語をつけるメソッド  
@model ←なんらかのmodelインスタンス  
```ruby
         <% if @model.errors.any? %>
           <div id="error_explanation">
             <h2><%= pluralize(@model.errors.count, "error") %> prohibited this model from being saved:</h2>
         
             <ul>
             <% @model.errors.full_messages.each do |message| %>
               <li><%= message %></li>
             <% end %>
             </ul>
           </div>
         <% end %>
```
<br><br><br>

## インスタンスが空かどうか判断
<% if @items.empty? %>  
→ 空の時の表示
