import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopat_seller/global/colors.dart';
import 'package:shopat_seller/screens/seller_home.dart';
import 'package:shopat_seller/screens/seller_login.dart';

import 'firebase_repository/auth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.primaryColor,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop At Seller',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        accentColor: AppColors.accentColor,
      ),

      debugShowCheckedModeBanner: false,
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [
        BotToastNavigatorObserver()
      ], //2. registered route observer
      //home: SellerLogin(),
      home: AuthService().getUserId() != null ? SellerHome() : SellerLogin(),
    );
  }
}
