import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/ui/common/container_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new ContainerPage(),
    ),
  );
}
