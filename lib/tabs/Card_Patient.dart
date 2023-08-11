import 'package:flutter/material.dart';
import 'package:learn2/sql/sql_helper.dart';
import 'package:flutter/material.dart';
import '/styles/colors.dart';
import '/styles/styles.dart';
import "../sql/sql_helper.dart";
import "./Card_doctor.dart";
import "./Card_Patient.dart";


class CardPatient extends StatefulWidget {
  @override
  _CardPatient createState()=>_CardPatient();
}

class _CardPatient extends State<CardPatient> {
  List<Map<String ,dynamic>> _patients = [];
  bool _isloading = true;

  void _refreshPatient() async {
    final data = await SQLHelper.getPatients();
    setState(() {
      _patients = data;
      _isloading = false;
    });
}
  @override
  void initState(){
    super.initState();
    _refreshPatient();
    print("...Nombre de patient trouvé ${_patients.length}");
  }

  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _maladieController = TextEditingController();
  final TextEditingController _chambreController = TextEditingController();
  final TextEditingController _profilController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  Future<void> _addPatient() async {
    await SQLHelper.createPatient(_nomController.text,
        _prenomController.text, _ageController.text,_maladieController.text,_chambreController.text,_profilController.text,_contactController.text);
    _refreshPatient();
    print("...Nombre de docteur trouvé ${_patients.length}");
  }
  void _showform(int? id) async {
    if (id != null) {
      final existingPatient = _patients.firstWhere((element) => element['id'] == id);
      _nomController.text = existingPatient['nom'];
      _prenomController.text = existingPatient['prenom'];
      _ageController.text = existingPatient['age'].toString();
      _maladieController.text  = existingPatient['maladie'];
      _chambreController.text = existingPatient['chambre'];
      _profilController.text = existingPatient['profil'];
      _contactController.text = existingPatient['contact'];
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
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _nomController,
                decoration:
                const InputDecoration(hintText: "Le nom du patient"),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _prenomController,
                decoration: const InputDecoration(
                    hintText: "Prénom.."),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(hintText: "L'age du patient"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _maladieController,
                decoration: const InputDecoration(hintText: "La maladie  du patient"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _chambreController,
                decoration: const InputDecoration(hintText: "La chambre  du patient"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _profilController,
                decoration: const InputDecoration(hintText: "Le profil  du patient"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: _contactController,
                decoration: const InputDecoration(hintText: "Le numéro téléphone du patient"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await _addPatient();
                  } else if (id != null) {
                    await _updatePatient(id);
                  }
                  _nomController.text = "";
                  _prenomController.text = "";
                  _ageController.text = "";
                  _maladieController.text = "";
                  _chambreController.text="";
                  _profilController.text="";
                  _contactController.text="";

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

  void _deletePatient(int id) async {
    await SQLHelper.DeletePatient(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Suppression du patient avec succèss"),
      ),
    );
    _refreshPatient();
  }
  Future<void> _updatePatient(int id) async {
    await SQLHelper.UpdatePatient(
        id,
        _nomController.text,
        _prenomController.text,
        _ageController.text.toString(),
        _maladieController.text,
        _chambreController.text,
        _profilController.text,
        _contactController.text,

    );
    _refreshPatient();
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
              'Liste des patients',
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
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(8),
                  itemCount: _patients.length,
                  itemBuilder: (BuildContext context, int index) {
                    var patient = _patients[index];
                    bool isLastElement = _patients.length + 1 == index;
                    return Card(
                      color: Colors.white,
                      borderOnForeground: true,
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('assets/images/doctor1.png'),
                            ),
                            title: Text(patient["nom"],
                                style: const TextStyle(color: Colors.black54)),
                            subtitle: Text(
                              patient["prenom"],
                              style: const TextStyle(color: Colors.green),
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16), // Adjust the left padding value as needed
                                child: Row(
                                  children: [
                                    Text(
                                      "Age: ",
                                    ),
                                    Text(
                                      patient["age"].toString(),
                                      style: TextStyle(
                                        color: Colors.green, // Set the text color to green
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 16), // Adjust the left padding value as needed
                                child: Row(
                                  children: [
                                    Text(
                                      "Chambre: ",
                                    ),
                                    Text(
                                      patient["chambre"].toString(),
                                      style: TextStyle(
                                        color: Colors.green, // Set the text color to green
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children : [
                                    TextButton(
                                      child: const Icon(Icons.edit),
                                      onPressed: () {
                                        _showform(_patients[index]["id"]);
                                      },
                                    ),
                                    const SizedBox(width: 8),
                                    TextButton(
                                      child: const Icon(Icons.delete,color: Color(0xFFff0000)),
                                      onPressed: () {
                                        _deletePatient(_patients[index]["id"]);
                                      },
                                    ),
                                  ]
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )
            )]
            ),
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