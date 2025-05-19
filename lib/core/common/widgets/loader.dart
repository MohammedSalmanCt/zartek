import 'package:flutter/material.dart';
import 'package:zartek_machine/core/theme/pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.blueColour,
      ),
    );
  }
}