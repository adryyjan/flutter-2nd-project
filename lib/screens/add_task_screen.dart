import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddTaskScreen extends StatelessWidget {
  final Function addTaskCallback;

  String newTask = "";
  AddTaskScreen(
      {super.key, required this.addTaskCallback, required this.isAutofocusOn});
  bool isAutofocusOn;

  void addTask(String title, String subtitle, bool isDone) {
    FirebaseFirestore.instance.collection('tasks').add({
      'Title': title,
      'Subtitle': subtitle,
      'isDone':
          isDone, // 🔹 WAŻNE: Upewnij się, że używasz poprawnej nazwy pola!
      'createdAt': FieldValue.serverTimestamp(), // (Opcjonalnie) Znacznik czasu
    }).then((docRef) {
      print("Dodano zadanie o ID: ${docRef.id}");
    }).catchError((error) {
      print("Błąd dodawania dokumentu: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: bgColorLight,
      padding: EdgeInsets.only(top: 20, left: 40, right: 40),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add Task',
                style: TextStyle(fontSize: 30, color: Colors.lightBlueAccent),
              ),
              CircleAvatar(
                backgroundColor: Colors.black,
                radius: 30,
                child: TextButton(
                    onPressed: () {
                      addTask(newTask, 'test', false);
                      Navigator.pop(context);
                      // addTaskCallback(newTask);
                    },
                    child: Icon(Icons.add)),
              ),
            ],
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              maxLength: 170,
              maxLines: 10,
              autofocus: isAutofocusOn,
              cursorColor: Colors.blueAccent,
              textAlign: TextAlign.center,
              onChanged: (input) {
                newTask = input;
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
