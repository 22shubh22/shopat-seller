import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopat_seller/firebase_repository/src/entities/product_entity.dart';
import 'package:shopat_seller/firebase_repository/src/firestore_service.dart';
import 'package:shopat_seller/global/colors.dart';
import 'package:shopat_seller/screens/submission_status.dart';
import 'package:shopat_seller/widgets/chip.dart';

class YourSubmissions extends StatefulWidget {
  const YourSubmissions({Key? key}) : super(key: key);

  @override
  _YourSubmissionsState createState() => _YourSubmissionsState();
}

class _YourSubmissionsState extends State<YourSubmissions> {
  bool _isLoading = false;

  String _chipSelected = "all";
  List<ProductEntity> _submissionsList = [];

  Future<void> getYourSubmissions() async {
    setState(() {
      _isLoading = true;
    });
    _submissionsList = await FirestoreService().getYourSubmissions();
    setState(() {
      _isLoading = false;
    });
  }

  bool showSubmission(String status) {
    if (_chipSelected == "all") {
      return true;
    } else if (_chipSelected == "accepted") {
      return status == "Accepted";
    } else if (_chipSelected == "pending") {
      return status == "Pending";
    } else {
      return true;
    }
  }

  @override
  void initState() {
    getYourSubmissions();
    super.initState();
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
                      'Your Submissions',
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
                          height: 16.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 16.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _chipSelected = 'all';
                                });
                              },
                              child: ChipWidget(
                                chipText: "  All  ",
                                isActive: _chipSelected == 'all',
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _chipSelected = 'accepted';
                                });
                              },
                              child: ChipWidget(
                                chipText: " Accepted ",
                                isActive: _chipSelected == 'accepted',
                              ),
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _chipSelected = 'pending';
                                });
                              },
                              child: ChipWidget(
                                chipText: " Pending ",
                                isActive: _chipSelected == 'pending',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Expanded(
                          child: RefreshIndicator(
                            color: Colors.black,
                            onRefresh: getYourSubmissions,
                            child: ListView.builder(
                                itemCount: _submissionsList.length,
                                itemBuilder: (context, index) {
                                  ProductEntity item = _submissionsList[index];
                                  return showSubmission(item.status)
                                      ? InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SubmissionStatus(
                                                  productEntity: item,
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
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.25,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Row(
                                                          children: [
                                                            Image.network(
                                                              item.image,
                                                              height: 80.0,
                                                              width: 80.0,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                            SizedBox(
                                                                width: 20.0),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${item.productName}",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
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
                                                          DateFormat("yMMMd")
                                                              .format(DateTime
                                                                  .parse(item
                                                                      .createdAt)),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
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
                                                                  "${item.costPrice}/-",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                                width: 48.0),
                                                            Text(
                                                                "${item.status}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: item.status ==
                                                                          "Accepted"
                                                                      ? Color(
                                                                          0XFF10C600)
                                                                      : Color(
                                                                          0XFFFF8413),
                                                                )),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container();
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
