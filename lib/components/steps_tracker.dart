import 'package:pedometer/pedometer.dart';

import '../home/models/home_page_provider.dart';

class StepsTracker {
  late Stream<StepCount> _stepCountStream;
  int _currentSteps = 0;

  void initialize(HomePageProvider provider) {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((StepCount stepCount) {
      _currentSteps = stepCount.steps;

      // Update Firestore with new step count
      provider.updateSteps(_currentSteps);
    }).onError((error) {
      print('Error in step tracking: $error');
    });
  }
}
