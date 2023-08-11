import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/styles/colors.dart';
import "../sql/sql_helper.dart";
import '/styles/styles.dart';

class CardDoctor extends StatefulWidget {

  @override
  _CardDoctor createState()=>_CardDoctor();
}

class _CardDoctor extends State<CardDoctor>{
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
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();
  final TextEditingController _profileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _addDocteur() async {
    await SQLHelper.createDoctor(
        _nomController.text,
        _specialiteController.text,
        _profileController.text,
        _emailController.text,
        _phoneController.text);
    _refreshDocteurs();
    print("...Nombre de docteur trouvé ${_docteurs.length}");
  }

  Future<void> _updateDoctor(int id) async {
    await SQLHelper.UpdateDoctor(
        id,
        _nomController.text,
        _specialiteController.text,
        _profileController.text,
        _emailController.text,
        _phoneController.text);
    _refreshDocteurs();
  }

  void _deleteDocteur(int id) async {
    await SQLHelper.DeleteDoctor(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Suppression du docteur avec succèss"),
      ),
    );
    _refreshDocteurs();
  }

  void _showform(int? id) async {
    if (id != null) {
      print(id);
      final existingDocteur =
      _docteurs.firstWhere((element) => element['id'] == id);
      _nomController.text = existingDocteur['nom'];
      _specialiteController.text = existingDocteur['specialite'];
      _profileController.text = existingDocteur['profil'];
      _emailController.text = existingDocteur['email'];
      _phoneController.text = existingDocteur['phone'];

    }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Scaffold(
          resizeToAvoidBottomInset: true,
        body: Padding (
        padding:  EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom ,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Text(
                  "Ajout d'un docteur",
                  style: TextStyle(color: Color(MyColors.primary)),
                ),
              ),
              TextField(
                controller: _nomController,
                decoration:
                const InputDecoration(hintText: "Le nom du docteur"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _specialiteController,
                decoration: const InputDecoration(
                    hintText: "La specialité du docteur"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _profileController,
                decoration: const InputDecoration(hintText: "Le profile"),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: "Le mail"),
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(hintText: "Numéro de téléphone"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF44bd32)),
                onPressed: () async {
                  if (id == null) {
                    await _addDocteur();
                  }
                  if (id != null) {
                    await _updateDoctor(id);
                  }
                  _emailController.text = "";
                  _phoneController.text = "";
                  _nomController.text = "";
                  _specialiteController.text = "";
                  _profileController.text = "";

                  //close the bottom sheet
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? "Ajouter" : "Mettre à jour"),
              )
            ],
          ),
        )
        )
    );
  }

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
                      child: ListView.builder(
                          itemCount: _docteurs.length,
                          itemBuilder: (context, index) {
                            var docteur = _docteurs[index];
                            bool isLastElement = _docteurs.length + 1 == index;
                            return Card(
                              margin: !isLastElement
                                  ? const EdgeInsets.only(bottom: 20)
                                  : EdgeInsets.zero,
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      children: [
                                        const CircleAvatar(
                                          backgroundImage: AssetImage("assets/images/doctor1.png"),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              docteur['nom'],
                                              style: TextStyle(
                                                color: Color(MyColors.header01),
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              docteur["specialite"],
                                              style: TextStyle(
                                                color: Color(MyColors.grey02),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                     DateTimeCard(
                                      email:docteur['email'],
                                      phone:docteur['phone']
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(
                                          width: 220,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () =>{
                                                  _showform(_docteurs[index]['id']),
                                                },
                                                icon: const Icon(Icons.edit,color: Colors.teal),
                                              ),
                                              IconButton(
                                                  onPressed: ()=>{
                                                    _deleteDocteur(_docteurs[index]["id"]),
                                                  },
                                                  icon: const Icon(Icons.delete,color: Color(0xFFff7979)))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      )
                  )
              ]
            )
          ),
        floatingActionButton: FloatingActionButton (
            backgroundColor: Color(MyColors.primary),
            onPressed: () => {
              _showform(null)
            },
            child: const Icon(Icons.add)),
          );
      }
}

class DateTimeCard extends StatelessWidget {
  final String email;
  final String phone;
  const DateTimeCard({
    super.key,
    required this.email,
    required this.phone
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(MyColors.bg03),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.email,
                color: Color(MyColors.primary),
                size: 15,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                email,
                style: TextStyle(
                  fontSize: 12,
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.phone,
                color: Color(MyColors.primary),
                size: 17,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                phone,
                style: TextStyle(
                  color: Color(MyColors.primary),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}