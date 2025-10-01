import 'package:animeverse/config/routes.dart';
import 'package:animeverse/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:animeverse/widgets/app_scaffold.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AnimeVerse',
      theme: ThemeData(
        fontFamily: 'Urbanist',
      ),
      // home: SignInScreen(), udah nggak perlu sebutin satu satu karena kita udah pakai router
      routerConfig: createRouter(), 
      debugShowCheckedModeBanner: false,
    );
  }
}

