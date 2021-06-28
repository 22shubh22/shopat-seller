import 'package:flutter/material.dart';
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
                                itemCount: 4,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SubmissionStatus(),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Row(
                                                    children: [
                                                      Image.network(
                                                        "https://firebasestorage.googleapis.com/v0/b/shopat-8fe6c.appspot.com/o/cotton-saree.jpg?alt=media&token=6c74071c-e9ce-46e0-8b43-49a1df51468d",
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
                                                    "Frock 9 year cotton",
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
                                                    "July 7, 2021",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                                        "₹ " + "229/-",
                                                        style: TextStyle(
                                                          fontFamily: "Poppins",
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(width: 48.0),
                                                      Text(
                                                        "Accepted",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "Poppins",
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
