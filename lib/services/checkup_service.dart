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
  Stream<Checkup> getCheckupGivenUuid(String uuid){
    return checkupCollection.where('uuid', isEqualTo: uuid).snapshots().map(
      (qs) => Checkup.fromJson(qs.docs.last.data())
    );
  }

  ///read newest latest date at id
  // ignore: non_constant_identifier_names
  Stream<Checkup> getLastCheckupGiven_id(String id){
    Query q = checkupCollection.orderBy('datetime', descending: true).limit(1);
    return q.snapshots()
    .map((ds) => Checkup.fromJson(ds.docs.elementAt(0).data()));
  }

  ///read many given
  Stream<List<Checkup>> searchCheckupGivenPatientId(String id){
  return checkupCollection.where('patientid', isEqualTo: id)
    .snapshots().map(_checkupListFromSnapshots);
  }

  ///read all
  Stream<List<Checkup>> get checkups {
    return checkupCollection.snapshots()
      .map(_checkupListFromSnapshots);
  }

  ///update
   Future update(Map m, String id) async{
    return checkupCollection.doc(id).set(m);
  }

  ///delete where
  Future deleteWhereUuid(String uuid) async {
    var query = checkupCollection.where('uuid', isEqualTo: uuid);
    return query.get().then((s) => 
    s.docs.forEach((d) => 
      d.reference.delete()
    ));
  }

  ///delete where
  Future deleteWherePatientID(String patientid) async {
    var query = checkupCollection.where('id', isEqualTo: patientid);
    return query.get().then((s) => 
    s.docs.forEach((d) => 
      d.reference.delete()
    ));
  }

}