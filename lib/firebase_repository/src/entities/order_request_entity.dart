class OrderRequestEntity {
  String createdAt;
  CustomerDetails customerDetails;
  List<ProductInfo> productInfo;
  String status;

  OrderRequestEntity(
      {required this.createdAt,
      required this.customerDetails,
      required this.productInfo,
      required this.status});

  factory OrderRequestEntity.fromJson(Map<String, dynamic> json) {
    List<ProductInfo> productInfo = [];
    json['productInfo'].forEach((v) {
      productInfo.add(new ProductInfo.fromJson(v));
    });

    return OrderRequestEntity(
        createdAt: json['createdAt'].toString(),
        customerDetails: CustomerDetails.fromJson(json['customerDetails']),
        productInfo: productInfo,
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;

    data['customerDetails'] = this.customerDetails.toJson();

    data['productInfo'] = this.productInfo.map((v) => v.toJson()).toList();

    data['status'] = this.status;
    return data;
  }
}

class CustomerDetails {
  String address;
  String name;
  String email;

  CustomerDetails(
      {required this.address, required this.name, required this.email});

  factory CustomerDetails.fromJson(Map<String, dynamic> json) {
    return CustomerDetails(
        address: json['address'], name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['name'] = this.name;
    data['email'] = this.email;
    return data;
  }
}

class ProductInfo {
  String image;
  int sellingPrice;
  int quantityAvailable;
  int numberOfItems;
  int costPrice;
  String shopNumber;
  String id;
  String shopId;
  String description2;
  String productName;
  String addedOn;
  String description1;

  ProductInfo(
      {required this.image,
      required this.sellingPrice,
      required this.quantityAvailable,
      required this.numberOfItems,
      required this.costPrice,
      required this.shopNumber,
      required this.id,
      required this.shopId,
      required this.description2,
      required this.productName,
      required this.addedOn,
      required this.description1});

  factory ProductInfo.fromJson(Map<String, dynamic> json) {
    return ProductInfo(
        image: json['image'],
        sellingPrice: json['sellingPrice'],
        quantityAvailable: json['quantityAvailable'],
        numberOfItems: json['numberOfItems'],
        costPrice: json['costPrice'],
        shopNumber: json['shopNumber'],
        id: json['id'],
        shopId: json['shopId'],
        description2: json['description2'],
        productName: json['productName'],
        addedOn: json['addedOn'],
        description1: json['description1']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['sellingPrice'] = this.sellingPrice;
    data['quantityAvailable'] = this.quantityAvailable;
    data['numberOfItems'] = this.numberOfItems;
    data['costPrice'] = this.costPrice;
    data['shopNumber'] = this.shopNumber;
    data['id'] = this.id;
    data['shopId'] = this.shopId;
    data['description2'] = this.description2;
    data['productName'] = this.productName;
    data['addedOn'] = this.addedOn;
    data['description1'] = this.description1;
    return data;
  }
}
