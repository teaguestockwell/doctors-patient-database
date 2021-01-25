import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/patient.dart';

class PatientService{
  String id;
  PatientService({this.id});

  final CollectionReference patientsCollection = FirebaseFirestore.instance.collection('patients');

  ///patient list from snapshot
  List<Patient> _patientListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc){
        print(doc.data());
        return Patient.fromJson(doc.data());
      }
    ).toList();
  }

  ///get patient streams
  Stream<List<Patient>> get patients {
    return patientsCollection.snapshots()
      .map(_patientListFromSnapshots);
  }
  
  ///given a pat name, return all streams of pat models that start with param
  Stream<List<Patient>> searchPatientName(String name){
    return patientsCollection.where('name', isGreaterThanOrEqualTo: name)
      .where('name', isLessThanOrEqualTo: name+ '\uf8ff')
      .snapshots().map(_patientListFromSnapshots);
  }

  ///get a stream of a patient given id
  Stream<List<Patient>> getPatientById(String id){
    return patientsCollection.where('id', isEqualTo: id)
      .snapshots().map(_patientListFromSnapshots);
  }

  ///update
   Future update(Map m, String id) async{
    return patientsCollection.doc(id).set(m);
  }

   ///create
   Future create(Map m) async{
    return patientsCollection.doc().set(m);
  }

  /// return of > 0 is a nonunique id
  Future<bool> isUniqueId(String id) async {
    QuerySnapshot rs = await patientsCollection.where('id', isEqualTo: id).get();
    bool ret = rs.docs.isEmpty; print(ret);
    return ret;
  }

  // ///read
  // Stream<Patient> getPatient(String id){
  //   return patientsCollection.doc(id).snapshots().map(
  //     (ds) => Patient.fromJson(ds.data())
  //   );
  // }

   ///read
  Stream<Patient> getPatient(String id){
    return patientsCollection.where('id', isEqualTo: id).snapshots().map(
      (qs) => Patient.fromJson(qs.docs.last.data())
    );

  }
  
  Future delete(String id) async {
    var query = patientsCollection.where('id', isEqualTo: id);
    return query.get().then((s) => 
    s.docs.forEach((d) => 
      d.reference.delete()
    ));
  }
}







