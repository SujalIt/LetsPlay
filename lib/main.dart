import 'package:flutter/material.dart';
import 'package:letsplay/firstpage.dart';
import 'package:letsplay/info_Screen.dart';
import 'package:letsplay/p1searchbar.dart';
import 'package:letsplay/searchBarWithApi.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "f",
      routes: {
        "f":(context) => Myfirstpage(),
      },
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home:const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});



  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    return const Scaffold(

      body:Myfirstpage(),
    );
  }
}