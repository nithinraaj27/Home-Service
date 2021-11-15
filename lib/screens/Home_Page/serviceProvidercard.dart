import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
      color: Colors.grey[100],
      height: SizeConfig.height! * 12,
      width: SizeConfig.width! * 110,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    image,
                  ),
                  radius: 30.0,
                ),
                Text(
                  status,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        fontSize: SizeConfig.height! * 1.7,
                        fontWeight: FontWeight.bold,
                        color: status == "Open" ? Colors.green : Colors.red,
                      ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                    fontSize: SizeConfig.height! * 2.7,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                mail,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: SizeConfig.height! * 1.5,
                    ),
              ),
              Text(
                mobile,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontSize: SizeConfig.height! * 1.5,
                    ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {},
            child: Text(
              "Add + ",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                  fontSize: SizeConfig.height! * 1.7, color: Colors.lightBlue),
            ),
          )
        ],
      ),
    );
  }
}
