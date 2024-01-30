import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var Email = TextEditingController();
  var Password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(72, 239, 6, 0.2),

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
                  ElevatedButton(
                      onPressed: () {
                      },
                      child:Text('Login'),style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green))),
                ],
              ),
            ),
          ),
        ));
  }
}
