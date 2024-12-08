import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorkoutWidget extends StatefulWidget {
  @override
  _WorkoutWidgetState createState() => _WorkoutWidgetState();
}

class _WorkoutWidgetState extends State<WorkoutWidget> {
  // List of SVG image paths (replace with your workout images)
  final List<String> workoutImages = [
    'assets/workoutsvg/1.svg',
    'assets/workoutsvg/2.svg',
    'assets/workoutsvg/3.svg',
    'assets/workoutsvg/4.svg',
    'assets/workoutsvg/5.svg',
    'assets/workoutsvg/6.svg',
    'assets/workoutsvg/7.svg',
    'assets/workoutsvg/8.svg',
    'assets/workoutsvg/9.svg',
    'assets/workoutsvg/10.svg',
    'assets/workoutsvg/11.svg',
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startWorkout();
  }

  void _startWorkout() {
    Future.delayed(Duration(seconds: 10), _nextWorkout);
  }

  void _nextWorkout() {
    setState(() {
      currentIndex = (currentIndex + 1) % workoutImages.length;
    });

    if (currentIndex == 0) {
      // If all workouts are completed, pop the screen
      Navigator.pop(context);
    } else {
      _startWorkout(); // Continue with the next workout
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade300,
      appBar: AppBar(
        backgroundColor: Colors.green.shade500,
        title: Text('Workout Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the current workout image
            SvgPicture.asset(
              workoutImages[currentIndex],
              width: 200, // Adjust size as needed
              height: 200,
            ),
            SizedBox(height: 20),
            // Display a message for the user
            Text(
              'Next workout in 10 seconds',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
