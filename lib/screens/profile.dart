import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:shopat_seller/global/colors.dart';
import 'package:shopat_seller/screens/profile_edit.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
                  onPressed: () {},
                  icon: Icon(FeatherIcons.logOut),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    "Amar Pratap Singh",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 28.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    "+91 96348 91011",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ),
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
                              "Ambani ka baap wears",
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Shop no. 26, Village- Rampur, Alibaba, Chattisgarh, India, 245698",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF393D46),
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileEditPage(),
                        ),
                      );
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
