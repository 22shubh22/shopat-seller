import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopat_seller/firebase_repository/auth.dart';

class FirestoreService {
  //firestore instance to user multiple times.
  FirebaseFirestore _instance = FirebaseFirestore.instance;

  getUserByPhone(String phoneNumber, String? uid) async {
    var s = await _instance.collection('sellers').doc(phoneNumber).get();
    if (s.data() == null) {
      print("User with phone number $phoneNumber not exists. Signing him up");
      await _instance.collection('sellers').doc(phoneNumber).set({
        'sellerNumber': phoneNumber,
        'uid': uid,
        'shopAddress': "",
        'shopName': "",
        'name': "",
        'productSubmitted': [],
        'productsRequested': []
      });
    } else {
      print(
          "User with phone number $phoneNumber already exists. Just logging in");
    }
  }

  getProfileDetails() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var data = await _instance.collection('sellers').doc(phoneNumber).get();
    String name = data.data()?['name'];
    String sellerNumber = data.data()?['sellerNumber'];
    String shopName = data.data()?['shopName'];
    String shopAddress = data.data()?['shopAddress'];
    return {
      'name': name,
      'sellerNumber': sellerNumber,
      'shopName': shopName,
      'shopAddress': shopAddress,
    };
  }

  updateProfileDetails({
    required String name,
    required String shopName,
    required String shopAddress,
  }) async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    try {
      await _instance.collection('sellers').doc(phoneNumber).update({
        'name': name,
        'shopName': shopName,
        'shopAddress': shopAddress,
      });
      print("Profile details updated");

      BotToast.showText(text: "Profile details updated");
    } catch (e) {
      print("error while updating profile : $e");

      BotToast.showText(text: "Cannot update your details");
    }
  }
}