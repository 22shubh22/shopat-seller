import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:shopat_seller/firebase_repository/src/entities/order_request_entity.dart';
import 'package:shopat_seller/global/colors.dart';
import 'package:shopat_seller/widgets/separator.dart';

class OrderDetails extends StatefulWidget {
  final List<ProductInfo> cartsList;
  final String date, status;
  const OrderDetails({
    Key? key,
    required this.cartsList,
    required this.date,
    required this.status,
  }) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  int totalItems = 0;
  int totalAmount = 0;
  bool _isLoading = false;
  String address = "";

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
              height: 8.0,
            ),
            _isLoading
                ? Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                  )))
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          strokeWidth: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Column(
                                  children: widget.cartsList.map((item) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${item.productName}",
                                              style: TextStyle(
                                                  fontFamily: "Poppins"),
                                            ),
                                            Text(
                                              "${item.numberOfItems} x ₹${item.sellingPrice}",
                                              style: TextStyle(
                                                fontFamily: "Poppins",
                                                color: Colors.grey[400],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 4.0),
                                      ],
                                    );
                                  }).toList(),
                                ),
                                SizedBox(height: 8.0),
                                MySeparator(),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total items",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "$totalItems",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Net total",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "₹$totalAmount",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                MySeparator(),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Extra charges",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "₹ 0",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Amount",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "₹$totalAmount",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                MySeparator(),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Billing Date",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "${widget.date}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.grey[400],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                MySeparator(),
                                SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Billing Status",
                                      style: TextStyle(fontFamily: "Poppins"),
                                    ),
                                    Text(
                                      "${widget.status}",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
