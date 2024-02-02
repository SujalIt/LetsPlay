import 'package:flutter/material.dart';

class p1container extends StatefulWidget {
  const p1container({super.key});

  @override
  State<p1container> createState() => _p1containerState();
}

class _p1containerState extends State<p1container> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 2.11,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Image.network('https://i.ytimg.com/vi/5Ygl2rD3bYk/maxresdefault.jpg',fit: BoxFit.cover, )),
        ),
      ],
    );
  }
}
