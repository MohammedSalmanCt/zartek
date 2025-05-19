import 'package:flutter/material.dart';
import 'package:zartek_machine/core/constants/assets_constants.dart';
import 'package:zartek_machine/core/theme/pallete.dart';

showOrderPlacedPoPup({required BuildContext context,required double width,required double height}){
  return showDialog(context: context, builder: (context) {
    Future.delayed(const Duration(seconds: 4)).whenComplete((){
      Navigator.pop(context);
    });
    return AlertDialog(

      backgroundColor: Colors.white,
      content: SizedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width*0.8,
              height: height*0.2,
              child: Image.asset(AssetsConstants.success),
            ),
            SizedBox(height: height*0.02,),
            Text("Thank You !",style: TextStyle(fontSize: width*0.05,color: AppColors.blackColour,fontWeight: FontWeight.bold),),
            Text("Your Order is Successfully ",style: TextStyle(fontSize: width*0.05,color: AppColors.blackColour,fontWeight: FontWeight.bold),),
            Text("Placed ! ",style: TextStyle(fontSize: width*0.05,color: AppColors.blackColour,fontWeight: FontWeight.bold),),

          ],
        ),
      ),
    );
  },);
}