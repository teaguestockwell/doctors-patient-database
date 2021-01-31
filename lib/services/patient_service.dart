import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient.dart';
import 'checkup_service.dart';

class PatientService{


  final CollectionReference patientsCollection = FirebaseFirestore.instance.collection('patients');

  ///model stream factory
  List<Patient> _patientListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc){
        return Patient.fromJson(doc.data());
      }
    ).toList();
  }

   ///create
   Future create(Map m) async{
    return patientsCollection.doc().set(m);
  }

  ///read one
  Stream<Patient> getPatientGivenPatientid(String patientid){
    return patientsCollection.where('patientid', isEqualTo: patientid).snapshots().map(
      (qs) => Patient.fromJson(qs.docs.last.data())
    );
  }

  ///read many lazy matching
  Stream<List<Patient>> searchPatientName(String k, String v){
    return patientsCollection.where(k, isGreaterThanOrEqualTo: v)
      .where(k, isLessThanOrEqualTo: v+ '\uf8ff')
      .snapshots().map(_patientListFromSnapshots);
  }

  ///read all
  Stream<List<Patient>> get patients {
    return patientsCollection.snapshots()
      .map(_patientListFromSnapshots);
  }
  

   Future updateWherePatientid(Map m, String patientid){
    var query = patientsCollection.where('patientid', isEqualTo: patientid);
    return query.get().then((s) => s.docs.forEach((d) => d.reference.set(m)));
  }

  ///delete where
  Future delete(String patientid) async {
    var query = patientsCollection.where('patientid', isEqualTo: patientid);
    return query.get().then((s) => 
    s.docs.forEach((d) => 
      d.reference.delete()
    )).then((_) => CheckupService().deleteWherePatientID(patientid));
  }
}