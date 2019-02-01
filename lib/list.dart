import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FizzBuzz extends StatelessWidget {
  final int number;

  FizzBuzz(this.number) : assert(number > 0);

  @override
  Widget build(BuildContext context) {
    final fizzbuzz = (number % 15 == 0)
        ? "FizzBuzz"
        : ((number % 5 == 0)
        ? "Buzz"
        : ((number % 3 == 0) ? "Fizz" : "$number"));
    return Text(fizzbuzz);
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),),
      body: ListView.builder(itemBuilder: (context, i) {
        return ListTile(
          title: FizzBuzz(i + 1),
        );
      }),
    );
  }

}
