import 'package:flutter/material.dart';

class HomePageProvider with ChangeNotifier {

  late final Widget child;


  void handleTap(String widgetName) {
    // Add custom logic here
      // debugPrint("cool");

    debugPrint('Tapped on $widgetName');
  }

  Widget dope(Widget child) {
    return child;
  }
}

class Cool extends StatelessWidget {
  final Widget child;
  const Cool({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child,
    );
  }
}
