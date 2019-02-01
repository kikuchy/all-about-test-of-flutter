# All About Test of Flutter コード集

[All About Test of Flutter](https://droidkaigi.jp/2019/timetable/70548)で説明する、
テスト関連のコード解説サンプルです。

## 内容

### テスト全般＆単体テスト関連のもの

* [リポジトリ全体のテストの設定(dart_test.yaml)](dart_test.yaml)
* [`test()`の基本的な使い方 (basic_test.dart)](test/basic_test.dart)
* [代表的な`Matcher`の紹介(matcher_test.dart)](test/matcher_test.dart)
* [事前処理/事後処理の記述方法と実行順序(setup_teardown_test.dart)](test/setup_teardown_test.dart)
* [パラメタライズドテスト(parameterized_test.dart)](test/parameterized_test.dart)
* [外部データの使用例(outer_source_test.dart)](test/outer_source_test.dart)
* [`Mockito`の紹介と使い方(mockito_test.dart)](test/mockito_test.dart)


### Widgetテスト関連のもの

* [Widgetテストの基本形(basic_widget_test.dart)](test/basic_widget_test.dart)
* [代表的な`Finder`の紹介(finders_widget_test.dart)](test/finders_widget_test.dart)
* [WidgetテストでListViewのスクロールをする(list_widget_test.dart)](test/list_widget_test.dart)


### 統合テスト関連のもの

* [ドライバーを有効にしたアプリケーション(main.dart)](test_driver/main.dart)
* [テストコード(main_test.dart)](test_driver/main_test.dart)