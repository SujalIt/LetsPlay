import 'package:flutter/material.dart';

class p1container extends StatelessWidget {
  const p1container({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      decoration: BoxDecoration(
        border: Border.all(
           color: const Color.fromARGB(255, 144, 144, 144),
           style: BorderStyle.solid,
          ),
      ),
      height: 67,
      width: 258,
      child: Image.network('https://img1.khelomore.com/venues/1418/coverphoto/1040x490/Web-capture-21-8-2022-201821-www-google-com.jpg',fit: BoxFit.cover, ),
      // Image.asset("images/emptyimage.png",),
    );
  }
}