import 'package:flutter/material.dart';

class NotificationService {
  static final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey(); 

  static showSnackbarError(String message) {

    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(
        message, 
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20
        ),
      )
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }

  static showBusyIndicator(BuildContext context) {
    final AlertDialog dialog = AlertDialog(
      content: Container(
        color: Colors.white,
        width: 100,
        height: 100,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );

    showDialog(context: context, builder: (_) => dialog);
  }
}