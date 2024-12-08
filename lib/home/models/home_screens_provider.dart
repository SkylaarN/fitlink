import 'package:fit_quest/run/google_maps/google_map_polygon.dart';
import 'package:fit_quest/run/google_maps/google_map_polyline.dart';
import 'package:fit_quest/run/google_maps/step_counter_page.dart';
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
    AnalysisPage(
      waterData: [0.2, 0.5, 0.7, 0.4, 0.9], // Water intake data (0.0 to 1.0)
      stepsData: [0.3, 0.6, 0.8, 0.5, 1.0], // Steps data (0.0 to 1.0)
      waterXAxisScale: ["Mon", "Tue", "Wed", "Thu", "Fri"], // X-axis labels for water
      stepsXAxisScale: ["Mon", "Tue", "Wed", "Thu", "Fri"], // X-axis labels for steps
    ),
    FriendsPage(),
    // const GoogleMapPolyline(),
    // const GoogleMapPolygon(),
    // StepCounterPage(),
    // FriendsPage(),
  ];

  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
