import 'package:flutter/material.dart';
import 'package:letsplay/Login.dart';
import 'package:letsplay/p1image.dart';
import 'package:letsplay/redirecting_page.dart';
import 'package:letsplay/searchBarWithApi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MyfirstPage extends StatefulWidget {
  const MyfirstPage({super.key});

  @override
  State<MyfirstPage> createState() => MyfirstPageState();
}

class MyfirstPageState extends State<MyfirstPage> {
  final session = Supabase.instance.client.auth.currentSession;
  Future<void> logOut()async{
    await Supabase.instance.client.auth.signOut();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ));
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.account_circle_sharp,
                  color: Colors.black,
                ),
              ),
            ),
          if (session != null)
            InkWell(
              onTap: (){
                logOut();
              },
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(
                  Icons.logout_rounded,
                  color: Colors.black,
                ),
              ),
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
