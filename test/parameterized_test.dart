import 'package:test_api/test_api.dart';

// 今回テストする対象。
bool isEven(int val) => (val % 2) == 0;

void main() {
  group("isEvenは期待通りに動くか", () {
    // テストする値と期待する結果の組。
    // 今回は1対1なので単なるMapで作成したが、
    // 引数が多い場合などはListやタプルなどと期待する結果の組になる。
    final testValues = <int, bool>{
      0: true,
      1: false,
      2: true,
      -1: false,
      -2: true,
    };
    testValues.forEach((val, expectedResult) {
      // test()はテストケースを「登録する」関数なので、ループ内で呼び出せば
      // 複数のテストケースを登録できる。
      // descriptionには、テスト条件と確認したいことがわかりやすい文字列を渡すと良い。
      test("$valは偶数で${(expectedResult ? "ある" : "はない")}", () {
        expect(isEven(val), expectedResult);
      });
      // テストケースが増えるため、group()で囲っておくと結果が見やすくなる。
    });
  });
}