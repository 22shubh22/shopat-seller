import 'package:flutter/material.dart';
import 'package:shopat_seller/global/colors.dart';

class SubmissionStatus extends StatefulWidget {
  const SubmissionStatus({Key? key}) : super(key: key);

  @override
  _SubmissionStatusState createState() => _SubmissionStatusState();
}

class _SubmissionStatusState extends State<SubmissionStatus> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              // product.image should rome here.
                              "https://firebasestorage.googleapis.com/v0/b/shopat-8fe6c.appspot.com/o/cotton-saree.jpg?alt=media&token=6c74071c-e9ce-46e0-8b43-49a1df51468d",
                              height: MediaQuery.of(context).size.height * 0.45,
                              width: double.infinity,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Frock 9 year cotton",
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 28.0,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Product description comes here",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        AppColors.accentColor.withOpacity(0.60),
                                  ),
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey),
                            ListTile(
                              title: Text(
                                "Price (per item)",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0XFF393D46),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: Text(
                                "₹ 5250/-",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0XFF393D46),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey),
                            ListTile(
                              title: Text(
                                "Approved by Admin",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  color: Color(0XFF10C600),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            Divider(color: Colors.grey),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_back,
                            color: AppColors.accentColor,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
