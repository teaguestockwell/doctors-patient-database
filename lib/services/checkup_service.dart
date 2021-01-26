import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/checkup.dart';

class CheckupService{

final CollectionReference checkupCollection = FirebaseFirestore.instance.collection('checkups');

 ///model stream factory
  List<Checkup> _checkupListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map(
      (doc){
        return Checkup.fromJson(doc.data());
      }
    ).toList();
  }

  ///create
   Future create(Map m) async{
    return checkupCollection.doc().set(m);
  }
  
  ///read one
  Stream<Checkup> getCheckupGivenCheckupid(String checkupid){
    return checkupCollection.where('checkupid', isEqualTo: checkupid).snapshots().map(
      (qs) => Checkup.fromJson(qs.docs.last.data())
    );
  }

  Stream<Checkup> getLastCheckup(String patientid) {
    Query q = checkupCollection
    .where("patientid", isEqualTo: patientid)
    .orderBy('datetime',descending: true)
    .limit(1);
   return q.snapshots().map((qs) => Checkup.fromJson(qs.docs.last.data()));
  }

  ///read many given
  Stream<List<Checkup>> searchCheckupGivenPatientId(String patientid){
  return checkupCollection.where('patientid', isEqualTo: patientid)
    .snapshots().map(_checkupListFromSnapshots);
  }

  ///read all
  Stream<List<Checkup>> get checkups {
    return checkupCollection.snapshots()
      .map(_checkupListFromSnapshots);
  }

  ///update all where uuid
  Future updateWhereCheckupid(Map m, String checkupid){
    var query = checkupCollection.where('checkupid', isEqualTo: checkupid);
    return query.get().then((s) => s.docs.forEach((d) => d.reference.set(m)));
  }

  ///delete all where
  Future deleteWhereCheckupid(String checkupid) async {
    var query = checkupCollection.where('checkupid', isEqualTo: checkupid);
    return query.get().then((s) => s.docs.forEach((d) => d.reference.delete()));
  }

  ///delete where
  Future deleteWherePatientID(String patientid) async {
    var query = checkupCollection.where('patientid', isEqualTo: patientid);
    return query.get().then((s) => 
    s.docs.forEach((d) => 
      d.reference.delete()
    ));
  }

}