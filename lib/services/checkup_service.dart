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
   Future update(Map m, String id) async{
    return checkupCollection.doc(id).set(m);
  }

  ///create update
   Future create(Map m) async{
    return checkupCollection.doc().set(m);
  }

  ///read
  // Stream<Checkup> getCheckup(String id){
  //   return checkupCollection.doc(id).snapshots().map(
  //     (ds) => Checkup.fromJson(ds.data())
  //   );
  // }

    Stream<Checkup> getCheckup(String id){
    return checkupCollection.where('id', isEqualTo: id).snapshots().map(
      (qs) => Checkup.fromJson(qs.docs.last.data())
    );

  }

  ///delete
  // Future delete(String id){
  //   return checkupCollection.doc(id).delete();
  // }

  Future delete(String id) async {
    var query = checkupCollection.where('id', isEqualTo: id);
    return query.get().then((s) => 
    s.docs.forEach((d) => 
      d.reference.delete()
    ));
  }

  ///get latest checkup
  // ignore: non_constant_identifier_names
  Stream<Checkup> getLastCheckupGiven_id(String id){
    Query q = checkupCollection.orderBy('datetime', descending: true).limit(1);
    return q.snapshots()
    .map((ds) => Checkup.fromJson(ds.docs.elementAt(0).data()));
  }



}