import "dart:ffi";

import "package:sqflite/sqflite.dart" as sql;
import "package:flutter/foundation.dart";

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""
      CREATE TABLE doctor(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nom TEXT,
      specialite TEXT,
      profil TEXT,
      email TEXT,
      phone TEXT
      )
  """);
  }
  static Future<void> createTablePatient(sql.Database database) async {
    await database.execute("""
      CREATE TABLE patient(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      nom TEXT,
      prenom TEXT,
      age TEXT,
      maladie TEXT,
      chambre TEXT,
      profil TEXT,
      contact TEXT,
      malade BOOLEAN DEFAULT TRUE,
      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
      out_date DATETIME
      )
  """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase('dbhospital.db', version: 1,
        onCreate: (sql.Database database, int version) async {
          print("Creating a table");
          await createTables(database);
          await createTablePatient(database);
        });
  }
  //Add doctor to the database
  static Future<int> createPatient(
      String nom, String prenom,String age, String maladie,String chambre,String profil,
      String contact) async {
    final db = await SQLHelper.db();
    final data = {'nom': nom, 'prenom': prenom, 'age':age,"maladie":maladie,"chambre":chambre,
      "profil":profil,"contact":contact};
    final id = await db.insert('patient', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  //Add doctor to the database
  static Future<int> createDoctor(
      String nom, String specialite,String profil, String email,String phone) async {
    final db = await SQLHelper.db();
    final data = {'nom': nom, 'specialite': specialite, 'profil': profil,'email':email,'phone':phone};
    final id = await db.insert('doctor', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }
  //Get all doctors from the database
  static Future<List<Map<String, dynamic>>> getPatients() async {
    final db = await SQLHelper.db();
    return db.query('patient', orderBy: "id");
  }

  //Get all patient from the database
  static Future<List<Map<String, dynamic>>> getDoctors() async {
    final db = await SQLHelper.db();
    return db.query('doctor', orderBy: "id");
  }

  //Get one patient from the database
  static Future<List<Map<String, dynamic>>> getPatient(int id) async {
    final db = await SQLHelper.db();
    return db.query('patient', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<List<Map<String, dynamic>>> getDoctor(int id) async {
    final db = await SQLHelper.db();
    return db.query('doctor', where: 'id = ?', whereArgs: [id], limit: 1);
  }

  static Future<int> UpdatePatient(
      int id, String nom, String prenom,String age, String maladie,String chambre,String profil,String contact) async {
    final db = await SQLHelper.db();
    final data = {
      'nom':nom,
      'prenom':prenom,
      'age' : age,
      'maladie':maladie,
      'chambre':chambre,
      'profil':profil,
      'contact':contact
    };
    final result  = await db.update('patient',data,where:"id = ?",whereArgs:[id]);
    return result;
  }
  static Future<int> PatientGood(
      int id) async {
    final db = await SQLHelper.db();
    final data = {
      'malade':false,
      'out_date':DateTime.now()
    };
    final result  = await db.update('patient',data,where:"id = ?",whereArgs:[id]);
    return result;
  }
  //Update the doctor in the database
  static Future<int> UpdateDoctor(
      int id, String nom, String specialite,String profil, String email,String phone) async {
    final db = await SQLHelper.db();
    final data = {
      'nom':nom,
      'specialite':specialite,
      'profil':profil,
      'email' :email,
      'phone':phone
    };
    final result  = await db.update('doctor',data,where:"id = ?",whereArgs:[id]);
    return result;
  }
  static Future<void> DeleteDoctor(int id) async {
    final db = await SQLHelper.db();
    try {
      final result = await db.delete("doctor",where:"id = ?",whereArgs: [id]);
    } catch (error) {
      debugPrint("Une erreur a été survenu lors du suppression de votre docteur");
    }
  }
  static Future<void> DeletePatient(int id) async {
    final db = await SQLHelper.db();
    try {
      final result = await db.delete("patient",where:"id = ?",whereArgs: [id]);
    } catch (error) {
      debugPrint("Une erreur a été survenu lors du suppression de votre patient");
    }
  }
}