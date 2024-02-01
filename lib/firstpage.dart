import 'package:flutter/material.dart';
import 'package:letsplay/p1image.dart';
import 'package:letsplay/redirecting_page.dart';
import 'package:letsplay/searchBarWithApi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Myfirstpage extends StatefulWidget {
  const Myfirstpage({super.key});

  @override
  State<Myfirstpage> createState() => MyfirstpageState();
}

class MyfirstpageState extends State<Myfirstpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255, 40, 252, 7),

        title: const Text('LetsPlay',style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,),),
        centerTitle: true,
        actions: [
          GestureDetector(onTap: () {
            Supabase.instance.client.auth
                .signOut()
                .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const RedirectingPage(),
                )));
          },
            child: const CircleAvatar(backgroundColor:Color.fromARGB(
                255, 40, 252, 7) ,child:
            Icon(
              Icons.logout_rounded,
              color: Colors.redAccent,
            )

            ),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 25, left: 25, right: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            p1container(),
            SizedBox(
              height: 20,
            ),
            Expanded(child: SingleChildScrollView(child: apiIntigration())),
          ],
        ),
      ),
    );
  }
}
