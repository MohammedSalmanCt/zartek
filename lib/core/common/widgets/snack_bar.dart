import 'package:flutter/material.dart';
import 'package:zartek_machine/core/theme/pallete.dart';

snackBar(BuildContext context, String message) {
  final w = MediaQuery.of(context).size.width;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        content: Center(
          child: Center(
            child: Text(
              message,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.whiteColour,
                fontFamily: 'Urbanist',
              ),
            ),
          ),
        ),
        backgroundColor: AppColors.blueColour,
        elevation: 30,
      ),
    );
}
