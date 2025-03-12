import 'dart:io';

import 'package:flutter/material.dart';
import 'package:to_doy/widgets/custom_switch.dart';

import '../const.dart';

class ImagePreviewScreen extends StatelessWidget {
  bool isPrivate;
  final String imagePath;
  late String description;

  ImagePreviewScreen(
      {super.key, required this.imagePath, required this.isPrivate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColorPrimary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            CustomTextSwitch(),
            Flexible(
              child: Container(
                width: double.infinity,
                height: TO_POST_HIGHT(context),
                padding: EdgeInsets.only(top: 10),
                child: Image.file(
                  File(imagePath),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.redAccent,
                    child: Icon(
                      Icons.cancel_outlined,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    print('OK');
                    print(description);
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.green,
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.black,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                      counterStyle: TextStyle(color: Colors.white)),
                  style: TextStyle(color: Colors.white),
                  maxLength: 170,
                  maxLines: 10,
                  autofocus: false,
                  cursorColor: Colors.blueAccent,
                  textAlign: TextAlign.start,
                  onChanged: (newVal) {
                    description = newVal;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
