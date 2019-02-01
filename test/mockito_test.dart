import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

/// 依存される側クラスの本実装。
/// こいつをモックしたい。
class Dependee {
  String loadValue() => "from Dependee";

  void saveValue(String value) {
    print(value);
  }

  Future<String> loadValueAsync() => Future.value("async value from Dependee");
}

/// [Dependee]に依存するクラス
class Depender {
  final Dependee _dependee;

  Depender(this._dependee) : assert(_dependee != null);

  String usingDependeeReturnedValue() {
    return "value ${_dependee.loadValue()}";
  }

  void doSomethingViaDependee(String value) {
    _dependee.saveValue("$value via Depender");
  }
}

/// MockitoでモックしたDependee.
/// 挙動などを後からテストケース内などで設定する。
class MockDependee extends Mock implements Dependee {}

void main() {
  group("Mockitoの基本的な使い方", () {
    test("モックのメソッドの戻り値を設定する", () {
      final dependee = MockDependee();
      when(dependee.loadValue()).thenReturn("from mocked Dependee");

      final depender = Depender(dependee);
      expect(depender.usingDependeeReturnedValue(), "value from mocked Dependee");
    });
    test("モックのメソッドがコールされたことを確認する", () {
      final dependee = MockDependee();
      final depender = Depender(dependee);
      depender.doSomethingViaDependee("to mocked Dependee");

      verify(dependee.saveValue("to mocked Dependee via Depender"));
    });
  });
  group("MockitoとFuture/Stream", () {
    test("thenReturnでFutureやStreamを返すことはできない", () {
      // この後、whenによる挙動設定中に例外を飛ばす。
      // 設定中に例外を飛ばすと以降のテストケースでwhenを呼んだときにBad stateの例外が飛ぶため、
      // このテストケースに限っては「設定中である」という状態をリセットする必要がある。
      // 通常は必要ない。
      addTearDown(() {
        resetMockitoState();
      });
      expect(() {
        final dependee = MockDependee();
        when(dependee.loadValueAsync()).thenReturn(Future.value("mocked value"));
      }, throwsArgumentError);
    });
    test("thenAnswerでFutureやStreamを作って返す", () {
      final dependee = MockDependee();
      when(dependee.loadValueAsync()).thenAnswer((_) => Future.value("mocked value"));
      expect(dependee.loadValueAsync(), completion("mocked value"));
    });
  });
}
