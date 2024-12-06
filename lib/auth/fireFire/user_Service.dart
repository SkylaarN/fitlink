import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user
  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users_again').doc(user.uid).set(user.toJson());
  }

  // Fetch user data by UID
  Future<UserModel?> getUser(String uid) async {
    final doc = await _firestore.collection('users_again').doc(uid).get();
    if (doc.exists) {
      return UserModel.fromJson(doc.data()!);
    }
    return null;
  }
}
