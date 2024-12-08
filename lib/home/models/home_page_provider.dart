import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';

import '../../auth/models/auth_service.dart';
import '../../database/database_helper.dart';
import '../../workout/firestore.dart';

class HomePageProvider with ChangeNotifier {
  final FirestoreService firestoreService = FirestoreService();

  DocumentSnapshot<Map<String, dynamic>>? latestWorkout;
  bool isLoading = true;

  // Step tracker variables
  late Stream<StepCount> _stepCountStream;
  int _currentSteps = 0; // Steps tracked during the current session

  // Water intake variables
  int _waterIntake = 0; // Track water intake

  // Firestore interaction
  List<DocumentSnapshot> _workoutsList = [];
  List<Map<String, dynamic>> _parsedWorkouts = [];

  // Getters for workoutsList and parsedWorkouts
  List<DocumentSnapshot> get workoutsList => _workoutsList;
  List<Map<String, dynamic>> get parsedWorkouts => _parsedWorkouts;

  // Setter for workoutsList and parsedWorkouts
  set workoutsList(List<DocumentSnapshot> newWorkouts) {
    _workoutsList = newWorkouts;
    notifyListeners(); 
  }

  set parsedWorkouts(List<Map<String, dynamic>> newParsedWorkouts) {
    _parsedWorkouts = newParsedWorkouts;
    notifyListeners(); 
  }

  HomePageProvider() {
    listenToLatestWorkout();
    initializeStepTracker();
  }

  void handleTap(String widgetName) {
    debugPrint('Tapped on $widgetName');
  }

  final int maxSteps = 1000;
  double stepslevel() {
    final steps = latestWorkout?.data()?['steps'] ?? 0;
    double percentage = (steps / maxSteps) * 100; // Calculate the percentage
    return percentage > 100
        ? 1.0
        : percentage / 100; // Return a value between 0 and 1
  }

  // Listen to Firestore for real-time updates
  void listenToLatestWorkout() {
    firestoreService.getWorkoutsStream().listen((querySnapshot) {
      final docs = querySnapshot.docs;

      if (docs.isNotEmpty) {
        latestWorkout =
            docs.last as QueryDocumentSnapshot<Map<String, dynamic>>;
      } else {
        latestWorkout = null;
      }

      isLoading = false;
      notifyListeners();
    });
  }

  // Initialize the step tracker
  void initializeStepTracker() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((StepCount stepCount) {
      _currentSteps = stepCount.steps;
      updateSteps(_currentSteps);
    }).onError((error) {
      print("Step tracker error: $error");
    });
  }

  // Update steps in the Firestore database
  Future<void> updateSteps(int steps) async {
    if (latestWorkout == null) {
      await addWorkout("Daily Steps");
    } else {
      await firestoreService.workouts.doc(latestWorkout!.id).update({
        'steps': steps,
      });
    }

    _currentSteps = steps;
    notifyListeners();
  }

  // Add a workout
  Future<void> addWorkout(String workout) async {
    final String? userEmail = firestoreService.getCurrentUser()?.email;
    if (userEmail == null) {
      throw Exception('No logged-in user. Cannot add workout.');
    }

    // Firestore data
    await firestoreService.workouts.add({
      'userEmail': userEmail,
      'workoutName': workout,
      'caloriesBurned': 100,
      'date': Timestamp.now(),
      'distance': 1.1,
      'mood': 'sad',
      'steps': _currentSteps,
      'waterIntake': _waterIntake,
    });

    // SQLite data
    final workoutData = {
      'userEmail': userEmail,
      'workoutName': workout,
      'caloriesBurned': 100,
      'date': DateTime.now().toString(),
      'distance': 1.1,
      'mood': 'sad',
      'steps': _currentSteps,
      'waterIntake': _waterIntake,
    };

    // Insert into SQLite
    await DatabaseHelper.instance.insertWorkout(workoutData);
  }

  // Method to update water intake in Firestore and notify listeners
  void addWaterIntake(int amount) {
    _waterIntake += amount;

    // Update Firestore in real-time
    if (latestWorkout != null) {
      firestoreService.workouts.doc(latestWorkout!.id).update({
        'waterIntake': _waterIntake,
      });
    }

    notifyListeners(); 
  }

  // Calculate water level as a percentage
  double waterlevel() {
    final waterIntake = latestWorkout?.data()?['waterIntake'] ?? 0;
    double percentage = (waterIntake / 2000) * 100;
    return percentage / 100;
  }

  // Method to get current water intake from Firestore
  int getMlWater() {
    return latestWorkout?.data()?['waterIntake'] ?? 0;
  }

  // Method to get step count from Firestore
  int getNoSteps() {
    return latestWorkout?.data()?['steps'] ?? 0;
  }

  
  String getDistance() {
    return (latestWorkout?.data()?['distance'] ?? 0).toString();
  }

  IconData mood() {
    final String mood = latestWorkout?.data()?['mood'] ?? "Unknown";
    switch (mood) {
      case "happy":
        return FontAwesomeIcons.solidFaceSmile;
      case "sad":
        return FontAwesomeIcons.solidFaceSadTear;
      case "updated":
        return FontAwesomeIcons.solidFaceSadTear;
      default:
        return FontAwesomeIcons.solidFaceDizzy;
    }
  }

  String getDate() {
    final Timestamp? timestamp = latestWorkout?.data()?['date'];
    if (timestamp == null) return 'Unknown';
    final DateTime dateTime = timestamp.toDate();
    return DateFormat('EEE HH:mm').format(dateTime);
  }
}
