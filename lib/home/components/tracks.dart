import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tracks extends StatelessWidget {
  const Tracks({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/images/track.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          
              const Column(
                children: [
                  Text(
                    "Sun 19:37",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.white54,
                    ),
                  ),              
                SizedBox(height: 10,),
                  Text(
                  "0.01km",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.green,
                      ),
                    ),              
                SizedBox(height: 10,),
                Text(
                  "0:00:40",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 10,),
                ],
              ),
              const Column(
                children: [
                  Text(
                    "0:00:40",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                SizedBox(height: 10,),
                ],
              ),
              const Column(
                children: [
                  Icon(
                    FontAwesomeIcons.solidFaceSmile, // Home icon
                    size: 20.0,
                    color: Colors.yellow,
                  ),
                  SizedBox(height: 30,),
                  Text(
                    "0:00:40",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.green,
                    ),
                  ),
                SizedBox(height: 10,),
                ],
              ),
            ],
          ),
        );
  }
}