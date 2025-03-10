import 'package:flutter/material.dart';
import 'package:taskly_firebase_app/services/task_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  //Show Dialog Box
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Add a New Task",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: TextField(
            style: TextStyle(color: Colors.black87),
            controller: _taskController,
            decoration: InputDecoration(
              fillColor: Colors.blueAccent.shade100,
              filled: true,
              hintText: "Enter Here",
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent.shade200,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.blueAccent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.blueAccent, width: 2),
              ),
            ),
          ),
          actions: [
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: Text("Cancel"),
              icon: Icon(Icons.cancel),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),
              ),
              onPressed: () async {
                await TaskService().addTask(_taskController.text);
                _taskController.clear();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              label: Text("Save"),
              icon: Icon(Icons.task),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }
}
