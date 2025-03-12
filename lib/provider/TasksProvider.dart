import 'package:flutter/material.dart';

import '../modules/task.dart';

class TasksProvider extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get allTasks => _tasks;
  int get taskCount => allTasks.length;

  void addTask(String taskName) {
    _tasks.add(Task(name: taskName));
    notifyListeners();
  }

  void addTasks(List<Task> lista) {
    _tasks.addAll(lista);
    notifyListeners();
  }

  void toggleTaskStatus(int index) {
    _tasks[index].toogleDone();

    notifyListeners();
  }

  void sortTasks() {
    if (_tasks.isNotEmpty) {
      _tasks.sort(
        (a, b) {
          return b.isDone.toString().compareTo(a.isDone.toString());
        },
      );
    }
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
