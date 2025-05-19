import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek_machine/core/common/global_variables.dart';
import 'package:zartek_machine/features/authentication/screen/login_screen.dart';
import 'package:zartek_machine/features/home/screen/home_screen.dart';
import '../../../core/common/widgets/snack_bar.dart';
import '../repository/auth_repository.dart';

final authControllerProvider =
NotifierProvider<AuthController, bool>(() => AuthController());

class AuthController extends Notifier<bool> {
  @override
  build() {
    // TODO: implement build
    return false;
  }

  AuthRepository get _authRepository => ref.read(authRepositoryProvider);

  /// google sign
  Future<void> signInWithGoogle(
      {required BuildContext context}) async {
    state=true;
    final user = await _authRepository.signInWithGoogle();
    user.fold((l) {
        snackBar(context,"Google Signing Failed!");
        state=false;
    }, (userModel) async {
      final SharedPreferences preferences=await SharedPreferences.getInstance();
           preferences.setString("uid",userModel.id);
           ref.read(userProvider.notifier).update((state) => userModel,);
        snackBar(context,"Google Signing Completed");
          Navigator.push(
              context, CupertinoPageRoute(
              builder: (context) => HomeScreen()));
      state=false;
    });
  }

  /// logOut
  Future<void> logOut({
    required BuildContext context,
  }) async {
    state=true;
    final logout=await _authRepository.logout();
    logout.fold((l) {
      Navigator.pop(context);
      snackBar(context, "logout Failed");
      state=false;
    } , (r) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.remove('uid');
        Navigator.pushAndRemoveUntil(
          context, CupertinoPageRoute(builder: (context) => LoginScreen()),(route) => false,);
        snackBar(context, "Logout Successfully");
        state=false;
    },);
  }
  /// logged user
  getLoggedUser(String id){
    return _authRepository.getLoggedUser(id);
  }
}
