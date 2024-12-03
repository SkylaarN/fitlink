import 'package:fit_quest/auth/models/auth_service.dart';
import 'package:fit_quest/components/my_drawer.dart';
import 'package:fit_quest/components/user_tile.dart';
import 'package:fit_quest/services/chat_service.dart';
import 'package:flutter/material.dart';

import 'chat/chat_page.dart';

class FriendsPage extends StatelessWidget {
  FriendsPage({super.key});

  // chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService authService = AuthService();

  void logout() {
    // get auth service
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUsersStream(),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return const Text('Error');
          }

          // loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading..');
          }

          // return List view
          return ListView(
              children: snapshot.data!
                  .map<Widget>(
                      (userData) => _buildUserListItem(userData, context))
                  .toList());
        });
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all users except current user
    if (userData["email"] != authService.getCurrentUser()) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          //tapped on a user --> go to chat page
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPage(
                  receiverEmail: userData["email"],
                  receiverID: userData["uid"],
                ),
              ));
        },
      );
    } else {
      return Container();
    }
  }
}
