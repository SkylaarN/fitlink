import 'package:fit_quest/home/components/headings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'wave_circle.dart';

class Steps extends StatelessWidget {
  final String title;
  final Color color;
  final double level;
  final String textLevel;
  final IconData widgetIcon;

  const Steps({
    super.key,
    required this.title,
    required this.color,
    required this.level,
    required this.textLevel,
    required this.widgetIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Heading(headingText: title, headingSize: 20),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              WaveCircle(
                progress: level, // Set water level
                waveColor: color, // Set wave color
                borderColor: Colors.white38, // Set border color
                borderWidth: 1.0, // Set border width
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    widgetIcon, // Use the passed IconData
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(height: 8), // Space between icon and text
                  Text(
                    textLevel, // Display the amount in milliliters
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16), // Add spacing between the Stack and Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
              ),
              SizedBox(width: 20), // Space between icon and text
              Text(
                "Dec",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            height: 200,
            child: Center(child: Text("graph here", style: TextStyle(color: Colors.white),),),
          )
        ],
      ),
    );
  }
}
