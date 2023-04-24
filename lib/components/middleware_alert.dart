import 'package:flutter/material.dart';

class MiddelwareAlert {
  static void show(BuildContext context, dynamic err) {
    showGeneralDialog(
        context: context,
        pageBuilder: (context, __, ___) {
          return AlertDialog(
            title: Text(""),
          );
        });
  }
}
