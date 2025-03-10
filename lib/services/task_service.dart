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
      final DocumentReference docRef = await _taskCollection.add(data);

      //Update the Task with Generated Id
      await docRef.update({"id": docRef.id});
      debugPrint("Task Added with ID: ${docRef.id}");
    } catch (error) {
      debugPrint("Error Adding Task: $error");
    }
  }

  //Get all the Tasks from the Firestore Collection
  Stream<List<TaskModel>> getTask() {
    return _taskCollection.snapshots().map(
      (snapshot) =>
          snapshot.docs
              .map(
                (doc) => TaskModel.formJson(
                  doc.data() as Map<String, dynamic>,
                  doc.id,
                ),
              )
              .toList(),
    );
  }

  //Update a Task in the Firestore Collection
  Future<void> updateTask(TaskModel task) async {
    try {
      final Map<String, dynamic> data = task.toJson();

      await _taskCollection.doc(task.id).update(data);
      debugPrint("Updated Successfully!");
    } catch (error) {
      debugPrint("Error Updating Task: $error");
    }
  }

  //Delete a Task from the Firestore Collection
  Future<void> deleteTask(String id) async {
    try {
      await _taskCollection.doc(id).delete();
      debugPrint("Task Deleted");
    } catch (error) {
      debugPrint("Error Deleting a Task: $error");
    }
  }
}
