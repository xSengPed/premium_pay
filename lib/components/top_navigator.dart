import 'package:flutter/material.dart';

class TopNavigator extends StatelessWidget {
  const TopNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: double.infinity,
      height: 70,
      child: Stack(children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'สวัสดี , Donnukrit',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(icon: Icon(Icons.logout), onPressed: () {}),
        ),
      ]),
    );
  }
}
