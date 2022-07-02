import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posts/core/utils/app_colors.dart';
import 'package:posts/features/posts/presentation/widgets/delete_dialog_widget.dart';

class Constants {
  static void showErrorDialog({
    required BuildContext context,
    required String msg,
  }) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(msg),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ));
  }

  static void showToast({
    required String msg,
    Color? clr,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      msg: msg,
      backgroundColor: clr ?? AppColors.primaryColor,
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }

  static void showDeleteDialog({
    required BuildContext context,
    required String msg,
    int? postId,
  }) {
    showDialog(
        context: context,
        builder: (context) =>  DeleteDialogWidget(postId: postId,msg:msg ,)
            );
  }
}
