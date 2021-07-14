import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopat_seller/firebase_repository/auth.dart';
import 'package:shopat_seller/firebase_repository/src/firestore_service.dart';
import 'package:shopat_seller/global/colors.dart';
import 'package:shopat_seller/screens/seller_home.dart';
import 'package:shopat_seller/widgets/black_oval_button.dart';
import 'package:shopat_seller/widgets/login_text_field.dart';

class SellerLogin extends StatefulWidget {
  const SellerLogin({Key? key}) : super(key: key);

  @override
  _SellerLoginState createState() => _SellerLoginState();
}

class _SellerLoginState extends State<SellerLogin> {
  final TextEditingController _phoneCont = TextEditingController();
  final TextEditingController _passwordCont = TextEditingController();
  late String verificationId, smsCode;
  bool codeSent = false;
  bool _isOtpSending = false;
  bool _isLoginLoading = false;

  @override
  void initState() {
    super.initState();
    AuthService().isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Container(
              alignment: Alignment.center,
              child: Image.asset('assets/images/lockCenter.png'),
            ),
            SizedBox(height: 54.0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellerHome(),
                  ),
                );
              },
              child: Text(
                'Shop At',
                style: GoogleFonts.righteous(
                  textStyle: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.accentColor,
                  ),
                ),
              ),
            ),
            Text(
              'Seller App',
              style: GoogleFonts.righteous(
                textStyle: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 24.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'Phone number',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: AppColors.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(
                  child: LoginTextField(
                    controller: _phoneCont,
                    hint: "Eg: 9876543210",
                    textInputType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: _isOtpSending
                      ? Text(
                          'Sending ....',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        )
                      : InkWell(
                          onTap: () async {
                            if (_phoneCont.text.trim().length == 10) {
                              print("I am here00");
                              setState(() {
                                _isOtpSending = true;
                              });
                              await verifyPhone("+91" + _phoneCont.text);
                              print("I am here00");
                            } else {
                              BotToast.showText(
                                  text: "Mobile number should be 10 digits");
                            }
                          },
                          child: Text(
                            'Send OTP',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 40.0),
              child: Text(
                'OTP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 14.0,
                  color: AppColors.accentColor,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            LoginTextField(
              controller: _passwordCont,
              hint: "Enter OTP sent to your number",
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: 16.0,
            ),
            codeSent && _passwordCont.text.isNotEmpty
                ? _isLoginLoading
                    ? BlackOvalButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "Please wait .....",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                          ],
                        ),
                        onPressedAction: () {},
                      )
                    : BlackOvalButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 6.0,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                          ],
                        ),
                        onPressedAction: () async {
                          setState(() {
                            _isLoginLoading = true;
                          });
                          try {
                            await FirebaseAuth.instance
                                .signInWithCredential(
                                    PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: _passwordCont.text.trim(),
                            ))
                                .then((value) async {
                              if (value.user != null) {
                                await FirestoreService().getUserByPhone(
                                    "+91" + _phoneCont.text,
                                    AuthService().getUserId());
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SellerHome()),
                                    (route) => false);
                              }
                            });
                          } catch (e) {
                            print(" error is  : $e");
                            BotToast.showText(text: "Invalid OTP");
                          }
                          setState(() {
                            _isLoginLoading = false;
                          });
                        },
                      )
                : Container(),
            SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Text(
                "Please login to sell your products, you will be registered if not already registered.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.accentColor.withOpacity(0.60),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
      setState(() {
        _isOtpSending = false;
      });
      BotToast.showText(text: '${authException.message}');
    };

    final PhoneCodeSent codeSent = (String verId, int? forceResend) {
      setState(() {
        this.codeSent = true;
        verificationId = verId;
        _isOtpSending = false;
      });
      BotToast.showText(text: "OTP sent succesfully");
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      setState(() {
        verificationId = verId;
      });
    };
    print(phoneNo);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }
}
