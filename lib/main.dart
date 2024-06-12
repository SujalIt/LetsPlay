import 'package:flutter/material.dart';
import 'package:letsplay/APIS/LetsPlay.dart';
import 'package:letsplay/firstpage.dart';
import 'package:letsplay/infoscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://gmoflxgrysuxaygnjemp.supabase.co',
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdtb2ZseGdyeXN1eGF5Z25qZW1wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ4Njk3MDIsImV4cCI6MjAyMDQ0NTcwMn0.nN5gPTVz-vgCP4ywqfF7Nc_g8OgLCq6lR7kG5wCvhSU");
  runApp(const MyApp());
}

//   final GoRouter _router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return const Myfirstpage();
//       },
//       // routes: <RouteBase>[
//       //   GoRoute(
//       //     path: 'details',
//       //     builder: (BuildContext context, GoRouterState state) {
//       //       return InformationScreen();
//       //     },
//       //   ),
//       // ],
//     ),
//   ],
// );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   routerConfig: _router,
    // );
    return 
    MaterialApp(
      initialRoute: "f",
      routes: {
        "f":(context) => const Myfirstpage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}