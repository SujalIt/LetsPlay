import 'package:flutter/material.dart';
import 'package:LetsPlay/Login.dart';
import 'package:LetsPlay/p1image.dart';
import 'package:LetsPlay/searchBarWithApi.dart';
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
        backgroundColor: const Color.fromARGB(255, 95, 251, 100),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                icon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.account_circle_sharp,
                    semanticLabel: 'Login',
                    color: Colors.black,
                  ),
                )),
          if (session != null)
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Are you sure you want to logout?"),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 40,
                                  width: 110,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Color.fromARGB(255, 90, 252, 95))),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 110,
                                  height: 40,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          Supabase.instance.client.auth
                                              .signOut();
                                        });
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const Myfirstpage()));
                                      },
                                      style: const ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 90, 252, 95))),
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ),
                              ],
                            )
                          ],
                        );
                      });
                },
                icon: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.logout_rounded,
                    semanticLabel: 'Logout',
                    color: Colors.black,
                  ),
                )),
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
