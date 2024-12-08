import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_quest/home/views/weekly_goal_setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../auth/models/auth_service.dart';
import '../../components/steps.dart';
import '../../components/steps_tracker.dart';
import '../../workout/firestore.dart';
import '../components/best_records_card.dart';
import '../components/circle_progress_bar.dart';
import '../components/headings.dart';
import '../components/heptagon_progress_painter.dart';
import '../components/line_divider.dart';
import '../components/tracks.dart';
import '../components/workout_card.dart';
import '../models/home_page_provider.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreService firestoreService = FirestoreService();
  final StepsTracker stepsTracker = StepsTracker();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context, listen: false);
    // Initialize the step tracker once
    stepsTracker.initialize(provider);
    
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreService.getWorkoutsStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No workouts available.'));
        }

        // Parse workouts and update the provider
        /*
        The setter 'workoutsList' isn't defined for the type 'HomePageProvider'.
Try importing the library that defines 'workoutsList', correcting the name to the name of an existing setter, or defining a setter or field named 'workoutsList'.
        The setter 'parsedWorkouts' isn't defined for the type 'HomePageProvider'.
Try importing the library that defines 'parsedWorkouts', correcting the name to the name of an existing setter, or defining a setter or field named 'parsedWorkouts'.
        */
        provider.workoutsList = snapshot.data!.docs;
        provider.parsedWorkouts = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>?;
          return {
            'id': doc.id,
            'mood': data?['mood'] ?? 'Unknown',
            'userEmail': data?['userEmail'] ?? 'Unknown',
            'date': data?['date'] ?? Timestamp.now(),
            'steps': data?['steps'] ?? 0,
            'waterIntake': data?['waterIntake'] ?? 0,
            'distance': data?['distance'] ?? 0,
          };
        }).toList();

        return ListView(
          children: [
            const SizedBox(height: 40),

            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WeeklyGoalSetting()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HeptagonProgressBar(
                      progress: 1,
                      backgroundColor: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.personWalking,
                          size: 20.0,
                          color: Colors.green,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "0",
                          style: TextStyle(fontSize: 20, color: Colors.white54),
                        ),
                        Text(
                          "/150min",
                          style: TextStyle(fontSize: 15, color: Colors.white54),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          FontAwesomeIcons.personRunning,
                          size: 20.0,
                          color: Colors.orange,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "0",
                          style: TextStyle(fontSize: 20, color: Colors.white54),
                        ),
                        Text(
                          "/75min",
                          style: TextStyle(fontSize: 15, color: Colors.white54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: Heading(headingText: "Today's habit", headingSize: 15),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleProgressBar(
                  heightWidth: 40,
                  label: "Steps",
                  value: provider.stepslevel(),
                  icon: FontAwesomeIcons.shoePrints,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Center(
                                child: Steps(
                                  title: 'Steps',
                                  color: Colors.green,
                                  level: provider.stepslevel(),
                                  textLevel:
                                      "${(provider.stepslevel() * 100).roundToDouble()}%",
                                  widgetIcon: FontAwesomeIcons.shoePrints,
                                ),
                              )),
                    );
                  },
                  noSteps: provider.getNoSteps(),
                ),
                const SizedBox(width: 30),
                CircleProgressBar(
                  heightWidth: 40,
                  label: "Water",
                  value: provider.waterlevel(),
                  icon: FontAwesomeIcons.droplet,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Center(
                                child: Steps(
                                  title: 'Water',
                                  color: Colors.blue,
                                  level: provider.waterlevel(),
                                  textLevel: (provider.waterlevel() * 100)
                                      .roundToDouble()
                                      .toString(),
                                  widgetIcon: FontAwesomeIcons.faucet,
                                ),
                              )),
                    );
                  },
                  noSteps: provider.getMlWater(),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Heading(headingText: "Today's training", headingSize: 15),
                  Heading(
                      headingText: "MORE",
                      headingSize: 15,
                      color: Colors.green),
                ],
              ),
            ),

            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  GestureDetector(
                      onTap: () => provider.handleTap("Workout 1"),
                      child:
                          WorkoutCard(imagePath: 'lib/images/workout1.jpg')),
                  GestureDetector(
                      onTap: () => provider.handleTap("Workout 2"),
                      child:
                          WorkoutCard(imagePath: 'lib/images/workout3.jpg')),
                ],
              ),
            ),

            const SizedBox(height: 20),

            LineDivider(),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Heading(headingText: "Recent activities", headingSize: 15),
                  Heading(
                    headingText: "MORE",
                    headingSize: 15,
                    color: Colors.green,
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () => provider.handleTap("Track 1"),
              child: Tracks(
                trackImage: 'lib/images/track.jpeg',
                trackDate: provider.getDate(),
                trackDistance: provider.getDistance(),
                trackTime: '00:00:40',
                trackMood: provider.mood(),
              ),
            ),

                      Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 2,
                width: 300,
                color: Colors.black,
              ),
            ],
          ),

          GestureDetector(
              onTap: () => provider.handleTap("Track 2"),
              child: Tracks(
                trackImage: 'lib/images/track1.png',
                trackDate: provider.getDate(),
                trackDistance: provider.getDistance(),
                trackTime: '00:10:40',
                trackMood: provider.mood(),
              )),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 2,
                width: 300,
                color: Colors.black,
              ),
            ],
          ),

          GestureDetector(
              onTap: () => provider.handleTap("Track 3"),
              child: Tracks(
                trackImage: 'lib/images/track2.jpeg',
                trackDate: provider.getDate(),
                trackDistance: provider.getDistance(),
                trackTime: '00:20:23',
                trackMood: provider.mood(),
              )),

          LineDivider(),

          // ----------------------- best Records

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Heading(headingText: "Best records", headingSize: 15),
            ),

            GestureDetector(
                onTap: () => provider.handleTap("Best Record 1"),
                child: BestRecordsCard(
                    recordDistance: provider.getDistance(),
                    recordStats: "${provider.getDistance()}km",
                    recordTime: "01:27",
                    recordName: "Longest Distance",
                    recordIcon: FontAwesomeIcons.road)),

          const SizedBox(
            height: 10,
          ),

          GestureDetector(
              onTap: () => provider.handleTap("Best Record 2"),
              child: BestRecordsCard(
                  recordDistance: provider.getDistance(),
                  recordStats: "${provider.getDistance()}km",
                  // recordStats: (parsedWorkouts.isNotEmpty ? parsedWorkouts.last['distance'] *100 / 99: 0).toString() +"/km",
                  recordTime: "01:27",
                  recordName: "Best pace",
                  recordIcon: FontAwesomeIcons.star)),

          const SizedBox(
            height: 10,
          ),

          GestureDetector(
              onTap: () => provider.handleTap("Best Record 3"),
              child: BestRecordsCard(
                  recordDistance: provider.getDistance(),
                  recordStats: "01:27",
                  recordTime: "01:27",
                  recordName: "Longest Duration",
                  recordIcon: FontAwesomeIcons.solidClock)),

          const SizedBox(
            height: 30,
          )
          ],
        );
      },
    );
  }
}
