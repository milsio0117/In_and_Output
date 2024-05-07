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

