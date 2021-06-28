import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:shopat_seller/global/colors.dart';

class AddNewProductPage extends StatefulWidget {
  AddNewProductPage({Key? key}) : super(key: key);

  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                  "Add a new product",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 18.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Item Name",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF393D46),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Add name of the item",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF393D46).withOpacity(0.60),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Description",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF393D46),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Description Line 1",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF393D46).withOpacity(0.60),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 12.0,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Description Line 2",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF393D46).withOpacity(0.60),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        "Price",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF393D46),
                        ),
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Price to display",
                        hintStyle: TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF393D46).withOpacity(0.60),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.60),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Color(0xFF393D46).withOpacity(0.15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            child: Image.network(
                              "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
                              height: 120.0,
                              width: 120.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                              height: 120.0,
                              width: 120.0,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FeatherIcons.image),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    "Upload a picture",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: "Poppins",
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF393D46),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          width: MediaQuery.of(context).size.width * 0.25,
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
                                  "Submit",
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
