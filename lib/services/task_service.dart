import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taskly_firebase_app/models/task_model.dart';

class TaskService {
  //Reference to the Firestore Collection
  final CollectionReference _taskCollection = FirebaseFirestore.instance
      .collection("tasks");

  //Add a New Task to Firestore Collection
  Future<void> addTask(String name) async {
    try {
      //Create a New Task with the Name and Current Data
      final task = TaskModel(
        id: "",
        name: name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        isUpdated: false,
      );

      //Covert the Task to a Map
      final Map<String, dynamic> data = task.toJson();

      //Add the Task to the Collection
      await _taskCollection.add(data);

      debugPrint("Task Added");

    } catch (error) {
      debugPrint("Error Adding Task: $error");
    }
  }
}
