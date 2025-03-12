import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_doy/modules/camera.dart';

import '../const.dart';
import '../provider/TasksProvider.dart';
import '../services/TaskGetter.dart';
import 'add_task_screen.dart';

class TaskScreen extends StatelessWidget {
  static final id = 'task';

  void showMessageBox(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context), // Zamknięcie okna dialogowego
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void showCameraDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return CameraScreen();
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(opacity: anim1, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = context.watch<TasksProvider>();

    return Scaffold(
      backgroundColor: bgColorPrimary,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: AddTaskScreen(
                  isAutofocusOn: true,
                  addTaskCallback: (value) {
                    if (value.isNotEmpty) {
                      tasksProvider.addTask(value);
                      Navigator.pop(context);
                    } else {
                      showMessageBox(
                          context, "Błąd", "Nie można dodać pustego zadania!");
                    }
                  },
                ),
              ),
            ),
          );
        },
        backgroundColor: Colors.lightBlueAccent,
        elevation: 20,
        splashColor: Colors.blueAccent,
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 60,
                bottom: 30,
                left: 30,
                right: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: bgColorSecoundary,
                        radius: 40,
                        child: Icon(
                          Icons.list,
                          size: 50.0,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: bgColorSecoundary,
                        radius: 40,
                        child: TextButton(
                          onPressed: () => showCameraDialog(context),
                          child: Icon(
                            Icons.camera,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Todoy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 3.0,
                    ),
                  ),
                  Text(
                    "${tasksProvider.taskCount} zadań",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: bgColorSecoundary,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0), child: TaskStream()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
