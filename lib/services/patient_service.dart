import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctors_patient_database/services/checkup_service.dart';
import '../models/patient.dart';

class PatientService{
  String id;
  PatientService({this.id});

  final CollectionReference patientsCollection = FirebaseFirestore.instance.collection('patients');

  ///model stream factory
  List<Patient> _patientListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc){
        return Patient.fromJson(doc.data());
      }
    ).toList();
  }

  ///
  Future<bool> isUniqueId(String id) async {
    QuerySnapshot rs = await patientsCollection.where('id', isEqualTo: id).get();
    return rs.docs.isEmpty;
  }

   ///create
   Future create(Map m) async{
    return patientsCollection.doc().set(m);
  }

  ///read one
  Stream<Patient> getPatient(String id){
    return patientsCollection.where('id', isEqualTo: id).snapshots().map(
      (qs) => Patient.fromJson(qs.docs.last.data())
    );
  }

  ///read many lazy matching
  Stream<List<Patient>> searchPatientName(String name){
    return patientsCollection.where('name', isGreaterThanOrEqualTo: name)
      .where('name', isLessThanOrEqualTo: name+ '\uf8ff')
      .snapshots().map(_patientListFromSnapshots);
  }

  // ///read many given
  // Stream<List<Patient>> getPatientById(String id){
  //   return patientsCollection.where('id', isEqualTo: id)
  //     .snapshots().map(_patientListFromSnapshots);
  // }
  
  ///read all
  Stream<List<Patient>> get patients {
    return patientsCollection.snapshots()
      .map(_patientListFromSnapshots);
  }
  

  ///update
   Future update(Map m, String id) async{
    return patientsCollection.doc(id).set(m);
  }

  ///delete where
  Future delete(String id) async {
    var query = patientsCollection.where('id', isEqualTo: id);
    return query.get().then((s) => 
    s.docs.forEach((d) => 
      d.reference.delete()
    )).then((_) => CheckupService().deleteWherePatientID(id));
  }
}