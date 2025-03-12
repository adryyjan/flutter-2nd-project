import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_doy/widgets/test.dart';

import '../provider/TasksProvider.dart';

class TaskStream extends StatelessWidget {
  TaskStream({super.key});

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final tasksProvider = context.watch<TasksProvider>();
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final tasks = snapshot.data!.docs.reversed;
          List<TestWidget> tasksList = [];
          for (var tsk in tasks) {
            Map<String, dynamic> tasksData = tsk.data() as Map<String, dynamic>;
            final taskTitle = tasksData['Title'];
            final taskSubtitle = tasksData['Subtitle'];
            final taskDone = tasksData['isDone'];
            print(taskTitle);
            tasksList.add(TestWidget(
              text: taskTitle,
              isDone: taskDone,
            ));
          }
          print(tasksList.length);
          return ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: tasksList,
          );
        });
  }
}

//
// class MessageStream extends StatelessWidget {
//   final User loggedInUser;
//   MessageStream({
//     super.key,
//     required this.loggedInUser,
//   });
//   final _firestore = FirebaseFirestore.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//         stream: _firestore
//             .collection('messages')
//             .orderBy('timestamp', descending: false)
//             .snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(
//                 backgroundColor: Colors.lightBlueAccent,
//               ),
//             );
//           }
//           final messages = snapshot.data!.docs.reversed;
//           List<MessageField> messageBubble = [];
//           for (var message in messages) {
//             Map<String, dynamic> messageData =
//             message.data() as Map<String, dynamic>;
//             final messageText = messageData['text'];
//             final messageUser = messageData['sender'];
//
//             messageBubble.add(
//               MessageField(
//                 sender: messageUser,
//                 text: messageText,
//                 isMe: loggedInUser.email == messageUser,
//               ),
//             );
//           }
//           return Expanded(
//             child: ListView(
//               reverse: true,
//               padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//               children: messageBubble,
//             ),
//           );
//         });
//   }
// }
