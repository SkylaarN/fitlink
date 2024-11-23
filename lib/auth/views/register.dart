import 'package:fit_quest/auth/models/auth_service.dart';
import 'package:fit_quest/components/my_button.dart';
import 'package:fit_quest/components/my_textfiels.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  // email and password controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // tap to go to Login
  final Function()? onTap;

  RegisterPage({super.key, this.onTap});

  void register(BuildContext context) {
    //Register here
    final auth = AuthService();

    // if passwords match --> create user
    if (_passwordController.text == _confirmPasswordController.text) {
      try{
            auth.signUpWithEmailPassword(
        _emailController.text, _passwordController.text);
      } 

      catch(e){
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
        ),
      );
      }
    }     
    
    // if passwords don't match --> tell user to fix
    else{
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Passwords don't match!"),
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
            const Icon(
              Icons.message,
              size: 60,
              // color: Theme.of(context).colorScheme.surface
            ),

            const SizedBox(
              height: 50,
            ),

            // welcpme back
            const Text(
              'Create account',
              style: TextStyle(
                color: Colors.blueGrey,
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

            // Confirm password textfield
            MyTextfield(
              hintText: 'Confirm password',
              hideWord: true,
              controller: _confirmPasswordController,
            ),

            const SizedBox(
              height: 25,
            ),

            // login button
            MyButton(
              text: 'Register',
              onTap: () => register(context),
            ),

            const SizedBox(
              height: 25,
            ),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Alread have an account?'),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: onTap,
                    child: const Text(
                      'login now',
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
