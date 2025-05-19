import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/core/common/widgets/loader.dart';
import 'package:zartek_machine/core/common/widgets/login_buttons.dart';
import 'package:zartek_machine/core/common/widgets/snack_bar.dart';
import 'package:zartek_machine/core/theme/pallete.dart';
import 'package:zartek_machine/features/authentication/controller/auth_controller.dart';
import 'package:zartek_machine/features/authentication/screen/sign_up_screen.dart';
import '../../../core/common/global_variables.dart';
import '../../../core/common/widgets/custom_texFormField.dart';
import '../../../core/constants/assets_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
     width=MediaQuery.of(context).size.width;
     height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backGroundColour,
      body:SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          width: width,
          height: height,
          child: Column(
            mainAxisAlignment:MainAxisAlignment.spaceEvenly ,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AssetsConstants.logo,width:width*0.5,
                  height: height*0.3,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextField(
                      controller: emailController, labelText: 'Enter Email'),
                  SizedBox(height: height * 0.02),
                  CustomTextField(
                    controller: passwordController,
                    labelText: 'Password',
                    suffixIcon: Icon(
                      CupertinoIcons.eye,
                      size: width * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: height * 0.012),
                  Consumer(
                    builder: (context,ref,child) {
                     return GestureDetector(
                        onTap: () {
                          final email=emailController.text.trim();
                          final password=passwordController.text.trim();
                          if(email.isEmpty){
                            snackBar(context, "Please enter Email");
                            return;
                          }
                          if(password.isEmpty || password.length<6){
                            snackBar(context, "Please enter correct Password");
                            return;
                          }
                          ref.read(authControllerProvider.notifier).signInWithPassword(context: context, email: email, password: password);
                        },
                        child: Container(
                          width: width*0.85,
                          height: height*0.06,
                          decoration:  BoxDecoration(
                              color: AppColors.buttonGreenColour,
                              borderRadius: BorderRadius.circular(width*0.085)
                          ),
                          child:    Center(
                            child: Text("Login",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColour,
                              fontSize: width*0.05,
                            ),),
                          ),
                        ),
                      );
                    }
                  ),
                  SizedBox(height: 10,),
                  Consumer(
                      builder: (context,ref,child) {
                        final state=ref.watch(authControllerProvider);
                        return state?Loader()
                            :LoginButtons(buttonColor:AppColors.blueColour, onTap: () {
                          ref.read(authControllerProvider.notifier).signInWithGoogle(context: context);
                        }, heading: "Google", image: AssetsConstants.googleIcon);
                      }
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account ?",style: TextStyle(
                        fontWeight: FontWeight.w300,
                        color: AppColors.blackColour,
                        fontSize: width*0.035,
                      ),),
                      TextButton(onPressed: () =>Navigator.push(context, CupertinoPageRoute(builder: (context) => SignInScreen(),)) ,
                          child:  Text("Login",style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColour,
                            fontSize: width*0.035,
                          ),),),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
