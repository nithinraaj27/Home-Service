import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Main_Page/forgetpassword.dart';
import 'package:home_service/screens/Main_Page/mobilesignin.dart';
import 'package:home_service/screens/Main_Page/signup.dart';
import 'package:home_service/service/googlesignin.dart';
import 'package:home_service/sizeconfig.dart';

class signin extends StatefulWidget {

  @override
  _signinState createState() => _signinState();
}

class _signinState extends State<signin> {

  String? email = "";
  String? pasword = "";

  bool obscure_text = true;
  bool _autovalidate = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/drive',
    ],
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();

  Future<String?> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: pasword!,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password is too week";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exist for that email";
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }


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

  void _submitform() async {
    String? feedback = await _loginAccount();
    if (feedback != null) {
      _alertDialogBox(feedback);
    } else {
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Container(
              height: SizeConfig.height! * 120,
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: FadeAnimation(
                      1,Container(
                        decoration: BoxDecoration(
                          image: new DecorationImage(
                              image: AssetImage(
                                "assets/login.jpg",
                              ),
                            fit: BoxFit.fill
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FadeAnimation(
                      1.1,Container(
                        padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 5),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Welcome To,",style: Theme.of(context).textTheme.headline3,),
                            Text("Login With",style: Theme.of(context).textTheme.subtitle1,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FadeAnimation(
                      1.2,Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Container(
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                                  height: SizeConfig.height! * 4,
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        setState(() {
                                          email = val;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty && value == "") {
                                          return "Email should not be left empty";
                                        }
                                        return null;
                                      },
                                      autovalidate: _autovalidate,
                                      decoration:
                                      InputDecoration(
                                          hintText: "Email",
                                          errorMaxLines: 1,
                                          prefixIcon: Icon(Icons.mail,size: SizeConfig.height! * 3,),
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
                                )
                              ),
                              SizedBox(height: SizeConfig.height! * 2,),
                              Expanded(
                                child: Container(
                                  height: SizeConfig.height! * 4,
                                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        setState(() {
                                          pasword = val;
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty && value == "") {
                                          return "Password should not be left empty";
                                        }
                                        return null;
                                      },
                                      obscureText: obscure_text,
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          hintStyle: GoogleFonts.poppins(
                                              fontSize: SizeConfig.height! * 2.3,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                          errorMaxLines: 1,
                                          prefixIcon: Icon(Icons.lock,size: SizeConfig.height! * 3,),
                                          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                obscure_text = !obscure_text;
                                              });
                                            },
                                            icon: Icon(obscure_text
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            color: Colors.blue,
                                          ),
                                          border: InputBorder.none),
                                      style: GoogleFonts.poppins(
                                          fontSize: SizeConfig.height! * 2,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(height: SizeConfig.height! * 1,)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    //flex: 2,
                    child: FadeAnimation(
                      1.3,Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            //_submitform();
                            if (!_formKey.currentState!.validate()) {
                              setState(() {
                                _autovalidate = true;
                              });
                              _alertDialogBox("No field should be left Empty");
                            } else {
                              setState(() {
                                _autovalidate = false;
                              });
                                _submitform();
                              }
                            },
                          child: Container(
                            alignment: Alignment.center,
                            height: SizeConfig.height! * 6,
                            width: SizeConfig.width! * 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.blue,
                            ),
                            child: Text("Sign In",style: Theme.of(context).textTheme.subtitle2,),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    //flex: 2,
                    child: FadeAnimation(
                      1.3,Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => mobileSignIn()));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: SizeConfig.height! * 6,
                          width: SizeConfig.width! * 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blue,
                          ),
                          child: Container(
                              alignment: Alignment.center,
                              child: Text("Sign in with Mobile",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(color: Colors.white,fontSize: SizeConfig.height! * 2)),)),
                        ),
                      ),
                    ),
                    ),
                  ),
                  Expanded(
                    //flex: 2,
                    child: FadeAnimation(
                      1.3,Container(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          googlesigninclass.googleLogin();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: SizeConfig.height! * 6,
                          width: SizeConfig.width! * 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1,color: Colors.black54)
                          ),
                          child: Row(
                            children: [
                              Expanded(child: Image.asset("assets/google.png",height: SizeConfig.height! * 3,)),
                              Expanded(
                                  flex: 3,
                                  child: Text("Sign in with Google",style: Theme.of(context).textTheme.subtitle2!.merge(TextStyle(color: Colors.black54,fontSize: SizeConfig.width! * 4)),)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ),
                  ),
                  Expanded(
                    //flex: 2,
                    child: FadeAnimation(
                      1.4,Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                        child: Text("Doesn't have an account ?",style: Theme.of(context).textTheme.headline3!.merge(TextStyle(color: Colors.black54)),)),
                                  ),
                                  Expanded(
                                    child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: InkWell(
                                            onTap: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => signup()));
                                            },
                                            child: Text(" SignUp",style: Theme.of(context).textTheme.headline3!.merge(TextStyle(color: Colors.blue))))),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: SizeConfig.height! * 1,),
                            Expanded(
                                child: GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>forgetpassword()));
                                    },
                                    child: Text("Forgot password?",style: Theme.of(context).textTheme.headline3!.merge(TextStyle(color: Colors.black54)),))
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ));
  }
}

