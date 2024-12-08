import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepCounterPage extends StatefulWidget {
  @override
  _StepCounterPageState createState() => _StepCounterPageState();
}

class _StepCounterPageState extends State<StepCounterPage> {
  String _stepCount = '0';
  late Stream<StepCount> _stepCountStream;

  // Variable to store steps
  int _stepsToday = 0;

  @override
  void initState() {
    super.initState();
    initializePedometer();
  }

  // Initialize the pedometer and start listening for step counts
  void initializePedometer() {
    _stepCountStream = Pedometer.stepCountStream;

    // Listen to the pedometer stream and update state
    _stepCountStream.listen((StepCount stepCount) {
      setState(() {
        // Update the step count dynamically
        _stepsToday = stepCount.steps; // Store the updated steps
        _stepCount = stepCount.steps.toString(); // Show current step count
      });
    }).onError((error) {
      print('Error: $error');
    });
  }

  // Reset steps
  void resetSteps() {
    setState(() {
      _stepsToday = 0; // Reset the step count
      _stepCount = '0'; // Reset the displayed step count
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Steps Tracker"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Steps Today: $_stepsToday", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text("Current Steps: $_stepCount", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: resetSteps, 
              child: Text("Reset Steps")
            ),
          ],
        ),
      ),
    );
  }
}
