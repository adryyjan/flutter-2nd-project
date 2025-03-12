import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String text;
  final bool isSwitched;
  final ValueChanged switchStatus;
  final GestureLongPressCallback longPress;
  const ListItem({
    required this.text,
    required this.isSwitched,
    required this.switchStatus,
    required this.longPress,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: longPress,
      trailing: Switch(
        activeColor: Colors.green,
        inactiveTrackColor: Colors.black,
        value: isSwitched,
        onChanged: switchStatus,
      ),
      title: Text(
        text,
        style: isSwitched
            ? TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
    );
  }
}
