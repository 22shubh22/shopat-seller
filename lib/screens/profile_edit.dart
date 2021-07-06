import 'package:bot_toast/bot_toast.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:shopat_seller/firebase_repository/src/firestore_service.dart';
import 'package:shopat_seller/global/colors.dart';

class ProfileEditPage extends StatefulWidget {
  final String name, sellerNumber, shopName, shopAddress;
  ProfileEditPage({
    Key? key,
    required this.name,
    required this.sellerNumber,
    required this.shopName,
    required this.shopAddress,
  }) : super(key: key);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sellerNumberController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _shopAddressController = TextEditingController();

  bool _isUpdating = false;

  @override
  void initState() {
    _nameController.text = widget.name;
    _sellerNumberController.text = widget.sellerNumber;
    _shopNameController.text = widget.shopName;
    _shopAddressController.text = widget.shopAddress;
    super.initState();
  }

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
                  "Edit Profile",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
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
                          "Name",
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
                          hintText: "Please Enter your name",
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
                        controller: _nameController,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Phone Number (This can’t be changed)",
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
                          hintText: "+91 9634891011",
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
                        controller: _sellerNumberController,
                        readOnly: true,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Shop Name",
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
                          hintText: "Enter name of your Shop",
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
                        controller: _shopNameController,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "Shop Address",
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
                          hintText: "Enter Address of your Shop",
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
                        controller: _shopAddressController,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Center(
                        child: InkWell(
                          onTap: () async {
                            // if (_nameController.text.length > 0 &&
                            //     _shopNameController.text.length > 0 &&
                            //     _shopAddressController.text.length > 0) {
                            //   setState(() {
                            //     _isUpdating = true;
                            //   });
                            //   await FirestoreService().updateProfileDetails(
                            //     name: _nameController.text,
                            //     shopName: _shopNameController.text,
                            //     shopAddress: _shopAddressController.text,
                            //   );
                            //   setState(() {
                            //     _isUpdating = false;
                            //   });
                            //   Navigator.of(context).pop('success');
                            // } else {
                            //   BotToast.showText(
                            //       text: "Please enter all the details");
                            // }
                            setState(() {
                              _isUpdating = true;
                            });
                            await FirestoreService().updateProfileDetails(
                              name: _nameController.text,
                              shopName: _shopNameController.text,
                              shopAddress: _shopAddressController.text,
                            );
                            setState(() {
                              _isUpdating = false;
                            });
                            Navigator.of(context).pop('success');
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
                                  _isUpdating
                                      ? Text(
                                          "Updating ....",
                                          style: TextStyle(
                                            fontFamily: "Poppins",
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          "Update",
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
                      SizedBox(
                        height: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
