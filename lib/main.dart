import 'package:flutter/material.dart';

import 'movies_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GET API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black87,
      ),
      home: const MoviesPage(),
    );
  }
}
