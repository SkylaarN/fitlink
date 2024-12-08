import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Tracks extends StatelessWidget {
  final String trackImage;
  final String trackDate;
  final String trackDistance;
  final String trackTime;
  final IconData trackMood;
  const Tracks(
      {super.key,
      required this.trackImage,
      required this.trackDate,
      required this.trackDistance,
      required this.trackTime,
      required this.trackMood});

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
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(trackImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                trackDate,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white54,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                trackDistance,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                trackTime.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            children: [
              Text(
                trackTime,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          Column(
            children: [
              Icon(
                trackMood, // Home icon
                size: 20.0,
                color: Colors.yellow,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                trackTime,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.green,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
