import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/core/theme/pallete.dart';
import '../../../core/common/global_variables.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget ({super.key});

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Consumer(builder:
        (context, ref, child) {
          final user=ref.watch(userProvider);
          return Container(
            width: width,
            height: height*(0.3),
            decoration: BoxDecoration(
                color: AppColors.buttonGreenColour,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)
                )
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: width*(0.1),
                  backgroundColor: AppColors.blueColour,
                  child: Icon(Icons.person,color: AppColors.whiteColour,size: width*(0.08),),
                ),
                SizedBox(height: 5,),
                SizedBox(
                  width: width*(0.9),
                  child: Center(child: Text(user?.name??"User",style: TextStyle(color: AppColors.blackColour,fontSize: width*(0.05),fontWeight: FontWeight.w400),)),
                ),
                SizedBox(
                  width: width*(0.9),
                  child: Center(child: Text(user?.id??"123",style: TextStyle(color: AppColors.blackColour,fontSize: width*(0.04),fontWeight: FontWeight.w400),)),
                ),
              ],
            ),
          );
        },),
        SizedBox(height: 10,),
        Consumer(
          builder: (context,ref,child) {
            return ListTile(
              onTap: () {

              },
              leading: Icon(Icons.logout,color: AppColors.appBarIconColour,size: width*(0.07),),
              title: Text("Log out",style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*(0.045),color: AppColors.appBarIconColour),),
            );
          }
        )
      ],
    );
  }
}
