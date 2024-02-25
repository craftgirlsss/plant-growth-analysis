import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertDialogCustom {
  // This shows a CupertinoModalPopup which hosts a CupertinoAlertDialog.
  static void showAlertDialog(context,
      {Function()? onOK, String? title = "Informasi", String? content}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(content ?? 'Apakah anda yakin keluar'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onOK,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  static void showAlertDialogTextField(context,
      {TextEditingController? diameter,
      TextEditingController? hari,
      TextEditingController? tinggi,
      Function()? onOK,
      String? title = "Informasi",
      String? content}) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: TextField(
          controller: diameter,
        ),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            onPressed: onOK,
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
