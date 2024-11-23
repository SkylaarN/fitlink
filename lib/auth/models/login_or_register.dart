import 'package:fit_quest/auth/views/login.dart';
import 'package:fit_quest/auth/views/register.dart';
import 'package:flutter/material.dart';


class LoginOrReister extends StatefulWidget {
  const LoginOrReister({super.key});

  @override
  State<LoginOrReister> createState() => _LoginOrReisterState();
}

class _LoginOrReisterState extends State<LoginOrReister> {
  // initially show login
  bool showLoginpage = true;

  // toggle/ switch bewteen pages
  void togglePages() {
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginpage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}