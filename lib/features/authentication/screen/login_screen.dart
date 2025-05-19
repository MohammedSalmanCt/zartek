import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/core/common/widgets/loader.dart';
import 'package:zartek_machine/core/common/widgets/login_buttons.dart';
import 'package:zartek_machine/core/theme/pallete.dart';
import 'package:zartek_machine/features/authentication/controller/auth_controller.dart';
import 'package:zartek_machine/features/home/screen/home_screen.dart';
import '../../../core/common/global_variables.dart';
import '../../../core/constants/assets_constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
     width=MediaQuery.of(context).size.width;
     height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backGroundColour,
      body:SizedBox(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AssetsConstants.logo,width:width*0.6,
                height: height*0.4,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Consumer(
                  builder: (context,ref,child) {
                    final state=ref.watch(authControllerProvider);
                    return state?Loader()
                        :LoginButtons(buttonColor:AppColors.blueColour, onTap: () {
                    ref.read(authControllerProvider.notifier).signInWithGoogle(context: context);
                    }, heading: "Google", image: AssetsConstants.googleIcon);
                  }
                ),
                SizedBox(height: 10,),
                Consumer(
                  builder: (context,ref,child) {
                    return LoginButtons(buttonColor: AppColors.buttonGreenColour, onTap: () {

                    }, heading: "Phone", image: AssetsConstants.phoneIcon);
                  }
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
