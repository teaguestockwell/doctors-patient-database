import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/checkup.dart';
import '../services/checkup_service.dart';
class PastTripsView extends StatelessWidget {
  final String patientid;
  PastTripsView(this.patientid);

  Stream<QuerySnapshot> qStream() {
    CheckupService().checkupCollection
    .where("patientid", isEqualTo: patientid)
    .orderBy('datetime',descending: true)
    .limit(1)
    .snapshots();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container( 
        child:StreamBuilder(
          stream: qStream(),
          builder: (_,s) {
            Checkup c; 
            if (!s.hasData && s.data != null){c=Checkup.fromJson(s.data.docs.last.data());}
            else{c = Checkup.empty();}
            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: Checkup.numFields+1,
              itemBuilder: (_,i) {
                if(i==0){return Text('Last Checkup:');}
                return Text('${c.toMap.keys.elementAt(i-1)}: ${c.toMap.values.elementAt(i-1)}');
              }
            );
          }
        ),
      ),
    );
  }
}