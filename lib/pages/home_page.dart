import 'package:flutter/material.dart';
import 'package:taskly_firebase_app/models/task_model.dart';
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
              fillColor: Colors.greenAccent.shade100,
              filled: true,
              hintText: "Enter Here",
              hintStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                // ignore: deprecated_member_use
                color: Colors.grey.withOpacity(0.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.greenAccent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide(color: Colors.greenAccent, width: 2),
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
              label: Text("Cancel", style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.cancel, color: Colors.white),
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.green),
              ),
              onPressed: () async {
                if (_taskController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Task Field cannot be Empty!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  return;
                }
                await TaskService().addTask(_taskController.text);
                _taskController.clear();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Task Added Successfully!"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              label: Text("Save", style: TextStyle(color: Colors.white)),
              icon: Icon(Icons.task, color: Colors.white),
            ),
          ],
        );
      },
    );
  }

  //Open a Bottom Sheet for Edit Task
  void _editTaskBottomSheet(TaskModel task) {
    _taskController.text = task.name;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              children: [
                TextField(
                  style: TextStyle(color: Colors.black87),
                  controller: _taskController,
                  decoration: InputDecoration(
                    fillColor: Colors.greenAccent.shade100,
                    filled: true,
                    hintText: "Enter Here",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent.shade200,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide(
                        color: Colors.greenAccent,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.green),
                  ),
                  onPressed: () async {
                    if (_taskController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Task Field cannot be Empty!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.of(context).pop();
                      return;
                    }
                    task.name = _taskController.text;
                    task.updatedAt = DateTime.now();
                    task.isUpdated = true;

                    await TaskService().updateTask(task);
                    _taskController.clear();

                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Task Updated Successfully!"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                  label: Text(
                    "Update Task",
                    style: TextStyle(color: Colors.white),
                  ),
                  icon: Icon(Icons.update, color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.task, size: 55, color: Colors.green),
        title: Text(
          "Taskly Firebase App",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: StreamBuilder(
          stream: TaskService().getTask(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(color: Colors.blueAccent);
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error Loading Tasks!",
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "Not Task Available!, Add Some Tasks",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              );
            } else {
              final List<TaskModel> tasks = snapshot.data!;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final TaskModel task = tasks[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 180, 255, 170),
                          const Color.fromARGB(255, 251, 255, 188),
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: ListTile(
                      onTap: () {
                        _editTaskBottomSheet(task);
                      },
                      title: Text(
                        task.name,
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text(
                            "Created: ${task.createdAt}",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                          Text(
                            "Updated: ${task.updatedAt}",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          TaskService().deleteTask(task.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Task Deleted Successfully!"),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                        icon: Icon(Icons.delete, size: 40, color: Colors.red),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add, size: 35, color: Colors.white),
      ),
    );
  }
}
