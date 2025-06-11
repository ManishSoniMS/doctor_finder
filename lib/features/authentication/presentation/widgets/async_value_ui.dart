import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUi on AsyncValue {
  void showAlertDialogOnError(BuildContext context) {
    if (!isLoading && hasError) {
      if (!(ModalRoute.of(context)?.isCurrent ?? true)) {
        return; // Don't show dialog if the route is not current
      }

      log('\n\n AsyncValueUi.showAlertDialogOnError: $error \n\n');

      final message = _errorMessage(error);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          icon: Icon(Icons.error, color: Color(0xFF680c07)),
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }
}

String _errorMessage(Object? error) {
  String? message;
  if (error is SocketException) {
    message = error.message;
  } else if (error is FirebaseAuthException) {
    message = error.message;
  } else if (error is FirebaseException) {
    message = error.message;
  }
  return message ?? "Something went wrong.";
}
