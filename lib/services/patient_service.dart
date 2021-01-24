import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseApp fb;

void initFirestore() async{
 fb = await Firebase.initializeApp();
}

//create new patient


//get a stream of a patient given id

//get all patients
Stream<List<Patient>> getPatientList() {
  if(fb == null){initFirestore();}
    return FirebaseFirestore.instance.collection('user')
        .snapshots()
        .map((snapShot) => snapShot.docs
        .map((doc) => Patient.fromJson(doc.data()))
        .toList());
  }


