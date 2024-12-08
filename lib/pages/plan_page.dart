import 'package:flutter/material.dart';

import '../home/components/headings.dart';
import '../home/components/workout_card.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40,),
          Row(
            children: [

              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Center(child: Text("Plan", style: TextStyle(color: Colors.white),),),
              ),

              SizedBox(width: 10,),
              
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Center(child: Text("Course", style: TextStyle(color: Colors.white),),),
              )
            ],),
          SizedBox(height: 20),

          //-----------------------
          Expanded(
            child: ListView(
              children: [
                Heading(headingText: "Treadmill", headingSize: 20),
                SizedBox(
                  height: 200, // Specify height for the horizontal ListView
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      WorkoutCard(imagePath: 'lib/images/workout1.jpg'),
                      WorkoutCard(imagePath: 'lib/images/workout3.jpg'),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Heading(headingText: "Stretching", headingSize: 20),
                SizedBox(
                  height: 200, 
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      WorkoutCard(imagePath: 'lib/images/workout1.jpg'),
                      WorkoutCard(imagePath: 'lib/images/workout3.jpg'),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Heading(headingText: "Lifting weights", headingSize: 20),
                SizedBox(
                  height: 200, 
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      WorkoutCard(imagePath: 'lib/images/workout1.jpg'),
                      WorkoutCard(imagePath: 'lib/images/workout3.jpg'),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      
    );
  }
}

