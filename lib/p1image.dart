import 'package:flutter/material.dart';

class p1container extends StatelessWidget {
  const p1container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 147,
      width: 358,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network('https://i.ytimg.com/vi/5Ygl2rD3bYk/maxresdefault.jpg',fit: BoxFit.cover, )),
    );
  }
}