import 'package:flutter/material.dart';

class CustomTextSwitch extends StatefulWidget {
  @override
  _CustomTextSwitchState createState() => _CustomTextSwitchState();
}

class _CustomTextSwitchState extends State<CustomTextSwitch> {
  bool _isPrivate = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isPrivate = !_isPrivate;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: 120,
        height: 40,
        decoration: BoxDecoration(
          color: _isPrivate ? Colors.red : Colors.green,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            AnimatedAlign(
              duration: Duration(milliseconds: 300),
              alignment:
                  _isPrivate ? Alignment.centerRight : Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 200),
                  opacity: _isPrivate ? 1.0 : 1.0,
                  child: Text(
                    _isPrivate ? "PRIVATE" : "PUBLIC",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              left: _isPrivate ? 5 : 65,
              right: _isPrivate ? 65 : 5,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: _isPrivate
                      ? Colors.red[900]?.withValues(alpha: 0.9)
                      : Colors.green[900]?.withValues(alpha: 0.9),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
