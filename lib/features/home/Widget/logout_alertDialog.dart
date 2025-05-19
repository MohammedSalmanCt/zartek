import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/features/authentication/controller/auth_controller.dart';

void logoutAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          Consumer(
            builder: (context, ref, child) {
              return TextButton(
                onPressed: () async {
                  ref
                      .read(authControllerProvider.notifier)
                      .logOut(context: context);
                },
                child: const Text('Logout'),
              );
            },
          ),
        ],
      );
    },
  );
}
