### 変数
```css
    $milsio-color: #26546a;
    
    h1{
      color:$milsio-color;
      }
```

### @mixinで定義、@includeで呼び出し
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
```css
    @mixin milsio-set($color){
      font-size :14px;
      color: $color;
    
    .content{
      @include milsio-set(#ffffff);
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
