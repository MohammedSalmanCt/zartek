import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zartek_machine/model/user_model.dart';
import '../../../../core/failure.dart';
import '../../../../core/providers/firebase_providers.dart';
import '../../../../core/type_def.dart';
import '../../../core/constants/firebase_constants.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(firestrore: ref.watch(fireStoreProvider),
      auth: ref.watch(firebaseAuthProvider),
      googleSign: ref.watch(googleSignInProvider));
});

class AuthRepository{
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn  _googleSignIn;
  AuthRepository({required FirebaseFirestore firestrore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSign})
      :_firestore=firestrore,_auth=auth,
        _googleSignIn=googleSign;
  CollectionReference get _userCollection => _firestore.collection(FirebaseConstants.userConstant);

  /// google sign
  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return left(Failure("User cancelled Google Sign-In."));
      }
      print("1111111111111111111111111111111");
      final googleAuth = await googleUser.authentication;
      print("2222222222222222222222222222");
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      print("33333333333333333333333333333333");
      final userCredential = await _auth.signInWithCredential(credential);
      print("44444444444444444444444444444444444444");
      final user=userCredential.user;
     if(user==null)
       {
         return left(Failure("Google Signing Failed!"));
       }
     else{
       DocumentReference reference=_userCollection.doc(user.uid);
       UserModel userModel=UserModel(name: user.displayName??"", id: user.uid, cart: [],reference: reference, email: user.email??"");
       await reference.set(userModel.toMap());
       return right(userModel);
     }
    } on FirebaseException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return left(Failure(e.code.toString()));
      } else {
        print('Erroreeee: ${e.message}');
      }
      print(e.message);
      return left(Failure(e.message.toString()));
    } catch (e) {
      print(e.toString());
      return left(Failure(e.toString()));
    }
  }


  /// signup in Email
  FutureEither<UserModel> signInWithEmail(
      {required String email,required String password}) async {
    try {
      UserModel? userModel;
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) async {
       userModel=UserModel(name: value.user?.displayName??"",
           email: email, id: value.user!.uid,
           cart: [],
         reference:_userCollection.doc(value.user!.uid,)
       );
        await userModel?.reference?.set(userModel?.toMap());
      },);
        return right(userModel!);
    } on FirebaseException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        print("${e.code}sssssssssss");
        return left(Failure(e.code.toString()));
      } else {
        print('Error: $e');
      }
      print(e.message);
      return left(Failure( e.message!));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  /// sign in with password
  FutureEither<UserModel> signInWithPassword({
    required String email,
    required String password,
  }) async {
    try {
      /// Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final userId = userCredential.user?.uid;
      if (userId == null) {
        return left(Failure('Invalid Email or Password'));
      }
      DocumentSnapshot snapshot = await _userCollection.doc(userId).get();
      if (snapshot.exists) {
        UserModel userModel = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
        await _userCollection.doc(userId).update(userModel.toMap());
        return right(userModel);
      } else {
        return throw "Invalid login credentials";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        print("Invalid login credentials: ${e.message}");
        return left(Failure("Invalid login credentials"));
      } else {
        print('Error: ${e.message}');
        return left(Failure(e.message ?? 'Unknown error occurred.'));
      }
    } catch (e) {
      print("Error: ${e.toString()}");
      return left(Failure(e.toString()));
    }
  }

  /// logout
  FutureVoid logout() async {
    try {
      /// Sign out from Firebase
      print("User signed out from Firebase");
      return right( await _auth.signOut());
    }on FirebaseException catch(error){
      return left(Failure(error.message!));
    }
    catch (e) {
      print("Error during logout: $e");
      return left(Failure(e.toString()));
    }
  }

  /// logged User
  getLoggedUser(String id) async {
    DocumentSnapshot admin = await _userCollection.doc(id).get();
    UserModel userModel = UserModel.fromMap(admin.data() as Map<String,dynamic>);
    return userModel;
  }
}