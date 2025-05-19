import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:zartek_machine/model/category_model.dart';
import 'package:zartek_machine/model/dishes_model.dart';
import 'package:zartek_machine/model/user_model.dart';
import '../../../../core/failure.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../../core/type_def.dart';
import '../../../core/constants/firebase_constants.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(
    firestrore: ref.watch(fireStoreProvider),
    auth: ref.watch(firebaseAuthProvider),
    googleSign: ref.watch(googleSignInProvider),
  );
});

class HomeRepository {
  final FirebaseFirestore _firestore;
  HomeRepository({
    required FirebaseFirestore firestrore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSign,
  }) : _firestore = firestrore;
  CollectionReference get _userCollection =>
      _firestore.collection(FirebaseConstants.userConstant);

  Future<List<CategoryModel>> fetchCategoriesAndDishes() async {
    List<CategoryModel> categoryList = [];
    final url = 'https://faheemkodi.github.io/mock-menu-api/menu.json';
    final uri = Uri.parse(url);
    print("uri$uri");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = response.body;
      Map json = jsonDecode(body);
      final result = json['categories'] as List;
      for (Map<String, dynamic> i in result) {
        categoryList.add(CategoryModel.fromMap(i));
      }
      return categoryList;
    } else {
      return [];
    }
  }

  FutureEither<UserModel> updateCartWithDish({
    required DishesModel dish,
    required UserModel user,
    required bool isIncrement,
  }) async {
    try {
      List<DishesModel> updatedCart = List.from(user.cart);
      int existingIndex = updatedCart.indexWhere((item) => item.id == dish.id);

      if (existingIndex != -1) {
        final existingDish = updatedCart[existingIndex];
        int updatedQty =
            isIncrement ? existingDish.qty + 1 : existingDish.qty - 1;

        if (updatedQty > 0) {
          updatedCart[existingIndex] = existingDish.copyWith(qty: updatedQty);
        } else {
          print("existing");
          updatedCart.removeAt(existingIndex);
        }
      } else if (isIncrement) {
        updatedCart.add(dish.copyWith(qty: 1));
      }
      UserModel updatedUserModel = user.copyWith(cart: updatedCart);
      await user.reference!.update(updatedUserModel.toMap());
      return right(updatedUserModel);
    } on FirebaseException catch (e) {
      print('Firebase Error: ${e.message}');
      return left(Failure(e.message.toString()));
    } catch (e) {
      print('Unknown Error: ${e.toString()}');
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> clearCart({required UserModel user}) async {
    try {
      UserModel updatedUserModel = user.copyWith(cart: []);
      await user.reference!.update(updatedUserModel.toMap());
      return right(updatedUserModel);
    } on FirebaseException catch (e) {
      print('Firebase Error: ${e.message}');
      return left(Failure(e.message.toString()));
    } catch (e) {
      print('Unknown Error: ${e.toString()}');
      return left(Failure(e.toString()));
    }
  }

  Future<UserModel> getUserData(UserModel model) async {
    DocumentSnapshot snap = await _userCollection.doc(model.id).get();
    return UserModel.fromMap(snap.data() as Map<String, dynamic>);
  }
}
