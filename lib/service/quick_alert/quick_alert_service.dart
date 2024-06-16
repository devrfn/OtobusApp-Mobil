import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class QuickAlertService {
  static Future errorAlert(BuildContext context,
      {String? title, String? text}) async {
    await QuickAlert.show(
        context: context, title: title, text: text, type: QuickAlertType.error);
  }

  static Future successAlert(BuildContext context,
      {String? title, String? text}) async {
    await QuickAlert.show(
        context: context,
        title: title,
        text: text,
        type: QuickAlertType.success);
  }
}
