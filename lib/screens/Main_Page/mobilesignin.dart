import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Main_Page/location.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../main.dart';

class mobileSignIn extends StatefulWidget {
  const mobileSignIn({Key? key}) : super(key: key);

  @override
  _mobileSignInState createState() => _mobileSignInState();
}

class _mobileSignInState extends State<mobileSignIn> {

  String? number;
  bool _autovalidate  =false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _alertDialogBox(String error) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Error",
              style: TextStyle(color: Theme.of(context).focusColor),
            ),
            content: Container(
              child: Text(
                error,
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Close Dialog",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          );
        });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text("Mobile Login",style: Theme.of(context).textTheme.subtitle2,),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: SizeConfig.height! * 30,
              width: double.infinity,
              //color: Colors.red,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                        child: FadeAnimation(
                          1,Container(
                          padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                          height: SizeConfig.height! * 2,
                          alignment: Alignment.center,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  number = val;
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty &&
                                    value == "" &&
                                    value.length != 10) {
                                  return "Phone number should not be left empty";
                                } else {
                                  String patttern =
                                      r'(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[789]\d{9}$)';
                                  RegExp regExp = new RegExp(patttern);
                                  if (!regExp.hasMatch(value)) {
                                    return 'Please enter valid mobile number';
                                  }
                                }

                                return null;
                              },
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              keyboardType: TextInputType.number,
                              autovalidate: _autovalidate,
                              decoration:InputDecoration(
                                  hintText: "Mobile",
                                  errorMaxLines: 1,
                                  prefixIcon: Icon(Icons.call,size: SizeConfig.height! * 3,),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 20),
                                  hintStyle: GoogleFonts.poppins(
                                      fontSize: SizeConfig.height! * 2.3,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey),
                                  border: InputBorder.none
                              ),
                              style: GoogleFonts.poppins(
                                  fontSize: SizeConfig.height! * 2,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                        )
                    ),
                    Expanded(
                      child: FadeAnimation(
                        1.7,Padding(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 10,vertical: SizeConfig.height! * 4),
                        child: GestureDetector(
                          onTap: () {
                            if (!_formKey.currentState!.validate()) {
                              _alertDialogBox("No field should be left Empty");
                            } else {
                              print(number);
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => OTPScreen(number!)));
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xff23ADE8),
                            ),
                            child: Text("Verify",style: Theme.of(context).textTheme.subtitle2,),
                          ),
                        ),
                      ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}


class OTPScreen extends StatefulWidget {
  final String phone;
  OTPScreen(this.phone);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? _verificationCode;
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: const Color.fromRGBO(43, 46, 66, 1),
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: const Color.fromRGBO(126, 203, 224, 1),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Center(
              child: Text(
                'Verify +91-${widget.phone}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: PinPut(
              fieldsCount: 6,
              textStyle: const TextStyle(fontSize: 25.0, color: Colors.white),
              eachFieldWidth: 40.0,
              eachFieldHeight: 55.0,
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
              pinAnimationType: PinAnimationType.fade,
              onSubmit: (pin) async {
                try {
                  await FirebaseAuth.instance
                      .signInWithCredential(PhoneAuthProvider.credential(
                      verificationId: _verificationCode!, smsCode: pin))
                      .then((value) async {
                    if (value.user != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => location_page(phone: widget.phone,)),
                              (route) => false);
                    }
                  }).whenComplete(() async=>{
                    await FirebaseFirestore.instance.collection("userdetails").doc(widget.phone).set(
                        {
                          "Name" : "Verified Customer",
                          "Mobile": widget.phone,
                          "E-Mail": "",
                          "Role" : "user",
                        }
                    )
                  });
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldkey.currentState!
                      .showSnackBar(SnackBar(content: Text('invalid OTP')));
                }
              },
            ),
          )
        ],
      ),
    );
  }

  _verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91${widget.phone}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => mainPage()),
                      (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String? verficationID, int? resendToken) {
          setState(() {
            _verificationCode = verficationID;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 120));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();
  }
}