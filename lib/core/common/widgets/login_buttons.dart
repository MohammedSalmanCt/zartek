import 'package:flutter/material.dart';
import 'package:zartek_machine/core/theme/pallete.dart';
import '../global_variables.dart';

class LoginButtons extends StatelessWidget {
  const LoginButtons({
    super.key,
    required this.buttonColor,
    required this.onTap,
    required this.heading,
    required this.image,
  });
  final void Function()? onTap;
  final String image;
  final String heading;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: width*0.85,
        height: height*0.06,
        decoration:  BoxDecoration(
          color: buttonColor,
            borderRadius: BorderRadius.circular(width*0.085)
        ),
        child: Row(
          children: [
            SizedBox(width: 10,),
            Image.asset(image,height: 35,width: width*(0.18),),
            SizedBox(width:width*(0.13),),
            Text(heading,style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColour,
              fontSize: width*0.05,
            ),),
          ],
        ),
      ),
    );
  }
}
