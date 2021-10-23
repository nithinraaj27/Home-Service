import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/sizeconfig.dart';

class provider_details extends StatefulWidget {
  const provider_details({Key? key}) : super(key: key);

  @override
  _provider_detailsState createState() => _provider_detailsState();
}

class _provider_detailsState extends State<provider_details> {
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Color(0xff23ADE8),
            title: Text(
              "Register as Service Provider",
              style: GoogleFonts.poppins(
                  fontSize: SizeConfig.height! * 2.5, fontWeight: FontWeight.w500),
            ),
          ),
          body: SingleChildScrollView(
            child: FadeAnimation(
              1,
              Container(
                  margin: EdgeInsets.symmetric(vertical: SizeConfig.height! * 1),
                  height: SizeConfig.height! * 80,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            "Service Provider Details",
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 3,
                                color: Colors.lightBlue.shade900,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ),
                      Expanded(
                          child: FadeAnimation(
                            1.1,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {

                                },
                                validator: (value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Name should not be left empty";
                                  }
                                  return null;
                                },
                                autovalidate: _autovalidate,
                                decoration:
                                InputDecoration(
                                    hintText: "Full Name",
                                    errorMaxLines: 1,
                                    prefixIcon: Icon(FontAwesomeIcons.idBadge,size: SizeConfig.height! * 3,),
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
                            1.2,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {

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
                            1.3,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {

                                },
                                validator: (value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Email should not be left empty";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
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
                          ),
                          )
                      ),
                      Expanded(
                          child: FadeAnimation(
                            1.1,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {

                                },
                                validator: (value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Name should not be left empty";
                                  }
                                  return null;
                                },
                                autovalidate: _autovalidate,
                                decoration:
                                InputDecoration(
                                    hintText: "Qualification",
                                    errorMaxLines: 1,
                                    prefixIcon: Icon(FontAwesomeIcons.graduationCap,size: SizeConfig.height! * 3,),
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
                            1.1,Container(
                            padding:EdgeInsets.symmetric(horizontal: SizeConfig.width! * 6),
                            height: SizeConfig.height! * 4,
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(width: 0.5,color: Colors.grey.shade500),
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: TextFormField(
                                onChanged: (val) {

                                },
                                validator: (value) {
                                  if (value!.isEmpty && value == "") {
                                    return "Name should not be left empty";
                                  }
                                  return null;
                                },
                                autovalidate: _autovalidate,
                                decoration:
                                InputDecoration(
                                    hintText: "Year of Experience",
                                    errorMaxLines: 1,
                                    prefixIcon: Icon(FontAwesomeIcons.certificate,size: SizeConfig.height! * 3,),
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
                          child: GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.symmetric(
                                  vertical: SizeConfig.height! * 2.3,
                                  horizontal: SizeConfig.width! * 5),
                              height: SizeConfig.height! * 2,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xff23ADE8),
                              ),
                              child: Text(
                                "Submit",
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          )),

                    ],
                  )),
            ),
          ),
        ));
  }
}
