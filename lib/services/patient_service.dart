import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient.dart';

class PatientService{
  String id;
  PatientService({this.id});

  final CollectionReference patientsCollection = FirebaseFirestore.instance.collection('patients');
  //create new patient


  //get a stream of a patient given id

  //patient list from snapshot
  List<Patient> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc){
        print(doc.data());
        return Patient.fromJson(doc.data());
      }
    ).toList();
  }

  //get patient streams
  Stream<List<Patient>> get patients {
    return patientsCollection.snapshots()
      .map(_brewListFromSnapshot);
  }

  //
}


