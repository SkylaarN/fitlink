import 'package:firebase_core/firebase_core.dart';
import 'package:fit_quest/auth/models/auth_gate.dart';
import 'package:fit_quest/firebase_options.dart';
import 'package:fit_quest/home/models/home_screens_provider.dart';
import 'package:fit_quest/themes/light_mode.dart';
import 'package:fit_quest/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home/models/home_page_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider(),),
      ChangeNotifierProvider(create: (context) => HomeScreenProvider(),),
      ChangeNotifierProvider(create: (context) => HomePageProvider(),),
      // ChangeNotifierProvider(create: (_) => RotatingContainerProvider()),

    ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Link',
      theme: Provider.of<ThemeProvider>(context).themeData,
      // home: const MyHomePage(title: 'Fuel4U'),
      home: const AuthGate(),
    );
  }
}
