// import 'dart:ffi';
// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class SellerEntity {
  final String number;
  final String name;
  final String defaultAddress;
  final List productsSubmitted;
  final List productsRequested;

  SellerEntity(
    this.number,
    this.name,
    this.defaultAddress,
    this.productsSubmitted,
    this.productsRequested,
  );

  Map<String, Object> toJson() {
    return {
      "number": number,
      "name": name,
      "defaultAddress": defaultAddress,
      "productsSubmitted": productsSubmitted,
      "productsRequested": productsRequested,
    };
  }

  static SellerEntity fromJson(Map<String, Object> json) {
    return SellerEntity(
      json["number"] as String,
      json["name"] as String,
      json["defaultAddress"] as String,
      json["productsSubmitted"] as List,
      json["productsRequested"] as List,
    );
  }

  static SellerEntity fromSnapshot(DocumentSnapshot snap) {
    return SellerEntity(
      (snap.data() as dynamic)['number'],
      (snap.data() as dynamic)['name'],
      (snap.data() as dynamic)['defaultAddress'],
      (snap.data() as dynamic)['productSubmitted'],
      (snap.data() as dynamic)['productsRequested'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "number": number,
      "name": name,
      "defaultAddress": defaultAddress,
      "productsSubmitted": productsSubmitted,
      "productsRequested": productsRequested,
    };
  }
}
