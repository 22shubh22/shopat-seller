import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopat_seller/firebase_repository/src/firestore_service.dart';
import 'package:shopat_seller/global/colors.dart';
import 'package:shopat_seller/screens/profile_edit.dart';
import 'package:shopat_seller/screens/seller_login.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isLoading = false;
  late String name, sellerNumber, shopName, shopAddress;

  @override
  void initState() {
    getProfileDetails();
    super.initState();
  }

  getProfileDetails() async {
    setState(() {
      _isLoading = true;
    });
    var details = await FirestoreService().getProfileDetails();
    setState(() {
      name = details['name'];
      sellerNumber = details['sellerNumber'];
      shopName = details['shopName'];
      shopAddress = details['shopAddress'];
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(FeatherIcons.arrowLeft),
                    ),
                    Text(
                      "Profile & Settings",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    while (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellerLogin(),
                      ),
                    );
                  },
                  icon: Icon(FeatherIcons.logOut),
                ),
              ],
            ),
            _isLoading
                ? Expanded(
                    child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.black),
                    ),
                  ))
                : Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 24.0,
                        ),
                        Text(
                          "$name",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "+91 ${sellerNumber.substring(3)}",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 26.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Icon(
                                    FeatherIcons.mapPin,
                                    size: 32.0,
                                  ),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    "$shopName",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 8.0),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.80,
                                    child: Text(
                                      "$shopAddress",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: "Poppins",
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF393D46),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.0,
                        ),
                        InkWell(
                          onTap: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileEditPage(
                                  name: name,
                                  sellerNumber: sellerNumber,
                                  shopName: shopName,
                                  shopAddress: shopAddress,
                                ),
                              ),
                            );

                            if (result == "success") {
                              getProfileDetails();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
