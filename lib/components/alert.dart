import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/sx_button.dart';

class Alert {
  void show(
    BuildContext context, {
    String? title,
    String? desc,
    MainAxisAlignment? descAlignment,
    String? okText,
    String? cancelText,
    VoidCallback? okSubmit,
    VoidCallback? cancelSubmit,
    bool reversed = false,
    bool okOnly = false,
    bool isDesktop = false,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: "",
      barrierDismissible: true,
      pageBuilder: (BuildContext context, Animation _, __) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Container(
              constraints: BoxConstraints(
                maxWidth: isDesktop ? 300 : double.infinity,
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(title ?? "Title",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                  Row(
                    mainAxisAlignment: descAlignment ?? MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(desc ?? "Content"),
                      ),
                    ],
                  ),
                  Row(
                    textDirection:
                        reversed ? TextDirection.rtl : TextDirection.ltr,
                    children: [
                      Visibility(
                        visible: !okOnly,
                        child: Expanded(
                            child: SxButton(
                                shape: SxButtonShape.rounded,
                                backgroundColor: Colors.grey[500],
                                onTap: cancelSubmit ??
                                    () {
                                      Navigator.pop(context);
                                    },
                                child: Text(cancelText ?? "CANCEL"))),
                      ),
                      Visibility(
                        visible: !okOnly,
                        child: const SizedBox(
                          width: 8,
                        ),
                      ),
                      Expanded(
                          child: SxButton(
                              shape: SxButtonShape.rounded,
                              backgroundColor: Colors.red[700],
                              onTap: okSubmit ??
                                  () {
                                    Navigator.pop(context);
                                  },
                              child: Text(okText ?? "OK"))),
                    ],
                  )
                ],
              )),
        );
      },
    );
  }
}
