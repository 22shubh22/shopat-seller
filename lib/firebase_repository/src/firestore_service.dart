import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shopat_seller/firebase_repository/auth.dart';
import 'package:shopat_seller/firebase_repository/src/entities/order_request_entity.dart';
import 'package:shopat_seller/firebase_repository/src/entities/product_entity.dart';
import 'package:path/path.dart';

class FirestoreService {
  //firestore instance to user multiple times.
  FirebaseFirestore _instance = FirebaseFirestore.instance;
  FirebaseStorage _storage = FirebaseStorage.instance;

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

  submitNewProduct({
    required ProductEntity product,
  }) async {
    try {
      var res = await _instance.collection("products").add(
            product.toJson(),
          );
      print(" firestore res: ${res.path}");

      try {
        await _instance
            .collection("products")
            .doc(res.path.substring(9))
            .update(
          {"id": "${res.path.substring(9)}"},
        );
      } catch (e) {
        print(" id update error: $e");
      }
      BotToast.showText(text: 'Product Submitted');
      return {'res': true, 'message': 'Product Submitted'};
    } catch (e) {
      print(" error while submitting the product: $e");
      BotToast.showText(text: 'Cannot submit the product');
      return {'res': false, 'message': 'Cannot submit the product'};
    }
  }

  editProduct({
    required ProductEntity product,
  }) async {
    try {
      await _instance
          .collection("products")
          .doc(product.id)
          .update(product.toJson());

      BotToast.showText(text: 'Product Updated');
      return {'res': true, 'message': 'Product Updated'};
    } catch (e) {
      print(" error while Updating the product: $e");
      BotToast.showText(text: 'Cannot update the product');
      return {'res': false, 'message': 'Cannot update the product'};
    }
  }

  Future<String> uploadImage({
    required File file,
  }) async {
    try {
      String fileName = basename(file.path);
      Reference reference = _storage.ref().child("productImages/$fileName");
      UploadTask uploadTask = reference.putFile(file);
      String imageUrl =
          await uploadTask.then((res) async => res.ref.getDownloadURL());
      print(imageUrl);
      return imageUrl;
    } catch (e) {
      return "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80";
    }
  }

  Future<List<ProductEntity>> getYourSubmissions() async {
    String uid = AuthService().getUserId() ?? "";
    List<ProductEntity> productsList = [];
    var products = await _instance.collection('products').get();

    for (var i in products.docs) {
      var data = i.data();
      if (i['shopId'] == uid) {
        productsList.add(ProductEntity.fromJson(data));
      }
    }
    return productsList;
  }

  Future<List<OrderReuestEntity>> getProductsRequest() async {
    String phoneNumber = AuthService().getPhoneNumber() ?? "";
    var productsReqData =
        await _instance.collection('sellers').doc(phoneNumber).get();
    List productsRequested = productsReqData.data()?['productsRequested'];
    List<OrderReuestEntity> orderRequests = [];
    for (var i in productsRequested) {
      orderRequests.add(OrderReuestEntity.fromJson(i));
    }
    return orderRequests;
  }
}
