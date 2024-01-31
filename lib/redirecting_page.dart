import 'package:flutter/material.dart';
import 'package:letsplay/Login.dart';
import 'package:letsplay/firstpage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RedirecingPage extends StatefulWidget {
  const RedirecingPage({super.key});

  @override
  State<RedirecingPage> createState() => _RedirecingPageState();
}

class _RedirecingPageState extends State<RedirecingPage> {
  @override
  void initState(){
    _redirect();
  }
  Future<void> _redirect()async{
    await Future.delayed(Duration.zero);
    final supabase=Supabase.instance.client;
    final session= supabase.auth.currentSession;
    if(!mounted)return;
    if (session!=null){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Myfirstpage(),));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginPage(),));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
