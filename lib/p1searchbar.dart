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
          height: 28,
          width: 218,
          child: TextField(
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: "Search",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
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