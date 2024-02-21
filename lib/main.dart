import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:task1/loginPage.dart';

import 'package:task1/provider/studentListProvider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StudentListProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPage(),
    );
  }
}
