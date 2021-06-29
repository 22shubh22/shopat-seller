// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: isApproved field in product wntity and model
class ProductEntity {
  final String id;
  final String productName;
  final String shopId;
  final String description1;
  final String description2;
  final String image;
  final int costPrice;
  final int sellingPrice;
  final int quantityAvailable;
  final String shopNumber;
  final List tags;

  ProductEntity(
    this.id,
    this.productName,
    this.shopId,
    this.description1,
    this.description2,
    this.image,
    this.costPrice,
    this.sellingPrice,
    this.quantityAvailable,
    this.tags,
    this.shopNumber,
  );

  Map<String, Object> toJson() {
    return {
      "id": id,
      "productName": productName,
      "shopId": shopId,
      "description1": description1,
      "description2": description2,
      "image": image,
      "costPrice": costPrice,
      "sellingPrice": sellingPrice,
      "quantityAvailable": quantityAvailable,
      "shopNumber": shopNumber,
      "tags": tags
    };
  }

  static ProductEntity fromJson(Map<String, Object> json) {
    return ProductEntity(
      json["id"] as String,
      json["productName"] as String,
      json["shopId"] as String,
      json["description1"] as String,
      json["description2"] as String,
      json["image"] as String,
      json["costPrice"] as int,
      json["sellingPrice"] as int,
      json["quantityAvailable"] as int,
      json["tags"] as List,
      json["shopNumber"] as String,
    );
  }

  static ProductEntity fromSnapshot(DocumentSnapshot snap) {
    return ProductEntity(
      snap.id,
      (snap.data() as dynamic)['productName'],
      (snap.data() as dynamic)['shopId'],
      (snap.data() as dynamic)['description1'],
      (snap.data() as dynamic)['description2'],
      (snap.data() as dynamic)['image'],
      (snap.data() as dynamic)['costPrice'],
      (snap.data() as dynamic)['sellingPrice'],
      (snap.data() as dynamic)['quantityAvailable'],
      (snap.data() as dynamic)['tags'],
      (snap.data() as dynamic)['shopNumber'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      "id": id,
      "productName": productName,
      "shopId": shopId,
      "description1": description1,
      "description2": description2,
      "image": image,
      "costPrice": costPrice,
      "sellingPrice": sellingPrice,
      "quantityAvailable": quantityAvailable,
      "shopNumber": shopNumber,
      "tags": tags
    };
  }
}
