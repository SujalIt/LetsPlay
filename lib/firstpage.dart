import 'package:flutter/material.dart';
import 'package:letsplay/p1image.dart';
import 'package:letsplay/p1searchbar.dart';
import 'package:letsplay/searchBarWithApi.dart';

class Myfirstpage extends StatefulWidget {
  const Myfirstpage({super.key});
  
  @override
  State<Myfirstpage> createState() => MyfirstpageState();
}

class MyfirstpageState extends State<Myfirstpage> {
  
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body:  Padding(
        padding: EdgeInsets.only(top: 25,left: 25,right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            p1container(),
            SizedBox(
              height: 20,
            ),
            Expanded(child: SingleChildScrollView(child: apiIntigration())),
          ],
        ),
      ),
    );
  }
}





