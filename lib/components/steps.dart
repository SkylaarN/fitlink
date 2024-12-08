import 'package:fit_quest/home/components/headings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../home/models/home_page_provider.dart';
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
    // Access the HomePageProvider using Consumer
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) {
        final waterIntake = provider.addWaterIntake; // Get the water intake value

        return Scaffold(
          appBar: AppBar(
            title: Heading(headingText: title, headingSize: 20),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  // Pass the 'level' parameter for the WaveCircle widget
                  WaveCircle(
                    progress: level, // Set the level dynamically
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
                        textLevel, // Display the value dynamically (e.g., steps or water intake)
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
              const SizedBox(height: 16),

              // Only show water glasses when user taps on water (can be extended later if needed)
              if (title == 'Water') 
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.glassWater,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          // Increase water intake by 250ml when tapped
                          provider.addWaterIntake(250);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.glassWater,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          // Increase water intake by 250ml when tapped
                          provider.addWaterIntake(250);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.glassWater,
                          color: Colors.white,
                          size: 40,
                        ),
                        onPressed: () {
                          // Increase water intake by 250ml when tapped
                          provider.addWaterIntake(250);
                        },
                      ),
                    ],
                  ),
                ),

              // Optionally, you can add a graph below
              SizedBox(height: 20),
              Container(
                height: 200,
                child: Center(
                  child: Text(
                    "Graph here", // Placeholder for graph
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
