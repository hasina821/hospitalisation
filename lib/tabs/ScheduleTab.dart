import 'package:flutter/material.dart';
import '/styles/colors.dart';
import '/styles/styles.dart';
import "../sql/sql_helper.dart";
import "./Card_doctor.dart";
import "./Card_Patient.dart";


class ScheduleTab extends StatefulWidget {
  const ScheduleTab({Key? key}) : super(key: key);

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();

}

class _ScheduleTabState extends State<ScheduleTab> {
  Alignment _alignment = Alignment.centerLeft;
  List<Map<String, dynamic>> _docteurs = [];
  bool _isloading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Padding (
        padding: const EdgeInsets.only(left: 30, top: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text (
              'Liste des docteurs',
              textAlign: TextAlign.center,
              style: kTitleStyle,
            ),
            const SizedBox (
              height: 20 ,
            ) ,

            const SizedBox(
              height: 20,
            ),
            Expanded (
              child: CardDoctor()
            )
          ],
        ),
      ),/*
      floatingActionButton: FloatingActionButton (
          backgroundColor: Color(MyColors.primary),
          onPressed: () => {

                if ( status == FilterStatus.Docteur )
                  {
                    _showform(null)
                  }  else {
                  _showformPatient(null)
                }
              },
          child: const Icon(Icons.add)),*/
    );
  }
}
