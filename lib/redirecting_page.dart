import 'package:flutter/material.dart';
import 'package:letsplay/Login.dart';
import 'package:letsplay/firstpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RedirectingPage extends StatefulWidget {
  const RedirectingPage({super.key});

  @override
  State<RedirectingPage> createState() => _RedirectingPageState();
}

class _RedirectingPageState extends State<RedirectingPage> {
  @override
  void initState(){
    super.initState();
    _redirect();
  }
  Future<void> _redirect()async{
    await Future.delayed(Duration.zero);
    final supabase=Supabase.instance.client;
    final session= supabase.auth.currentSession;
    if(!mounted)return;
    if (session==null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Myfirstpage(),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const LoginPage(),));
    }
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
