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
            child: Image.network(
            'https://playo.gumlet.io/HITZONE20211011073755143555/hitzone1634798636547.jpeg',
            // 'https://content3.jdmagicbox.com/v2/comp/surat/v2/0261px261.x261.230607104356.r5v2/catalogue/infinity-sports-turf-box-cricket-surat-sports-ground-9s0ek9rqps.jpg',
            fit: BoxFit.cover, )),
        ),
      ],
    );
  }
}
