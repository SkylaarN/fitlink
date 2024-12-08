import 'package:fit_quest/home/models/home_screens_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/my_drawer.dart';
import '../../run/google_maps/google_map.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              appBar: AppBar(
                title: const Text('Home'),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.grey,
                elevation: 0,
              ),
              drawer: const MyDrawer(),
              body: value.pages[value.selectedIndex],
              bottomNavigationBar: Stack(
                clipBehavior: Clip.none,
                children: [
                  BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: value.selectedIndex,
                    onTap: value.navigateBottomBar,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.house), label: 'home'),
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.calendarDays),
                          label: 'plan'),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.run_circle), label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.chartLine),
                          label: 'analysis'),
                      BottomNavigationBarItem(
                          icon: Icon(FontAwesomeIcons.users),
                          label: 'community'),
                    ],
                  ),
                  Positioned(
                    top: -40,
                    left: MediaQuery.of(context).size.width / 2 - 50,
                    child: Transform.rotate(
                      angle:
                          3.141592653589793 * 45 / 180, // Rotates the container
                      child: GestureDetector(
                        onTap: () {
                          // Navigate to PlanPage
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GoogleMapFlutter()),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Transform.rotate(
                              angle: 3.141592653589793 *
                                  -45 /
                                  180, // Adjust icon rotation
                              child: const Icon(
                                FontAwesomeIcons.personRunning,
                                size: 30.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
