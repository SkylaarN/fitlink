import 'package:fit_quest/home/components/headings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/heptagon_progress_painter.dart';

class WeeklyGoalSetting extends StatelessWidget {
  const WeeklyGoalSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Heading(headingText: "Weekly Goal Setting", headingSize: 25),
          backgroundColor: Colors.white54,
          elevation: 0,
        ),
        body: ListView(
          children: [
            const SizedBox(height: 40), // Add spacing at the top

            Center(
              child: HeptagonProgressBar(
                progress: 1,
                backgroundColor: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 40), // Add spacing at the top

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20), // Add spacing at the top
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.personWalking,
                      size: 20.0,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Add spacing at the top

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading(headingText: "Moderate intensity", headingSize: 20),
                    Text(
                      "0/15min",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Heading(headingText: "+", headingSize: 20),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 20), // Add spacing at the top
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all(color: Colors.grey)),
                  child: Center(
                    child: Icon(
                      FontAwesomeIcons.personRunning,
                      size: 20.0,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(width: 20), // Add spacing at the top

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Heading(headingText: "Moderate intensity", headingSize: 20),
                    Text(
                      "0/15min",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),

            const SizedBox(height: 30), // Add spacing at the top

            Center(
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.solidHeart,
                    size: 30.0,
                    color: Colors.red,
                  ),
                  Text(
                    "Heart health",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 350,
                    child: Text(
                      """Being physically active is a major step toward good heart health. But it's often hard to know how much and what intensity of activity is appropriate.
                      
Follow SAHA's (South African Health Association) guidelines and based on your own conditions, we will help you set the most appropriate goal.
                    
Fit Link makes things simple. Just complete your recommended weekly goals, you'll make your heart healthier and stronger.""",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
