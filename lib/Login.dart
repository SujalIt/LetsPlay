import 'package:flutter/material.dart';
import 'package:letsplay/firstpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var Email = TextEditingController();
  var Password = TextEditingController();
  final supabase = Supabase.instance.client;
  Future<void> signin(String email,String password)async{
        await supabase.auth.signInWithPassword(password: password,email: email,).then(
                (value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Myfirstpage(),)));
    }
  Future<void> signup(String email,String password)async{
    try{
      await supabase.auth.signUp(password: password,email: email);
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('open your email'))
        );
      }
    } on AuthException catch(error){
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error.message)));
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*backgroundColor:const Color.fromARGB(255, 162, 118, 161),*/

        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/Animation - 1707297809563.json',animate: true,
                    fit: BoxFit.cover,repeat: true,),
                    TextField(
                      controller: Email,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Email/Phone Number',
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
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2))),
                    ),
                    Container(
                      height: 20,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40,
                          child: ElevatedButton(
                              onPressed:(){ signin(Email.text.toString(),Password.text.toString());},
                              child:const Text('LogIn',style: TextStyle(color: Colors.white),),style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green))),
                        ),
                        // const SizedBox(width: 20,),
                        // SizedBox(height: 40,
                        //   child: ElevatedButton(
                        //       onPressed:(){ signup(Email.text.toString(),Password.text.toString());},
                        //       child:const Text('SignUp',style: TextStyle(color: Colors.white),),style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green))),
                        // ),
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
