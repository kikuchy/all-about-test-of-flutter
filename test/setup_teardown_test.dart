import 'package:test_api/test_api.dart';

void main() {
  setUpAll(() {
    // setUpAll() はこのテストスイート（≒このファイル）の一番始めに一度だけ実行される
    print("First of Test Suite by setUpAll");
  });

  setUp(() {
    // setUp() に記述した処理は各テストケースの実行前に実行される
    print(" First setUp()");
  });

  tearDown(() {
    // tearDown() に記述した処理は各テストケースの実行後に実行される
    print(" First tearDown()");
  });

  tearDownAll(() {
    // tearDownAll() はこのテストスイート（≒このファイル）の最後に一度だけ実行される
    print("Last of Test Suite by tearDownAll");
  });

  group("グループでラップする場合", () {
    setUp(() {
      // 外のスコープの setUp() の方が先に実行される
      print("  Second setUp()");
    });

    tearDown(() {
      // 外のスコープの tearDown() の方が後に実行される
      print("  Second tearDown()");
    });

    test("通常のテストケース実行", () {
      print("   Test case 1");
      expect("通常テスト", anything);
    });

    test("特定のテストケースだけで特殊な事後処理が必要な場合", () {
      addTearDown(() {
        // このテストケースの直後のみで実行される
        print("   Only this Test Case");
      });
      print("   Test case 2");
      expect("なにかグローバルな状態を汚したのを元に戻す処理などを書く", anything);
    });
  });

  // ちなみに、テストケースの実行はmainの終了直前に行われるので、
  // テストケースに含まれない部分はテスト実行よりも先に評価される。
  print("(Out of Test)");
}
