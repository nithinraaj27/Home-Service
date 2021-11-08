import 'package:flutter/material.dart';
import 'package:home_service/screens/Home_Page/serviceProviderProfile.dart';
import 'package:home_service/sizeconfig.dart';

class ServiceProvidersCard extends StatelessWidget {
  final String name;
  final String image;
  final String mobile;
  final String service;
  final String status;
  final String experience;
  final String description;
  final String mail;
  final String qualification;

  const ServiceProvidersCard(
      {Key? key,
      required this.name,
      required this.image,
      required this.mobile,
      required this.service,
      required this.status,
      required this.experience,
      required this.description,
      required this.mail,
      required this.qualification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.height! * 100,
      width: SizeConfig.width! * 110,
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => serviceProviderProfile(
                  name: name,
                  email: mail,
                  expirence: experience,
                  image: image,
                  qualification: qualification,
                  mobile: mobile,
                  desc: description,
                  status: status,
                  service: service, block: '', location: '', subservice: '', id: '',
                )));
              },
              child: Text(
                "Service Providers List",
                style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: SizeConfig.height! * 3.7,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.height! * 2),
          Expanded(
            flex: 9,
            child: ListTile(
              leading: CircleAvatar(
                radius: SizeConfig.width! * 12,
                backgroundImage: NetworkImage(image),
              ),
              title: Text(name,
                style: Theme.of(context).textTheme.headline1),
              subtitle: Text(mail,style: Theme.of(context).textTheme.headline3),
            ),
          )
        ],
      ),
    );
  }
}
