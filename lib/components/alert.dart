import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/sx_button.dart';

class Alert {
  static void show(
    BuildContext context, {
    String title = "",
    String description = "",
    VoidCallback? onSubmit,
    VoidCallback? onCancel,
    bool onlySubmit = false,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          child: Container(
              constraints: BoxConstraints(maxHeight: 500, maxWidth: 500),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title),
                  Row(
                    children: [
                      SxButton(
                        label: "OK",
                      ),
                      SxButton(
                        label: "Cancel",
                      ),
                    ],
                  ),
                ],
              )),
        );
      },
    );
  }
}
