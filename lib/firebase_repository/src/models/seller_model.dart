// import 'dart:ui';

import 'package:meta/meta.dart';
import '../entities/entities.dart';

@immutable
class SellerInfo {
  final String number;
  final String name;
  final String defaultAddress;
  final List productsSubmitted;
  final List productsRequested;

  SellerInfo(
      {required this.number,
      required this.name,
      required this.defaultAddress,
      required this.productsSubmitted,
      required this.productsRequested});

  SellerEntity toEntity() {
    return SellerEntity(
      number,
      name,
      defaultAddress,
      productsSubmitted,
      productsRequested,
    );
  }

  static SellerInfo fromEntity(SellerEntity entity) {
    return SellerInfo(
      number: entity.number,
      name: entity.name,
      defaultAddress: entity.defaultAddress,
      productsSubmitted: entity.productsSubmitted,
      productsRequested: entity.productsRequested,
    );
  }
}
