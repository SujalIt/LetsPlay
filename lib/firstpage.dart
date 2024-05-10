import 'package:flutter/material.dart';
import 'package:letsplay/Login.dart';
import 'package:letsplay/p1image.dart';
import 'package:letsplay/searchBarWithApi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Myfirstpage extends StatefulWidget {
  const Myfirstpage({super.key});

  @override
  State<Myfirstpage> createState() => MyfirstpageState();
}

class MyfirstpageState extends State<Myfirstpage> {


  final session = Supabase.instance.client.auth.currentSession;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 95, 251, 100),
        title: const Text(
          'LetsPlay',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          if (session == null)
            IconButton(
              onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage(),
                )
              );
            }, icon: const Padding(
              padding: EdgeInsets.all(10.0),
              child:  Icon(
                Icons.account_circle_sharp,
                semanticLabel: 'Login',
                color: Colors.black,),
            )),
          if (session != null)
            IconButton(onPressed: (){
              showDialog(context: context,
               builder: (BuildContext context) {
                return  AlertDialog(
                  title: const Text("Are you sure you want to logout?"),
                  actions: [
                    Row(
                      children: [
                        TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: const Text("Cancel"),),
                        TextButton(onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('f'));
                        }, child: const Text("Yes")),
                      ],
                    )
                  ],
                );
               });
              setState(() {
                Supabase.instance.client.auth.signOut();
              });
            }, icon: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.logout_rounded,
                semanticLabel: 'Logout',
                color: Colors.black,),
            )
              ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            p1container(),
            SizedBox(
              height: 10,
            ),
            Expanded(child: SingleChildScrollView(child: apiIntigration())),
          ],
        ),
      ),
    );
  }
}
