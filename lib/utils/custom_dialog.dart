import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog {
  static void showDialog({required bool isSuccess, required String message}) {
    if (isSuccess) {
      // Show success SnackBar
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      // Show error dialog using GetX Dialog
      Get.dialog(
        AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }
}
