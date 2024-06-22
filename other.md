## 不要なファイルを削除する
ターミナル 該当ディレクトリで
```
find ./ -type f -name '*:Zone.Identifier' -exec rm {} \;
```
