// import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopat_seller/firebase_repository/src/entities/order_request_entity.dart';
import 'package:shopat_seller/firebase_repository/src/firestore_service.dart';
import 'package:shopat_seller/global/colors.dart';
// import 'package:shopat_seller/widgets/separator.dart';

class OrderDetails extends StatefulWidget {
  final List<ProductInfo> cartsList;
  final String date, status;
  final String? orderId;
  const OrderDetails({
    Key? key,
    required this.cartsList,
    required this.date,
    required this.status,
    this.orderId,
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int totalItems = 0;
  int totalAmount = 0;
  bool _isLoading = false;
  String address = "";
  bool _isUpdating = false;

  @override
  void initState() {
    calculatingTheCosts(widget.cartsList);
    super.initState();
  }

  calculatingTheCosts(List<ProductInfo> cartsList) async {
    setState(() {
      _isLoading = false;
    });
    int tempItems = 0, tempTotal = 0;
    for (var i in cartsList) {
      tempItems = tempItems + i.numberOfItems;
      tempTotal = tempTotal + (i.numberOfItems * i.sellingPrice);
    }
    setState(() {
      totalItems = tempItems;
      totalAmount = tempTotal;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'Order Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            _isLoading
                ? Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  )))
                : Expanded(
                    child: ListView.builder(
                        itemCount: widget.cartsList.length,
                        itemBuilder: (context, index) {
                          ProductInfo item = widget.cartsList[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 12.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24.0),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.25,
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          children: [
                                            Image.network(
                                              item.image,
                                              height: 80.0,
                                              width: 80.0,
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(width: 20.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${item.productName}",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          "${item.description1}",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14.0,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          "${item.description2}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontSize: 14.0,
                                            color: Colors.grey[400],
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              // "₹ " +
                                              //     "${item.sellingPrice}  X  ${item.numberOfItems}",
                                              "₹ " + "${item.sellingPrice}",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            SizedBox(width: 32.0),
                                            Text(
                                              "No of items: ${item.numberOfItems}",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
            SizedBox(
              height: 24.0,
            ),
            Center(
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _isUpdating = true;
                  });
                  var result = await FirestoreService().updateOrderStatus(
                    orderId: widget.orderId,
                    status: "Ready",
                  );
                  if (result['res']) {
                    setState(() {
                      _isUpdating = false;
                    });
                    Navigator.of(context).pop("success");
                  } else {
                    setState(() {
                      _isUpdating = false;
                    });
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: MediaQuery.of(context).size.width * 0.40,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: AppColors.accentColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _isUpdating
                            ? Text(
                                "Updating ...",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Mark as Ready",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
          ],
        ),
      ),
    );
  }
}
