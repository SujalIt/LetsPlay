import 'package:flutter/material.dart';

class Mytimeslots extends StatefulWidget {
  const Mytimeslots({super.key});

  @override
  State<Mytimeslots> createState() => _MytimeslotsState();
}

class _MytimeslotsState extends State<Mytimeslots> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
     itemCount: 9,
     itemBuilder: (context, index){
      return SizedBox(
        height: 20,
        width: 20,
        child: Container(
          decoration:  BoxDecoration(
            border: Border.all(
              style: BorderStyle.solid,
            ),
          ),
          child: Text("8 - 9 AM")),
      );
    });
  }
}