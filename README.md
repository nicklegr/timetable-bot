

timetable-bot
=============

ATNDのイベントのタイムテーブルを抽出し、リアルタイムでつぶやくbotです。

イベントのハッシュタグを追っている人から見ると、タイムラインの司会のような役割を果たします。  
Togetterでまとめを作る際に、セッションの区切りとしても使えます。

## 動作環境
- Ruby (>= 1.9.0)
- Bundler (>= 1.2.0)
- MongoDB

## セットアップ

config.yamlを作成し、Twitterアカウントの認証情報を入力します。

```config.yaml
consumer_key: ...
consumer_secret: ...
oauth_token: ...
oauth_token_secret: ...
```

crawler.rbがタイムテーブルを取得するスクリプトで、bot.rbがツイートを行うスクリプトです。  
これらをcronで定期的に実行します。  
2つのスクリプトは同時に実行されないようにしてください。

```cron
*/5 * * * * (cd /path/to/timetable-bot; /path/to/bundle exec ruby bot.rb)
2,17,32,47 * * * * (cd /path/to/timetable-bot; /path/to/bundle exec ruby crawler.rb)
```

MongoDBのユーザー認証は使用していません。  
またデータベースも自動的に作成されるので、デフォルトのポートで起動していれば特に設定は不要です。
