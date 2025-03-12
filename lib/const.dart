import 'package:flutter/material.dart';

double DIALOG_WIDTH(BuildContext context) =>
    MediaQuery.of(context).size.width * 0.8;
double DIALOG_HIGHT(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.6;

double TO_POST_HIGHT(BuildContext context) =>
    MediaQuery.of(context).size.height * 0.5;

final Color? bgColorPrimary = Colors.blueGrey[900];
final Color? bgColorSecoundary = Colors.blueGrey[800];
final Color? bgColorLight = Colors.blueGrey[500];