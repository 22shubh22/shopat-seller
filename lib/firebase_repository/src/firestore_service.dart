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
        'address': "",
        'name': "",
        'productSubmitted': [],
        'productsRequested': []
      });
    } else {
      print(
          "User with phone number $phoneNumber already exists. Just logging in");
    }
  }
}
