import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/checkup.dart';

class CheckupService{

final CollectionReference checkupCollection = FirebaseFirestore.instance.collection('checkups');

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
  Stream<List<Checkup>> searchCheckupGiven_id(String id){
  return checkupCollection.where('id', isEqualTo: id)
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
  Stream<Checkup> getLastCheckupGiven_id(String id){
    Query q = checkupCollection.orderBy('datetime', descending: true).limit(1);
    return q.snapshots()
    .map((ds) => Checkup.fromJson(ds.docs.elementAt(0).data()));
  }



}