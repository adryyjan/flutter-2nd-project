import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  String text;
  bool isDone;
  TestWidget({super.key, required this.text, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Row(
        children: [
          Text(text),
          SizedBox(
            width: 20,
          ),
          Text('${isDone}')
        ],
      ),
    );
  }
}
