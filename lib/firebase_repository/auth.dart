import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopat_seller/screens/seller_home.dart';
import 'package:shopat_seller/screens/seller_login.dart';

class AuthService {
  final _instance = FirebaseAuth.instance;

  handleAuth() {
    return StreamBuilder(
      stream: _instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return SellerHome();
        } else {
          return SellerLogin();
        }
      },
    );
  }

  isUserLoggedIn() async {
    print(" instance user: ${_instance.currentUser}");
  }

  String? getUserId() {
    print(_instance.currentUser);
    print(_instance.currentUser?.phoneNumber.toString());
    return _instance.currentUser?.uid;
  }

   String? getPhoneNumber() {
    print(_instance.currentUser);
    print(_instance.currentUser?.phoneNumber.toString());
    return _instance.currentUser?.phoneNumber;
  }

  signOut() {
    _instance.signOut();
  }

  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds =
        PhoneAuthProvider.credential(verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  signIn(AuthCredential authCreds) {
    _instance.signInWithCredential(authCreds);
  }
}