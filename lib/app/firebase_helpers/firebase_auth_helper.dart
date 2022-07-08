import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:ussage_app/constants/exports.dart';

typedef UserAuthStatus = void Function({required bool loggedIn});

class FirebaseAuthHelper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        // if (userCredential.user!.emailVerified) {
        //   return true;
        // } else {
        //   await signOut();
        //   Get.snackbar("Message", "Verify email to login into the app!",
        //       colorText: ColorManager.red);
        //   return false;
        // }
        return userCredential.user!.uid;
      }
    } on FirebaseAuthException catch (exception) {
      _controlException(exception);
    } catch (exception) {
      log("Exception : $exception");
    }
    return null;
  }

  Future<String?> createAccount(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (exception) {
      _controlException(exception);
    } catch (exception) {
      log("Exception : $exception");
    }
    return null;
  }

  bool loggedIn() => (_firebaseAuth.currentUser != null);

  // or instead of using .currentUser above :
  StreamSubscription<User?> checkUserStatus(UserAuthStatus userAuthStatus) {
    return _firebaseAuth.authStateChanges().listen((event) {
      userAuthStatus(loggedIn: (event != null));
    });
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void _controlException(FirebaseAuthException exception) {
    log(exception.message.toString());
    Get.showSnackbar(GetSnackBar(
      message: exception.message ?? "Error!",
      duration: const Duration(seconds: 2),
    ));
    switch (exception.code) {
      case "invalid-email":
        break;
      case "user-disabled":
        break;
      case "user-not-found":
        break;
      case "wrong-password":
        break;
    }
  }
}
