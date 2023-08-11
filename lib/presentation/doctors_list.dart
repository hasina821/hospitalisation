import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../data/data.dart';

import '../constants.dart';
import '../size_confige.dart';
import '../sql/sql_helper.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  _DoctorsListState createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  List<Map<String ,dynamic>> _docteurs = [];
  bool _isloading = true;

  void _refreshDocteurs() async {
    final data = await SQLHelper.getDoctors();
    setState(() {
      _docteurs = data;
      _isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshDocteurs();
    print("...Nombre de docteur trouvé ${_docteurs.length}");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getRelativeHeight(0.35),
      child: ListView.builder(
        itemCount: _docteurs.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.035)),
        itemBuilder: (context, index) {
          final doctor = _docteurs[index];
          final color =
          kCategoriesSecondryColor[(kCategoriesSecondryColor.length - index - 1)];
          final circleColor =
          kCategoriesPrimaryColor[(kCategoriesPrimaryColor.length - index - 1)];
          final cardWidth = getRelativeWidth(0.48);
          return Row(
            children: [
              Container(
                width: cardWidth,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Stack(
                          children: [
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25),
                                    ),
                                    color: color,
                                  ),
                                  height: getRelativeHeight(0.14),
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: getRelativeHeight(0.13),
                                          height: getRelativeHeight(0.13),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 15,
                                                color: circleColor.withOpacity(0.6)),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: getRelativeHeight(0.11),
                                          height: getRelativeHeight(0.11),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 15,
                                                color: circleColor.withOpacity(0.25)),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          width: getRelativeHeight(0.11),
                                          height: getRelativeHeight(0.11),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 15,
                                                color: circleColor.withOpacity(0.17)),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: cardWidth,
                              height: getRelativeHeight(0.19),
                              child: Image.asset('assets/images/doctor1.png'),
                            ),
                          ],
                        ),
                        Container(
                          height: getRelativeHeight(0.12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: getRelativeHeight(0.02),
                              horizontal: getRelativeWidth(0.05),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor['nom'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kHardTextColor,
                                    fontSize: getRelativeWidth(0.041),
                                  ),
                                ),
                                SizedBox(height: getRelativeHeight(0.005)),
                                Text(
                                  doctor['specialite'],
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: getRelativeWidth(0.032),
                                  ),
                                ),
                                SizedBox(height: getRelativeHeight(0.005)),
                                Row(
                                  children: [
                                    SizedBox(width: getRelativeWidth(0.01)),
                                    Text(
                                      "(${doctor['email']} Reviews)",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.8),
                                        fontSize: getRelativeWidth(0.022),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: getRelativeHeight(0.04))
                              .copyWith(left: cardWidth * 0.7),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: Offset(0, 3),
                                  color: Colors.black26,
                                )
                              ],
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            padding: EdgeInsets.all(getRelativeWidth(0.015)),
                            child: Icon(
                              FontAwesomeIcons.facebookMessenger,
                              color: color,
                              size: getRelativeWidth(0.055),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: getRelativeWidth(0.04)),
            ],
          );
        },
      ),
    );
  }
}
