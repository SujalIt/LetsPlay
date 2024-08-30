import 'package:flutter/material.dart';
import 'package:letsplay/firstpage.dart';
import 'package:letsplay/infoscreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://gdttugfvfxuisjkroszc.supabase.co',
      anonKey:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImdkdHR1Z2Z2Znh1aXNqa3Jvc3pjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI4NzgwMTMsImV4cCI6MjAzODQ1NDAxM30.YJEMSFQ-i2Z06wlEnT0AE9j4-X2lniWWXzojMwur2xI");
  runApp(const MyApp());
}

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Myfirstpage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'informationScreen/id=:vid',
          builder: (BuildContext context, GoRouterState state) {
            final userInput = state.pathParameters;
            var strVid = userInput['vid'];
            var finalId = num.tryParse(strVid!);
            return InformationScreen(vendId: finalId);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      // debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
