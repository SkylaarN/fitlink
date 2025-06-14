import 'package:fit_quest/auth/models/login_or_register.dart';
import 'package:fit_quest/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // user is logged in
            if (snapshot.hasData) {
              return HomeScreen();
            }

            // user is Not logged in
            else {
              return const LoginOrReister();
            }
            
          }),
    );
  }
}
