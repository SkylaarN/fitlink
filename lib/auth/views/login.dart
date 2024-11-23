import 'package:fit_quest/auth/models/auth_service.dart';
import 'package:fit_quest/components/my_button.dart';
import 'package:fit_quest/components/my_textfiels.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  // email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // tap to go to Register
  final Function()? onTap;

  LoginPage({super.key, this.onTap});

  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try login
    try {
      await authService.signInWithEmailPassword(
        _emailController.text,
        _passwordController.text,
      );
    }

    // catch any errors
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(Icons.message,
                size: 60, color: Theme.of(context).colorScheme.primary),

            const SizedBox(
              height: 50,
            ),

            // welcpme back
            Text(
              'Welcome back to our amzing app',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            // email textfield
            MyTextfield(
              hintText: 'Email',
              hideWord: false,
              controller: _emailController,
            ),

            const SizedBox(
              height: 25,
            ),

            // pw textfield
            MyTextfield(
              hintText: 'Password',
              hideWord: true,
              controller: _passwordController,
            ),

            const SizedBox(
              height: 25,
            ),

            // login button
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(
              height: 25,
            ),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'register',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
