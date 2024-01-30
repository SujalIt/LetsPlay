import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:letsplay/firstpage.dart';
import 'package:letsplay/searchBarWithApi.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var Email = TextEditingController();
  var Password = TextEditingController();
  final supabase = Supabase.instance.client;
  Future<void> Signin(String email,String password)async{
        await supabase.auth.signInWithPassword(password: password,email: email,).then(
                (value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Myfirstpage(),)));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:Colors.white,

        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: Email,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email/Phone Number',
                        prefixIcon:
                        Icon(Icons.email, color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.green, width: 2))),
                  ),
                  Container(
                    height: 10,
                  ),
                  TextField(
                    controller: Password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter Password',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Colors.green, width: 2))),
                  ),
                  Container(
                    height: 10,
                  ),
                  SizedBox(
                    width: 125,
                    child: ElevatedButton(
                        onPressed:(){ Signin(Email.text.toString(),Password.text.toString());},
                        child:Text('Login',style: TextStyle(color: Colors.white),),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
