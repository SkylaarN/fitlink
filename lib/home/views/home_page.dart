import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_quest/home/views/weekly_goal_setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../auth/models/auth_service.dart';
import '../../components/steps.dart';
import '../../workout/firestore.dart';
import '../components/best_records_card.dart';
import '../components/circle_progress_bar.dart';
import '../components/headings.dart';
import '../components/heptagon_progress_painter.dart';
import '../components/line_divider.dart';
import '../components/tracks.dart';
import '../components/workout_card.dart';
import '../models/home_page_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void handleTap(String label) {
    debugPrint("Tapped on: $label");
  }

  List<DocumentSnapshot> workoutsList = [];
  bool isLoading = true;

  final FirestoreService firestoreService = FirestoreService();
  final AuthService _authService = AuthService();

  List<Map<String, dynamic>> parsedWorkouts = [];

  void fetchWorkouts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final querySnapshot = await firestoreService.getWorkoutsStream().first;
      workoutsList = querySnapshot.docs;

      // Parse the data into a list of maps
      parsedWorkouts = workoutsList.map((document) {
        final data = document.data() as Map<String, dynamic>?;
        if (data == null) {
          return {
            'id': document.id,
            'mood': 'Unknown',
            'userEmail': 'Unknown',
            'date': 'Unknown',
            'steps': 0
          };
        }

        final Timestamp timestamp = data['date'];
        final DateTime dateTime = timestamp.toDate();
        final String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

        return {
          'id': document.id,
          'mood': data['mood'] ?? 'Unknown',
          'userEmail': data['userEmail'] ?? 'Unknown',
          'date': formattedDate,
          'steps': data['steps'] ?? 0, // Default to 0 if no steps data
          'waterIntake': data['waterIntake'] ?? 0,
        };
      }).toList();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching workouts: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWorkouts();
  }

  void addWorkout({String? docID}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Adding workout..."),
        actions: [
          ElevatedButton(
              onPressed: () async {
                if (docID == null) {
                  await firestoreService.addWorkout("Testing");
                } else {
                  await firestoreService.updateWorkout(docID, "Testing");
                }
                Navigator.pop(context);
                fetchWorkouts(); // Refresh the data
              },
              child: const Text("Save")),
        ],
      ),
    );
  }

  double stepslevel() {
    double percentage =
        ((parsedWorkouts.isNotEmpty ? parsedWorkouts.last['steps'] : 0) /
                6000) *
            100;
    return percentage / 100;
  }

  double waterlevel() {
    double percentage =
        ((parsedWorkouts.isNotEmpty ? parsedWorkouts.last['waterIntake'] : 0) /
                2000) *
            100;
    print(percentage);
    return percentage / 100;
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomePageProvider>(context, listen: false);

    return ListView(
      children: [
        const SizedBox(height: 40), // Add spacing at the top

        Center(
          child: GestureDetector(
            onTap: () {
              // the above class ias used in this line
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const Center(
                          child: WeeklyGoalSetting(),
                        )),
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

        // --------------------------
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
              value: stepslevel(),
              icon: FontAwesomeIcons.shoePrints,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Center(
                            child: Steps(
                              title: 'Steps',
                              color: Colors.green,
                              level: stepslevel(),
                              textLevel: (stepslevel() * 100)
                                      .roundToDouble()
                                      .toString() +
                                  "%",
                              widgetIcon: FontAwesomeIcons.shoePrints,
                            ),
                          )),
                );
                // put it here the code u gave is not structured like yours
              },
              noSteps:
                  parsedWorkouts.isNotEmpty ? parsedWorkouts.last['steps'] : 0,
            ),
            const SizedBox(width: 30),
            CircleProgressBar(
              heightWidth: 40,
              label: "Water",
              value: waterlevel(),
              icon: FontAwesomeIcons.droplet,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Center(
                            child: Steps(
                              title: 'Water',
                              color: Colors.blue,
                              level: waterlevel(),
                              textLevel: (waterlevel() * 100)
                                  .roundToDouble()
                                  .toString(),
                              widgetIcon: FontAwesomeIcons.faucet,
                            ),
                          )),
                );
                // put it here the code u gave is not structured like yours
              },
              noSteps: parsedWorkouts.isNotEmpty ? parsedWorkouts.last['waterIntake'] : 0,
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
                  headingText: "MORE", headingSize: 15, color: Colors.green),
            ],
          ),
        ),

        // ---------------WORKOUTS-------------------
        SizedBox(
          height: 200, // Specify height for the horizontal ListView
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                  onTap: () => provider.handleTap("Workout 1"),
                  child: WorkoutCard(imagePath: 'lib/images/workout1.jpg')),
              GestureDetector(
                  onTap: () => provider.handleTap("Workout 2"),
                  child: WorkoutCard(imagePath: 'lib/images/workout3.jpg')),
            ],
          ),
        ),

        /// --------------------------- here ----------

        const SizedBox(
          height: 20,
        ),

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

        // --------------------------
        // gesture detector for this
        GestureDetector(
            onTap: () => provider.handleTap("Track 1"), child: const Tracks()),

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
            onTap: () => provider.handleTap("Track 2"), child: const Tracks()),

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
            onTap: () => provider.handleTap("Track 3"), child: const Tracks()),

        LineDivider(),

        // ----------------------- best Records
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Heading(headingText: "Best records", headingSize: 15),
        ),

        GestureDetector(
            onTap: () => provider.handleTap("Best Record 2"),
            child: const BestRecordsCard()),
        const SizedBox(
          height: 10,
        ),

        GestureDetector(
            onTap: () => provider.handleTap("Best Record 2"),
            child: const BestRecordsCard()),
        const SizedBox(
          height: 10,
        ),

        GestureDetector(
            onTap: () => provider.handleTap("Best Record 3"),
            child: const BestRecordsCard()),

        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
