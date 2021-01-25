import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/checkup.dart';

class CheckupService{

final CollectionReference checkupCollection = FirebaseFirestore.instance.collection('patients');

 ///checkup list from snapshot
  List<Checkup> _checkupListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc){
        print(doc.data());
        return Checkup.fromJson(doc.data());
      }
    ).toList();
  }

  ///get checkup streams
  Stream<List<Checkup>> get patients {
    return checkupCollection.snapshots()
      .map(_checkupListFromSnapshots);
  }

  ///search checkup with patien id
  // ignore: non_constant_identifier_names
  Stream<List<Checkup>> searchCheckupGiven_patientid(String patientid){
  return checkupCollection.where('patientid', isEqualTo: patientid)
    .snapshots().map(_checkupListFromSnapshots);
  }

  ///create update
   Future createOrUpdate(Map m, String id) async{
    return checkupCollection.doc(id).set(m);
  }

  ///read
  Stream<Checkup> getPatient(String id){
    return checkupCollection.doc(id).snapshots().map(
      (ds) => Checkup.fromJson(ds.data())
    );
  }

  ///delete
  Future delete(String id){
    return checkupCollection.doc(id).delete();
  }


  ///get latest checkup
  // ignore: non_constant_identifier_names
  Stream<Checkup> getLastCheckupGiven_patientid(String patientid){
    return checkupCollection.where('patientid', isEqualTo: patientid)
    .orderBy('patientid').limitToLast(1).snapshots().
    map(_checkupFromSnapshot);
  }

  ///the latest checkup
  Checkup _checkupFromSnapshot(QuerySnapshot qs){
    return qs.docs.map((doc) => Checkup.fromJson(doc.data())).last;
  }


}