import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String name;
  DateTime createdAt;
  DateTime updatedAt;
  bool isUpdated;

  TaskModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.isUpdated,
  });

  //Convert the Firebase Documnet into a Task Object
  factory TaskModel.formJson(Map<String, dynamic> document, String id) {
    return TaskModel(
      id: id,
      name: document["name"],
      createdAt: (document["createdAt"] as Timestamp).toDate(),
      updatedAt: (document["updatedAt"] as Timestamp).toDate(),
      isUpdated: document["isUpdated"],
    );
  }

  //Convert the Task Object into a Firebase Doc
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "isUpdated": isUpdated,
    };
  }
}
