import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zartek_machine/core/common/global_variables.dart';
import 'package:zartek_machine/features/authentication/screen/login_screen.dart';
import 'package:zartek_machine/features/home/repository/home_repository.dart';
import 'package:zartek_machine/features/home/screen/home_screen.dart';
import 'package:zartek_machine/model/category_model.dart';
import 'package:zartek_machine/model/dishes_model.dart';
import 'package:zartek_machine/model/user_model.dart';
import '../../../core/common/widgets/snack_bar.dart';

final homeControllerProvider =
NotifierProvider<HomeController, bool>(() => HomeController());

final fetchCategoryAndDishesProvider = FutureProvider.autoDispose((ref)  {
  return ref.watch(homeControllerProvider.notifier).fetchCategoriesAndDishes();
});
class HomeController extends Notifier<bool> {
  @override
  build() {
    // TODO: implement build
    return false;
  }

  HomeRepository get _homeRepository => ref.read(homeRepositoryProvider);

  Future<List<CategoryModel>> fetchCategoriesAndDishes() async {
   return await  _homeRepository.fetchCategoriesAndDishes();
  }
  /// cartUpdating
  Future<void> updateCartWithDish(
      {required BuildContext context,
      required DishesModel dish,
      required bool isIncrement,
      required UserModel user}) async {
    state=true;
    final cart = await _homeRepository.updateCartWithDish(dish: dish, user: user, isIncrement: isIncrement);
    cart.fold((l) {
      snackBar(context,"cart updating failed");
      state=false;
    }, (r) async {
      ref.read(userProvider.notifier).update((state) => r,);
      state=false;
    });
  }

  /// cart clear
  Future<void> clearCart(
      {required BuildContext context,
      required UserModel user}) async {
    state=true;
    final cart = await _homeRepository.clearCart(user: user,);
    cart.fold((l) {
      state=false;
    }, (r) async {
      ref.read(userProvider.notifier).update((state) => r,);
      state=false;
    });
  }
  Future<UserModel> getUserData(UserModel model) async {
   return await _homeRepository.getUserData(model);
  }
}
