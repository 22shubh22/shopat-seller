import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopat_seller/firebase_repository/auth.dart';
import 'package:shopat_seller/firebase_repository/src/entities/product_entity.dart';

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

  submitNewProduct({required ProductEntity product}) async {
    try {
      String phoneNumber = AuthService().getPhoneNumber() ?? "";
      var res = await _instance.collection("products").add(
            product.toJson(),
          );
      print(" firestore res: ${res.path}");
      var userData =
          await _instance.collection("sellers").doc(phoneNumber).get();
      List submittedProducts = [];
      if (userData.data()?['productSubmitted'] != null) {
        submittedProducts = userData.data()?['productSubmitted'];
      }

      submittedProducts.add(res.path.substring(15));
      await _instance.collection("sellers").doc(phoneNumber).update(
        {"productSubmitted": submittedProducts},
      );
      BotToast.showText(text: 'Product Submitted');
      return {'res': true, 'message': 'Product Submitted'};
    } catch (e) {
      print(" error while submitting the product: $e");
      BotToast.showText(text: 'Cannot submit the product');
      return {'res': false, 'message': 'Cannot submit the product'};
    }
  }
}
