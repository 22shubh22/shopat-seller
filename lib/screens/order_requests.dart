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

  Future<void> getYourSubmissions() async {
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
    getYourSubmissions();
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

                : Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24.0,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            color: Colors.black,
                            onRefresh: getYourSubmissions,
                            child: ListView.builder(
                                itemCount: _orderRequests.length,
                                itemBuilder: (context, index) {
                                  OrderRequestEntity _order =
                                      _orderRequests[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
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
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${_order.productInfo[0].productName} ${_order.productInfo.length > 1 ? "+ ${_order.productInfo.length - 1} items" : ""}",
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 18.0,
                                                    fontWeight: FontWeight.w400,
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
                                                  DateFormat('yMMMd').format(
                                                      DateTime.parse(
                                                          '${_order.createdAt}')),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black
                                                        .withOpacity(0.60),
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
                                                          "${_order.productInfo[0].costPrice}/-",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500,

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
                                onRefresh: getYourSubmissions,
                                child: ListView.builder(
                                    itemCount: _orderRequests.length,
                                    itemBuilder: (context, index) {
                                      OrderReuestEntity _order =
                                          _orderRequests[index];
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrderDetails(
                                                cartsList: _order.productInfo,
                                                date: DateFormat('yMMMd')
                                                    .format(DateTime.parse(
                                                        '${_order.createdAt}')),
                                                status: _order.status,
                                              ),
                                            ),
                                          );
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
                                                        DateFormat('yMMMd').format(
                                                            DateTime.parse(
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
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "₹ " +
                                                                "${_order.productInfo[0].costPrice}/-",
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
                                                                color: Color(
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
