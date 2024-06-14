import 'package:flutter/material.dart';

class newScreenRoute extends StatefulWidget {
  const newScreenRoute({super.key});

  @override
  State<newScreenRoute> createState() => _newScreenRouteState();
}

class _newScreenRouteState extends State<newScreenRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
      ),
      body: Text("data"),
    );
  }
}