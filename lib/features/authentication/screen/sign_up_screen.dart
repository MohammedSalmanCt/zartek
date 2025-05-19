import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zartek_machine/core/common/global_variables.dart';
import 'package:zartek_machine/core/common/widgets/loader.dart';
import 'package:zartek_machine/core/theme/pallete.dart';
import '../../../core/common/widgets/custom_texFormField.dart';
import '../../../core/common/widgets/snack_bar.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     width = MediaQuery.of(context).size.width;
     height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.backGroundColour,
      appBar: AppBar(
        backgroundColor: AppColors.backGroundColour,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            CupertinoIcons.arrow_left,
            size: width * 0.06,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),
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
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer(
          builder: (context,ref,child) {
            final state=ref.watch(authControllerProvider);
            return state?Loader():GestureDetector(
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
                 ref.read(authControllerProvider.notifier).signInWithEmail(context: context, email: email, password: password);
              },
              child: Container(
                width: width*0.85,
                height: height*0.06,
                decoration:  BoxDecoration(
                    color: AppColors.blueColour,
                    borderRadius: BorderRadius.circular(width*0.085)
                ),
                child:    Center(
                  child: Text("SignUp",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.whiteColour,
                    fontSize: width*0.05,
                  ),),
                ),
              ),
            );
          }
      ),
    );
  }
}
