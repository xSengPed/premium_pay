import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/sx_button.dart';

class Alert {
  static void show(
    BuildContext context, {
    String title = "",
    String? description,
    String okText = "ตกลง",
    String cancelText = "ยกเลิก",
    VoidCallback? onSubmit,
    Color? submitColor,
    VoidCallback? onCancel,
    bool onlySubmit = false,
  }) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Dialog(
          child: Container(
              constraints: BoxConstraints(maxHeight: 350, maxWidth: 350),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      )),
                  if (description == null)
                    SizedBox(
                      height: 16,
                    )
                  else
                    Text(description),
                  Row(
                    children: [
                      SxButton(
                        height: 40,
                        label: okText,
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        onClick: () {
                          Navigator.pop(context);
                          if (onSubmit != null) {
                            onSubmit();
                          }
                        },
                        backgroundColor: submitColor ?? Colors.green,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      SxButton(
                        height: 40,
                        label: cancelText,
                        onClick: () => onCancel ?? Navigator.pop(context),
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
