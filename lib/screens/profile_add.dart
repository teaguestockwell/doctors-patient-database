import 'package:doctors_patient_database/models/patient.dart';
import 'package:doctors_patient_database/services/patient_service.dart';
import 'package:doctors_patient_database/widgets/but.dart';
import 'package:flutter/material.dart';

class ProfileAdd extends StatefulWidget {
  @override
  _ProfileAddState createState() => _ProfileAddState();
}

class _ProfileAddState extends State<ProfileAdd> {
  Patient pat = Patient();
  final service = PatientService();
  
  void save(){
    service.createOrUpdate(pat.toMap, pat.id).then((_){
       // navigate back a screen here
       Navigator.pop(context);
    });
  }

   void onChanged(String k, String v){
    pat = Patient.fromJson(pat.toMap..[k]=v);
  }

  Widget getField(int i, Map m){
    if(i < Patient.numFields){
      final value = m.values.elementAt(i);
      final key = m.keys.elementAt(i);
      return TextField(
        controller: TextEditingController()..text = value,
        decoration: InputDecoration(labelText: key),
        onChanged: (s){onChanged(key,s);},
      );
    }
    return But(text: 'Add Patient & Return', onpress: save);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Patient')),
        body: Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Patient.numFields+1,
        itemBuilder: (_,i) {
          return getField(i, pat.toMap);
        }
        )
      ) 
    );
  }
}