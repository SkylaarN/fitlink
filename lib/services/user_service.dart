// import 'package:firebase_auth/firebase_auth.dart';


// class UserService {
//   final FirebaseService _firebaseService = FirebaseService();

//   /// Registers a new user and adds them to Firestore
//   Future<void> registerUser(String email, String password) async {
//     try {
//       UserCredential userCredential = await _firebaseService.auth
//           .createUserWithEmailAndPassword(email: email, password: password);

//       String uid = userCredential.user!.uid;

//       // Add user to Firestore
//       await createUserInFirestore(uid, email);
//       print("User registered and added to Firestore successfully.");
//     } catch (e) {
//       print("Error registering user: $e");
//     }
//   }

//   /// Creates a user document in the Firestore `user_data` collection
//   Future<void> createUserInFirestore(String uid, String email) async {
//     final userRef = _firebaseService.firestore.collection('user_data').doc(uid);

//     // Basic user information
//     await userRef.set({
//       'email': email,
//       'createdAt': DateTime.now(),
//     });

//     // Initialize sub-collections
//     await userRef.collection('chats').doc('placeholder').set({'init': true});
//     await userRef.collection('workouts').doc('placeholder').set({'init': true});

//     // Cleanup placeholders
//     await userRef.collection('chats').doc('placeholder').delete();
//     await userRef.collection('workouts').doc('placeholder').delete();
//   }

//   /// Adds a new chat document to the `chats` sub-collection
//   Future<void> addChat(String userId, String receiverId, String initialMessage) async {
//     final chatId = [userId, receiverId]..sort(); // Ensure consistent chat ID
//     final chatDocId = chatId.join('_');

//     final userChatRef = _firebaseService.firestore
//         .collection('user_data')
//         .doc(userId)
//         .collection('chats')
//         .doc(chatDocId);

//     final receiverChatRef = _firebaseService.firestore
//         .collection('user_data')
//         .doc(receiverId)
//         .collection('chats')
//         .doc(chatDocId);

//     final chatData = {
//       'participants': chatId,
//       'lastMessage': initialMessage,
//       'lastMessageTimestamp': DateTime.now(),
//       'messages': [],
//     };

//     // Create chat references for both users
//     await userChatRef.set(chatData);
//     await receiverChatRef.set(chatData);

//     print("Chat created successfully between $userId and $receiverId.");
//   }

//   /// Adds a workout document to the `workouts` sub-collection
//   Future<void> addWorkout(String userId, Map<String, dynamic> workoutData) async {
//     final workoutRef = _firebaseService.firestore
//         .collection('user_data')
//         .doc(userId)
//         .collection('workouts');

//     await workoutRef.add(workoutData);

//     print("Workout added successfully for $userId.");
//   }
// }
