# [Musclenutri](https://musclenutri.net/)
![musclenutri net_ (3)](https://user-images.githubusercontent.com/75205515/125150628-3a957600-e17c-11eb-8a75-6022ef4f4bd9.png)

## アプリの概要
このアプリはポートフォリオとして開発した個人アプリです。
競技スポーツのパフォーマンス向上や健康維持のためにプロテインやサプリを利用する人のために情報を共有できるアプリです。
全て独学で開発しました。

## URL
https://musclenutri.net

## このアプリを開発した背景
私は小学校１年生から大学3回生の6月までの15年間、部活で野球をしていました。野球において欠かせないのが体作りなのですが、一時期筋トレをしているのにも関わらず筋肉量の計測をしたときに筋肉量が増えていませんでした。なぜかを見つめ直したところ原因は栄養の補給が疎かになっていた事と、プロテインを筋トレ後に飲んでいない事がわかりました。
原因が分かってからは栄養の補給を意識しプロテインを筋トレ後必ず30分以内のゴールデンタイムに飲むようにしたらその4、5ヶ月後の筋肉量の測定で筋肉量が増えており、体脂肪率も下がったのでプロテインやサプリの重要性を知ることが出来ました。だからこそプロテインやサプリにはこだわることが良いのではないかと思い、プロテインやサプリの情報を共有し合うことができるサービスを作ろうと考えました。

## こだわった点
### 1.ユーザーの競技種目を可視化させたこと
  * ユーザーの競技種目をグラフ化して可視化させることによってどういう競技者がこのアプリを利用しているかが分かりそこから競技種目別のユーザーがどういったプロテインやサプリを利用してパフォーマンス向上や体のコンディションを調整しているかを分かるようにしました。

### 2.CircleCIを導入してCI/CDパイプラインの構築
  * CircleCIを導入しただけで終わりではなく、CircleCIをしっかりと活用するために静的解析ツールRubocopの導入とRspecを利用して自動でテストを行えるように実装しました。この結果、もし問題が起きた時でも即座に発覚し、バクに対処できるのでアプリの質を上げることが出来たのではないかと実感しています。
  * CircleCIが実行されるとCapistranoが実行されて自動デプロイされます。
 自動デプロイを行うことでデプロイ時にコマンドを打ち忘れて、ミスするということをなくすことが出来ます。このような人の作業が自動化されるところにプログラミングの醍醐味を感じることが出来ました。
 ### 3.商品検索機能において外部APIを使用
  * このアプリを利用していただくユーザーにサービス内の情報のみだと気になった商品があったとしてもページを行き来してリサーチしないといけないので利用していただくユーザーが気になった商品をすぐにリサーチ出来るようにという願いを込めて楽天APIを導入し、商品検索機能を実装しました。

## 使用技術

### フロントエンド
  * Haml/SCSS
  * Javascript
  * jQuery
  * Bootstrap(cssフレームワーク)

### バックエンド
  * Ruby(2.6.5)
  * Ruby on Rails(6.1.3.2)

### インフラ、開発環境
  * Docker
  * docker-compose
  * MySQL
  * AWS(VPC, EC2, RDS, S3, Route53, ACM, ALB, IAM)
  * CircleCI
    * CI: プルリクエスト実行時にRubocopとRspecが自動で実行されます。
    * CD: Githubのmasterブランチにmargeされた時にCapistranoが実行されて自動デプロイされます 

### テスト、静的コード解析
  * Rspec
  * Rubocop

### サーバー環境
  * Nginx
  * Puma


## インフラ構成図
![aws-Page-1 (1)](https://user-images.githubusercontent.com/75205515/125024648-25f1a900-e0bc-11eb-9be9-f87a76665a3a.png)

## ER図
![名称未設定ファイル](https://user-images.githubusercontent.com/75205515/125024770-63563680-e0bc-11eb-846f-af697b2ecfee.png)

## 機能一覧
  * ユーザー新規登録/ログイン機能
  * ゲストログイン機能
  * ユーザー詳細情報/編集
  * プロテイン、サプリ情報投稿
  * プロテイン、サプリ投稿一覧
  * プロテイン、サプリ投稿詳細
  * いいね機能(Ajax)
  * フォロー機能(Ajax)
  * DM機能(Ajax)
  * 星レビュー機能(Ajax)
  * タブ機能(Ajax)
  * レビュー機能
  * 通知機能
  * ユーザー検索機能
  * 商品検索機能
  * レビューランキング機能
  * タグ機能
  * 競技種目別グラフ機能
  * ページネーション機能

## 機能詳細
  ### ユーザー機能
   * deviseを使用
   * 新規登録、ログイン、ログアウト、編集機能
   * ゲストログイン機能
   * ユーザー一覧機能
   * ユーザー検索機能はgemを不使用
   * ユーザー詳細ページにてタブを実装しクリックすると投稿した記事とレビューした記事が表示される
  ### 記事機能
   * 記事投稿機能
   * 記事詳細表示機能
   * 記事一覧表示機能
   * 記事削除機能
   * 画像投稿にはActive storageを使用
   * ページネーション機能
   * 記事一覧画面でChartkick gemによるユーザーの競技種目の比率を可視化
   * レビュー平均点数ランキングをトップページに配置
  ### いいね機能(Ajax)
   * 記事詳細画面にていいねできる機能
   * 非同期で実装
  ### フォロー機能(Ajax)
   * フォロー、フォロー解除機能
   * フォロー、フォロワー一覧表示機能
  ### DM機能(Ajax)
   * 1対1のチャットルームを作成
   * メッセージ送信、削除機能
   * DM中のユーザー一覧を表示
  ### 星レビュー機能(Ajax)
   * レビューのスコアを星５つで点数化できるように実装
  ### レビュー機能
   * レビューコメントを投稿できるように実装
  ### 通知機能
   * DM、コメント、フォロー、いいねがユーザーからあった場合に通知
   * 通知一括削除機能
  ### 商品検索機能
   * 楽天APIを使用
   * 検索結果から画像、価格、平均レビューの表示、楽天サイトへ遷移が可能
  ### タグ機能
   * 記事投稿にてタグを複数付けて投稿することが可能
   * タグをクリックすると同じタグが付いた記事一覧が表示される。
## 今後の改良計画
 * Vue.jsによる部分SPA化、UXの向上
 * AWSのECSやECRを使った本番環境のコンテナ化
 * 通知を受け取った際のマーク表示
 * Requestspec、Systemspec周りのテストを追加

### お忙しい中最後まで見ていただき本当にありがとうございました。
