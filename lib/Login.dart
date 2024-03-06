import 'package:flutter/material.dart';
import 'package:letsplay/firstpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  var Email = TextEditingController();
  var Password = TextEditingController();
  final supabase = Supabase.instance.client;
  Future<void> signin(String email, String password) async {
    await supabase.auth
        .signInWithPassword(
          password: password,
          email: email,
        )
        .then((value) => 
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Myfirstpage(),
            ))
            );
  }

  Future<void> signup(String email, String password) async {
    try {
      await supabase.auth.signUp(password: password, email: email);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('open your email')));
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.message)));
    }
  }

  late AnimationController _controller;

@override
  void dispose() {
    // ignore: unnecessary_null_comparison
    if(_controller != null){
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/Animation - 1707396927275.json',
                  controller: _controller,
                  onLoaded: (composition) {
                    _controller.repeat();
                  },
                  animate: true,
                  height: 100,
                  fit: BoxFit.cover,
                  repeat: true,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 320,
                  child: TextField(
                    controller: Email,
                    decoration: InputDecoration(
                        hintText: 'Enter Your Email',
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.green),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2))),
                  ),
                ),
                Container(
                  height: 10,
                ),
                SizedBox(
                  width: 320,
                  child: TextField(
                    controller: Password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Enter Password',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                                color: Colors.green, width: 2))),
                  ),
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            signin(Email.text.toString(),
                                Password.text.toString());
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          child: const Text(
                            'LogIn',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 40,
                      child: ElevatedButton(
                          onPressed: () {
                            signup(Email.text.toString(),
                                Password.text.toString());
                          },
                          style: const ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.green)),
                          child: const Text(
                            'SignUp',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
