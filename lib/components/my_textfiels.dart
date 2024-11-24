import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String hintText;
  final bool hideWord;
  final TextEditingController controller;
  final FocusNode? focuseNode;

  const MyTextfield(
      {super.key,
      required this.hintText,
      required this.hideWord,
      required this.controller, this.focuseNode});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: hideWord,
        controller: controller,
        focusNode: focuseNode,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            // fillColor: Theme.of(context).color
            fillColor: Theme.of(context).colorScheme.secondary,
            hintText: hintText,
            filled: true,
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
            )),
      ),
    );
  }
}
