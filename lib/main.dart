import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/injection/dependency_injection.dart';
import 'package:rick_and_morty_app/module/common_page.dart';

void main() {
  Injector.configure(Flavor.PRO);

  runApp(
    MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new CommonPage(),
    ),
  );
}
