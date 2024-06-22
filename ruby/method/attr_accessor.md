## attr_accessor
* インスタンス変数にクラスの外部からアクセスするにはインスタンスメソッドで経由する必要がある
* クラス内でしか参照できないインスタンス変数をクラスの外から直接操作できるようにする
1. メソッドを経由する場合
```ruby
class Article
  def initialize(author, title)
    @author = author
    @title = title
  end

  def display
    puts "著者: #{@author}"
    puts "タイトル: #{@title}"
  end
end

article = Article.new("しお", "おいしいシードについて")
article.display
```

2. accessorを使う場合
```ruby
  class Article
      attr_accessor :author, :title #ここ
  
    def initialize(author, title) # 初期化
      @author = author
      @title = title
    end
  end
    
  article =Article.new("しお","おいしいシードについて")
  
  puts "著者: #{article.author}"　#著者: しお
  puts "タイトル: #{article.title}"  #タイトル: おいしいシードについて
```

3. ゲッター、セッターを使う場合
```ruby
  class Article
    def initialize(author, title)
      @author = author
      @title = title
    end
  
    # ゲッター（ = attr_reader）
    def author
      @author
    end
  
    def title
      @title
    end
  
    # セッター（ = attr_writer）
    def author=(author)
      @author = author
    end
  
    def title=(title)
      @title = title
    end
  end
  
  article = Article.new("しお", "おいしいシードについて")
  
  puts "著者: #{article.author}" # 著者: しお
  puts "タイトル: #{article.title}" # タイトル: おいしいシードについて
```

attr_reader(ゲッター)は読み専門で更新されたくないとき、  
attr_writer(セッター)は更新だけしたいとき、  
セッターメソッドはユーザー入力などで入力のエラーを正規化するときに定義したりする

```ruby
    def name=(name) # セッター
        @name = name.tr("０-９ａ-ｚＡ-Ｚ", "0-9a-zA-Z") # 全角英数字を半角化
          .gsub(/\A[[:space:]]+|[[:space:]]+\z/, "")  # 先頭・末尾のスペース類削除
    end

    movie = Movie.new("　　華氏１１９　")
    p movie.name # => "華氏119"
```
