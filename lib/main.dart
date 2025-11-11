import 'package:animeverse/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/app_state_provider.dart';

// Single router instance to avoid recreating GlobalKeys
final _router = createRouter();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppStateProvider(),
      child: MaterialApp.router(
        title: 'AnimeVerse',
        theme: ThemeData(fontFamily: 'Urbanist'),
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

