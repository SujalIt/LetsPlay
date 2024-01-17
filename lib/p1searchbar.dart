import 'package:flutter/material.dart';

class p1searchbar extends StatelessWidget {
  const p1searchbar({
    super.key,
  });

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
              hintText: "Search",
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