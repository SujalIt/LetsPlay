import 'package:flutter/material.dart';

class p1searchbar extends StatefulWidget {
  const p1searchbar({super.key});

  @override
  State<p1searchbar> createState() => _p1searchbarState();
}

class _p1searchbarState extends State<p1searchbar> {

  void updatelist(String value){

  }



  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SizedBox(
          height: 48,
          width: 290,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: "Search grounds",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            )
          ),
        ),
        SizedBox(width: 3,),
        Icon(Icons.search,size: 39,),
      ],
    );
  }
}