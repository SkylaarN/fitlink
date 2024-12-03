import 'package:flutter/material.dart';

class TopPart extends StatelessWidget {
  const TopPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: 100,
            color: Colors.grey,
            child: const Center(child: Text("tttt")),
          ),
          ListView(
            children: [
              Container(
                height: 600,
                color: Colors.pink,
              )
            ],
          )
        ],
      ),
    );
  }
}
