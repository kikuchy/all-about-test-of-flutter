import 'dart:convert';
import 'dart:io';

import 'package:test_api/test_api.dart';

// JSONをこのクラスにパースする
class MenuItem {
  final int id;
  final String name;
  final List<Topping> toppings;

  const MenuItem(this.id, this.name, this.toppings);
}

class Topping {
  final int id;
  final String type;

  const Topping(this.id, this.type);
}

// パース本体
MenuItem parseJsonString(String jsonString) {
  final rawMenu = jsonDecode(jsonString);
  final List<dynamic> rawToppings = rawMenu["topping"] ?? [];
  return MenuItem(
      int.parse(rawMenu["id"]),
      rawMenu["name"],
      rawToppings
          .map((rawTopping) =>
              Topping(int.parse(rawTopping["id"]), rawTopping["type"]))
          .toList());
}

void main() {
  test("JSONを期待通りにパースできるか", () {
    // 実行パスはプロジェクトルートになるので注意
    final sourceFile = File("./test/stub_data/sample.json");
    final item = parseJsonString(
        sourceFile.readAsStringSync());
    expect(item.name, "Cake");
  });
}
