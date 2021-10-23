import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_service/Animation/animation.dart';
import 'package:home_service/screens/Profile_Page/Options/Service_Provider/service_provider_2.dart';
import 'package:home_service/service/get_services.dart';
import 'package:home_service/sizeconfig.dart';
import 'package:provider/provider.dart';

class service_provider extends StatefulWidget {
  const service_provider({Key? key}) : super(key: key);

  @override
  _service_providerState createState() => _service_providerState();
}

class _service_providerState extends State<service_provider> {
  bool _autovalidate = false;
  var services_list = [];
  String _initial = "Select Services";
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<get_services>(context, listen: false).fetch_service_list();

    Provider.of<get_services>(context, listen: false).set_selected_service("Select Services");

    Provider.of<get_services>(context, listen: false).set_selected_categories("Select Categories");
    super.initState();
  }

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
              height: SizeConfig.height! * 55,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Service Details",
                        style: GoogleFonts.poppins(
                            fontSize: SizeConfig.height! * 3,
                            color: Colors.lightBlue.shade900,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width! * 6,
                        vertical: SizeConfig.height! * 1.5),
                    height: SizeConfig.height! * 1,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Icon(
                            Icons.miscellaneous_services_outlined,
                            size: SizeConfig.height! * 4,
                            color: Colors.grey,
                          ),
                        )),
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width! * 1),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                items: context
                                    .watch<get_services>()
                                    .services_list
                                    .map((list) {
                                  return DropdownMenuItem(
                                      value: list,
                                      child: Text(
                                        list,
                                        style: TextStyle(
                                            fontSize: SizeConfig.height! * 2.1,
                                            color: Color(0xff303132)),
                                      ));
                                }).toList(),
                                onChanged: (type) {
                                  context
                                      .read<get_services>()
                                      .set_selected_service(type.toString());
                                },
                                value: context
                                    .watch<get_services>()
                                    .Selected_service,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: SizeConfig.width! * 6,
                        vertical: SizeConfig.height! * 1.5),
                    height: SizeConfig.height! * 1,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 0.5, color: Colors.grey.shade500),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Icon(
                            Icons.home_repair_service_outlined,
                            size: SizeConfig.height! * 3.5,
                            color: Colors.grey,
                          ),
                        )),
                        Expanded(
                          flex: 5,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: SizeConfig.width! * 1),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                dropdownColor: Colors.white,
                                items: context
                                    .watch<get_services>()
                                    .categories
                                    .map((list) {
                                  return DropdownMenuItem(
                                      value: list,
                                      child: Text(
                                        list,
                                        style: TextStyle(
                                            fontSize: SizeConfig.height! * 2.1,
                                            color: Color(0xff303132)),
                                      ));
                                }).toList(),
                                onChanged: (type) {
                                  context
                                      .read<get_services>()
                                      .set_selected_categories(type.toString());
                                },
                                value: context
                                    .watch<get_services>()
                                    .Selected_categories,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                  Expanded(
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.width! * 6),
                        height: SizeConfig.height! * 4,
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.5, color: Colors.grey.shade500),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            onChanged: (val) {
                              if (val.isEmpty || val == "") {
                              } else {}
                            },
                            validator: (value) {
                              if (value!.isEmpty || value == "") {
                                return "Location should not be left empty";
                              }
                              return null;
                            },
                            autovalidate: _autovalidate,
                            decoration: InputDecoration(
                                hintText: "Location",
                                errorMaxLines: 1,
                                prefixIcon: GestureDetector(
                                    onTap: () {},
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: SizeConfig.width!*5),
                                      child: Icon(
                                        Icons.location_on,
                                        size: SizeConfig.height! * 3,
                                      ),
                                    )),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                hintStyle: GoogleFonts.poppins(
                                    fontSize: SizeConfig.height! * 2.1,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff303132)),
                                border: InputBorder.none),
                            style: GoogleFonts.poppins(
                                fontSize: SizeConfig.height! * 2,
                                color: Colors.black),
                          ),
                        )),
                  ),
                  Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>provider_details()));
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
                        "Continue",
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
