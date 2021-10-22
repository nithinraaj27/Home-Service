import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';

import '../../sizeconfig.dart';

class change_password extends StatefulWidget {
  const change_password({Key? key}) : super(key: key);

  @override
  _change_passwordState createState() => _change_passwordState();
}

class _change_passwordState extends State<change_password> {
  final _formKey = GlobalKey<FormState>();
  bool _autovalidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff23ADE8),
        title: Text(
          "Change Password",
          style: GoogleFonts.poppins(
              fontSize: SizeConfig.height! * 2.5,
              fontWeight: FontWeight.w500),
        ),),
      body: SingleChildScrollView(
        child: FadeAnimation(
          1, Container(
          height: SizeConfig.height!*55,
          margin: EdgeInsets.symmetric(vertical: SizeConfig.height!*4),
          child: Form(
            key: _formKey,
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
                            if(val.isEmpty || val == ""){

                            }
                            else{

                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "") {
                              return "Old Password should not be left empty";
                            }
                            return null;
                          },
                          autovalidate: _autovalidate,
                          decoration:
                          InputDecoration(
                              hintText: "Old Password",
                              errorMaxLines: 1,
                              prefixIcon: Icon(Icons.lock_outline,size: SizeConfig.height! * 3,),
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
                            if(val.isEmpty || val == ""){

                            }
                            else{

                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "") {
                              return "New Password should not be left empty";
                            }
                            return null;
                          },
                          autovalidate: _autovalidate,
                          decoration:
                          InputDecoration(
                              hintText: "New Password",
                              errorMaxLines: 1,
                              prefixIcon: Icon(Icons.lock_outline,size: SizeConfig.height! * 3,),
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
                            if(val.isEmpty || val == ""){


                            }
                            else{
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty || value == "") {
                              return "Confirm New Password should not be left empty";
                            }
                            return null;
                          },
                          autovalidate: _autovalidate,
                          decoration:
                          InputDecoration(
                              hintText: "Confirm New Password",
                              errorMaxLines: 1,
                              prefixIcon: Icon(Icons.lock_outline,size: SizeConfig.height! * 3,),
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
                Expanded(child: GestureDetector(
                  onTap: (){
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(vertical: SizeConfig.height!*2,horizontal: SizeConfig.width!*5),
                    height: SizeConfig.height! * 2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xff23ADE8),
                    ),
                    child: Text("Confirm Changes",style: Theme.of(context).textTheme.subtitle2,),
                  ),
                ),),
                Expanded(child: Container(
                  alignment: Alignment.topCenter,
                  child: Text("Forgot Password ??",style: GoogleFonts.poppins(
                    fontSize: SizeConfig.height! * 2,
                    color: Colors.black,
                  ),),
                ),),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
