### 変数
```css
    $milsio-color: #26546a;
    
    h1{
      color:$milsio-color;
      }
```

### @mixinで定義、@includeで呼び出し  
よく利用するCSSのスタイルを定義して、他の場所でも使いまわせるようにする
```css
    @mixin milsio-set{
      width :300px;
      padding :40px;
      color :#ffffff
    }
    
    .content{
      @include milsio-set;
    }
```

### @mixinで引数を使う  
` $引数名: 初期値 `
```css
    @mixin milsio-set($color){
      font-size :14px;
      color: $color;
    
    .content{
      @include milsio-set(#ffffff);
```

```css
    @mixin hoge($bgColor: #000, $fontColor: #fff) {
      font-size :14px;
      color: $color;
    }

    .content {
      @include hoge(green, black);
    }
```

### 関数
```css
    $blue: #0ac4ff;
    
    .blue1 {
        background-color: darken($blue, 10%);
      }
    
    .blue2 {
        background-color: lighten($blue, 20%);
      }
```

### @function  
自作関数を作れる
