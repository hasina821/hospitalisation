import 'package:flutter/material.dart';

import '../size_confige.dart';

class DoctorAppBar extends StatelessWidget {
  const DoctorAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getRelativeWidth(0.04)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ICI",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: getRelativeWidth(0.09)),
              ),
              SizedBox(height: getRelativeHeight(0.003)),
              Text(
                "Trouver un docteur",
                style: TextStyle(
                    color: Colors.blueGrey[400],
                    fontSize: getRelativeWidth(0.036)),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

