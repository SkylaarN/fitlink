import 'package:flutter/material.dart';

import '../../friends_page.dart';
import '../../pages/plan_page.dart';
import '../../run/run_page.dart';
import '../../stats/analysis_page.dart';
import '../views/home_page.dart';

class HomeScreenProvider extends ChangeNotifier {
  final List<Widget> pages = [
    HomePage(),
    const PlanPage(),
    const RunPage(),
    const AnalysisPage(),
    FriendsPage(),
  ];

  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
