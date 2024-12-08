import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

class DatabaseHelper {
  static const _databaseName = 'workouts.db';
  static const _databaseVersion = 1;

  static const table = 'workouts';
  static const columnId = 'id';
  static const columnUserEmail = 'userEmail';
  static const columnWorkoutName = 'workoutName';
  static const columnCaloriesBurned = 'caloriesBurned';
  static const columnDate = 'date';
  static const columnDistance = 'distance';
  static const columnMood = 'mood';
  static const columnSteps = 'steps';
  static const columnWaterIntake = 'waterIntake';

  // Singleton pattern
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database reference
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // Create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnUserEmail TEXT,
            $columnWorkoutName TEXT,
            $columnCaloriesBurned INTEGER,
            $columnDate TEXT,
            $columnDistance REAL,
            $columnMood TEXT,
            $columnSteps INTEGER,
            $columnWaterIntake INTEGER
          )
          ''');
  }

  // Insert a new workout into the database
  Future<int> insertWorkout(Map<String, dynamic> workout) async {
    Database db = await instance.database;
    return await db.insert(table, workout);
  }

  // Retrieve all workouts
  Future<List<Map<String, dynamic>>> getWorkouts() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // Update a workout (if needed)
  Future<int> updateWorkout(Map<String, dynamic> workout) async {
    Database db = await instance.database;
    int id = workout[columnId];
    return await db.update(table, workout, where: '$columnId = ?', whereArgs: [id]);
  }

  // Delete a workout
  Future<int> deleteWorkout(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
