import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/TasksProvider.dart';
import 'list_item.dart';

class ChoresList extends StatelessWidget {
  const ChoresList({super.key});

  @override
  Widget build(BuildContext context) {
    final tasksProvider = context.watch<TasksProvider>();
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListItem(
          text: tasksProvider.allTasks[index].name,
          isSwitched: tasksProvider.allTasks[index].isDone,
          switchStatus: (value) {
            tasksProvider.toggleTaskStatus(index);
            tasksProvider.sortTasks();
          },
          longPress: () {
            tasksProvider.removeTask(index);
          },
        );
      },
      itemCount: tasksProvider.taskCount,
    );
  }
}
