import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '/styles/colors.dart';
import '/styles/styles.dart';
import "package:latlong2/latlong.dart" as latLng;

class SliverDoctorDetail extends StatelessWidget {
  const SliverDoctorDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text("Detail de l'hospitalisation"),
            backgroundColor: Color(MyColors.primary),
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage('assets/hospital.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: DetailBody(),
          )
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DetailDoctorCard(),
          SizedBox(
            height: 15,
          ),
          DoctorInfo(),
          SizedBox(
            height: 30,
          ),
          Text(
            'Concernant le patient',
            style: kTitleStyle,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Marihasina est une malade mantale',
            style: TextStyle(
              color: Color(MyColors.purple01),
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          SizedBox(
            height: 25,
          ),

          SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class DoctorLocation extends StatelessWidget {
  const DoctorLocation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlutterMap(
          options: MapOptions(
            center: latLng.LatLng(51.5, -0.09),
            zoom: 13.0,
          ),
          /*
          layers: [
            TileLayer(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
          ],

           */
        ),
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        NumberCard(
          label: 'Age',
          value: '25',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Maladie',
          value: 'Cardio',
        ),
        SizedBox(width: 15),
        NumberCard(
          label: 'Bloc',
          value: 'S13-BAT-C',
        ),
      ],
    );
  }
}

class AboutDoctor extends StatelessWidget {
  final String title;
  final String desc;
  const AboutDoctor({
    Key? key,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class NumberCard extends StatelessWidget {
  final String label;
  final String value;

  const NumberCard({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(MyColors.bg03),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 30,
          horizontal: 15,
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color(0xFF44bd32),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: TextStyle(
                color: Color(MyColors.header01),
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailDoctorCard extends StatelessWidget {
  const DetailDoctorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'RAMAMIHARIVELO',
                      style: TextStyle(
                          color: Color(MyColors.header01),
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Marihasina',
                      style: TextStyle(
                        color: Color(MyColors.grey02),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Image(
                height: 100,
                image: AssetImage('assets/doctor1.jpg'),
                width: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}