import 'package:flutter/material.dart';
import 'package:learn2/presentation/doctor_body.dart';
import 'package:learn2/screens/auth/sign_in_screen.dart';
import 'package:learn2/tabs/Card_Patient.dart';
import '../constants.dart';
import './bottom_navigation_bar.dart';
import '../size_confige.dart';
import "../tabs/HomeTab.dart";


class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});
  @override
  _DoctorScreenState createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  void goToSchedule() {
    setState(() {
      _selectedIndex = 1;
    });
  }

  List<Map> navigationBarItems = [
    {'icon': Icons.home, 'index': 0},
    {'icon': Icons.home, 'index': 1},
    {'icon': Icons.local_hospital_rounded, 'index': 2},
    {'icon': Icons.people, 'index': 3},
    {'icon': Icons.account_box, 'index': 4},
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeTab(onPressedScheduleCard: goToSchedule),
      DoctorBody(),
      SignInScreen(),//CardDoctor(),
      CardPatient()
    ];
    SizeConfig.initSize(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigation (
        selectedIndex: _selectedIndex,
        onItemPressed: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        centerIcon: Icons.home,
        itemIcons: const [
          Icons.home,
          Icons.local_hospital_rounded,
          Icons.people,
          Icons.contact_emergency,
        ],
      ),
    );
  }
}
