import 'package:flutter/material.dart';
import 'package:letsplay/p1image.dart';
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
        padding: EdgeInsets.all(25.0),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              p1container(),
              SizedBox(
                height: 20,
              ),
              p1searchbar(),
              SizedBox(
                height: 10,
              ),
              Text("Grounds", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),),
              SizedBox(height: 13,),
              p1groundlist()
            ],
          ),
        ),
      ),
    );
  }
}





