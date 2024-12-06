class Workout {
  final int steps;
  final double kilometers;
  final double waterVolume;
  final String workoutPhoto;
  final String mood;
  final List<String> routes;
  final int caloriesBurned;
  final double weight;
  final String day;
  final int year;

  Workout({
    required this.steps,
    required this.kilometers,
    required this.waterVolume,
    required this.workoutPhoto,
    required this.mood,
    required this.routes,
    required this.caloriesBurned,
    required this.weight,
    required this.day,
    required this.year,
  });

  // Convert from map (Firestore document)
  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      steps: json['steps'],
      kilometers: json['kilometers'],
      waterVolume: json['waterVolume'],
      workoutPhoto: json['workoutPhoto'],
      mood: json['mood'],
      routes: List<String>.from(json['routes']),
      caloriesBurned: json['caloriesBurned'],
      weight: json['weight'],
      day: json['day'],
      year: json['year'],
    );
  }

  // Convert to map (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'steps': steps,
      'kilometers': kilometers,
      'waterVolume': waterVolume,
      'workoutPhoto': workoutPhoto,
      'mood': mood,
      'routes': routes,
      'caloriesBurned': caloriesBurned,
      'weight': weight,
      'day': day,
      'year': year,
    };
  }
}
