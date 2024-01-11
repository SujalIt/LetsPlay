import 'package:flutter/material.dart';
import 'package:flutter_responsive/flutter_responsive.dart';
import 'package:letsplay/p1container.dart';
import 'package:letsplay/p1groundlist.dart';
import 'package:letsplay/p1searchbar.dart';

class Myfirstpage extends StatefulWidget {
  const Myfirstpage({super.key});
  
  @override
  State<Myfirstpage> createState() => MyfirstpageState();
}

class MyfirstpageState extends State<Myfirstpage> {
  
  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              p1container(),
              SizedBox(
                height: 24,
              ),
              p1searchbar(),
              SizedBox(
                height: 24,
              ),
              Text("Grounds", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),),
              SizedBox(
                height: 15,
              ),
              p1groundlist()
            ],
          ),
        ),
      ),
    );
  }
}





