import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopat_seller/firebase_repository/src/entities/order_request_entity.dart';
import 'package:shopat_seller/firebase_repository/src/firestore_service.dart';
import 'package:shopat_seller/global/colors.dart';
import 'package:shopat_seller/screens/order_details.dart';

class OrderRequests extends StatefulWidget {
  const OrderRequests({Key? key}) : super(key: key);

  @override
  _OrderRequestsState createState() => _OrderRequestsState();
}

class _OrderRequestsState extends State<OrderRequests> {
  bool _isLoading = false;

  List<OrderRequestEntity> _orderRequests = [];

  Future<void> getOrderRequests() async {
    setState(() {
      _isLoading = true;
    });
    _orderRequests = await FirestoreService().getProductsRequest();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getOrderRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorLight,
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
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      'Order Requests',
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
            _isLoading
                ? Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.black),
                      ),
                    ),
                  )
                : _orderRequests.length > 0
                    ? Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 24.0,
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                color: Colors.black,
                                onRefresh: getOrderRequests,
                                child: ListView.builder(
                                    itemCount: _orderRequests.length,
                                    itemBuilder: (context, index) {
                                      OrderRequestEntity _order =
                                          _orderRequests[index];
                                      int billAmt = 0;
                                      for (var i in _order.productInfo) {
                                        billAmt +=
                                            (i.sellingPrice * i.numberOfItems);
                                      }
                                      return InkWell(
                                        onTap: () async {
                                          var res = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderDetails(
                                                cartsList: _order.productInfo,
                                                date: DateFormat('yMMMd')
                                                    .format(DateTime.parse(
                                                        '${_order.createdAt}')),
                                                status: _order.status,
                                                orderId: _order.orderId,
                                              ),
                                            ),
                                          );
                                          if (res == "success") {
                                            getOrderRequests();
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(24.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                                right: 16.0,
                                                top: 8.0,
                                                bottom: 8.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${_order.productInfo[0].productName} ${_order.productInfo.length > 1 ? "+ ${_order.productInfo.length - 1} items" : ""}",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      SizedBox(height: 6.0),
                                                      // Text(
                                                      //   "Description One",
                                                      //   maxLines: 2,
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      //   style: TextStyle(
                                                      //     fontFamily: "Poppins",
                                                      //     fontSize: 14.0,
                                                      //     color: Colors.grey[400],
                                                      //   ),
                                                      // ),
                                                      // SizedBox(height: 4.0),
                                                      // Text(
                                                      //   "Description Two",
                                                      //   maxLines: 1,
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      //   style: TextStyle(
                                                      //     fontFamily: "Poppins",
                                                      //     fontSize: 14.0,
                                                      //     color: Colors.grey[400],
                                                      //   ),
                                                      // ),
                                                      Text(
                                                        DateFormat('yMMMd')
                                                            .add_Hm()
                                                            .format(DateTime.parse(
                                                                '${_order.createdAt}')),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.60),
                                                        ),
                                                      ),
                                                      SizedBox(height: 6.0),
                                                      Text(
                                                        "Order Id :  ${_order.orderId}",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.60),
                                                        ),
                                                      ),
                                                      SizedBox(height: 6.0),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "₹ " +
                                                                "$billAmt /-",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 16.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(width: 48.0),
                                                          Text(
                                                            "${_order.status}",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 14.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: _order
                                                                            .status ==
                                                                        "Pending"
                                                                    ? Color(
                                                                        0XFFFF8413)
                                                                    : Color(
                                                                        0XFF10C600)),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: Center(
                          child: Text(
                            "No Order Requests Found",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 18.0,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
          ],
        ),
      ),
    );
  }
}
