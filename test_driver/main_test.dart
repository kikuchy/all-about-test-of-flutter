import 'package:flutter_driver/flutter_driver.dart';
import 'package:test_core/test_core.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    driver?.close();
  });

  test("hoge", () async {
    expect(await driver.getText(find.byValueKey("Counter")), "0");
    await driver.tap(find.byValueKey("Increment"));
    expect(await driver.getText(find.byValueKey("Counter")), "1");
  });
}
