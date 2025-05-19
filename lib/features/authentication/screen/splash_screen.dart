import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek_machine/core/common/global_variables.dart';
import 'package:zartek_machine/core/constants/assets_constants.dart';
import 'package:zartek_machine/features/authentication/controller/auth_controller.dart';
import '../../../model/user_model.dart';
import '../../home/screen/home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends ConsumerState<SplashScreen> {
  /// keep login check
  getLocalStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.containsKey('uid')) {
      String? id =pref.getString('uid');
      UserModel userModel = await ref.watch(authControllerProvider.notifier).getLoggedUser(id??'');
      ref.read(userProvider.notifier).update((state) => userModel,);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(),), (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
    }
  }



  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2),(){
        getLocalStatus();
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Image.asset(AssetsConstants.splashImage),
        ),
      ),
    );
  }
}
