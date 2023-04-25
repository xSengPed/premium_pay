import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_yt_app/components/sx_button.dart';

class MiddelwareAlert {
  static void show(BuildContext context, dynamic err) {
    log(err.toString());
    showGeneralDialog(
        context: context,
        pageBuilder: (context, __, ___) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Container(
              constraints: BoxConstraints(maxWidth: 350),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                      alignment: Alignment.center,
                      child: Text(
                        '${err['err_data']['title']}',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Text(
                          "${err['err_data']['desc']}",
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      SxButton(
                        backgroundColor: Color(0xffBD395D),
                        height: 40,
                        label: "ตกลง",
                        labelStyle: TextStyle(color: Colors.white),
                        onClick: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
