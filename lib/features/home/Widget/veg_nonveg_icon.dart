import 'package:flutter/material.dart';

import '../../../core/common/global_variables.dart';

class VegNonVegIcon extends StatelessWidget {
  const VegNonVegIcon({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      width: width * (0.05),
      height: height * (0.025),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 1.5),
        shape: BoxShape.rectangle,
      ),
      child: Center(
        child: CircleAvatar(backgroundColor: color, radius: width * (0.015)),
      ),
    );
  }
}
