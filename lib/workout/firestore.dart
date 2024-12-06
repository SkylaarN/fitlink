import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/models/auth_service.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

  final CollectionReference workouts =
      FirebaseFirestore.instance.collection("workouts");

  // Get the current user's email
  String getUserEmail() {
    return _auth.currentUser!.email!;
  }

    // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // CREATE: Add a workout
Future<void> addWorkout(String workout) {
  final String? userEmail = getCurrentUser()?.email;
  if (userEmail == null) {
    throw Exception('No logged-in user. Cannot add workout.');
  }

  return workouts.add({
    'userEmail': userEmail, // Use the email as a string
    'workoutName': workout,
    'caloriesBurned': 100,
    'date': Timestamp.now(),
    'distance': 1.1,
    'mood': 'sad',
    'steps': 251,
    'waterIntake': 1.5,
  });
}



  // READ: Get workouts for the logged-in user
Stream<QuerySnapshot> getWorkoutsStream() {
  final String? userEmail = _authService.getCurrentUser()?.email;
  if (userEmail == null) {
    print('Error: No user logged in.');
    return const Stream.empty(); // Return an empty stream if no user is logged in
  }

  print('Fetching workouts for userEmail: $userEmail');
  return workouts
      .where('userEmail', isEqualTo: userEmail) // Ensure 'userEmail' field matches
      .orderBy('date', descending: false)
      .snapshots();
}





  // UPDATE: Update a workout given its doc ID
  Future<void> updateWorkout(String docID, String workout) {
    print(getUserEmail());
    return workouts.doc(docID).update({
      'userEmail': getUserEmail(),
      'workoutName': workout,
      'caloriesBurned': 120,
      'date': Timestamp.now(),
      'distance': 1.5,
      'mood': 'updated',
      'steps': 300,
      'waterIntake': 2.0,
    });
  }

  // DELETE: Delete a workout given its doc ID
  Future<void> deleteWorkout(String docID) {
    return workouts.doc(docID).delete();
  }
}
