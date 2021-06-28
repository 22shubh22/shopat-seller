import 'package:flutter/material.dart';
import 'package:shopat_seller/global/colors.dart';

class OrderRequests extends StatefulWidget {
  const OrderRequests({Key? key}) : super(key: key);

  @override
  _OrderRequestsState createState() => _OrderRequestsState();
}

class _OrderRequestsState extends State<OrderRequests> {
  bool _isLoading = false;

  Future<void> getYourSubmissions() async {}

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
                                itemCount: 4,
                                itemBuilder: (context, index) {
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
                                                  "Cotton Saree + 3 items ",
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
                                                  "July 7, 2021 01:11 PM",
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
                                                      "₹ " + "6229/-",
                                                      style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(width: 48.0),
                                                    Text(
                                                      "Recieved By Admin",
                                                      style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w400,
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
                                  );
                                }),
                          ),
                        ),
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
