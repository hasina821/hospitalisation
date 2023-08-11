import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import './banner.dart';
import './bottom_navigation_bar.dart';
import './doctors_list.dart';
import './search_field.dart';
import '../size_confige.dart';
import 'appbar.dart';
import 'categories_list.dart';
import '../constants.dart';
import '../size_confige.dart';

class DoctorBody extends StatelessWidget {
  const DoctorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getRelativeHeight(0.025)),
              const DoctorAppBar(),
              SizedBox(height: getRelativeHeight(0.015)),
              const DoctorBanner(),
              SizedBox(height: getRelativeHeight(0.005)),
              /*SearchField()*/
              SizedBox(height: getRelativeHeight(0.025)),
              const CategoriesList(),
              SizedBox(height: getRelativeHeight(0.01)),
              const DoctorsList()
            ],
          ),
        ),
      ],

    );
  }
}
