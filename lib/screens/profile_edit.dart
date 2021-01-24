
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';
import '../widgets/but.dart';

class ProfileEdit extends StatefulWidget {
  final String id;
  ProfileEdit({@required this.id});
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Stream<Patient> value;

  initState(){
    super.initState();
    value = PatientService().getPatient(this.widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Patient>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Patient Profile')),
        body: PatientFeilds(this.widget.id)
      )
    );
  }
}

class PatientFeilds extends StatefulWidget {
 final String id;
  PatientFeilds(this.id);
  @override
  _PatientFeildsState createState() => _PatientFeildsState();
}

class _PatientFeildsState extends State<PatientFeilds> {
  var service = PatientService();
  Patient pat;

  //copy the new key and value into a new patient
  void onChanged(String k, String v){
    pat = Patient.fromJson(pat.toMap..[k]=v);
  }

  void save(){
    service.createOrUpdate(pat.toMap, this.widget.id).then((_){ showSnack();});
  }

  void showSnack(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        height: Snackz.y, 
        child: Center(
          child: Text('Saved',style: Snackz.ts,
    )))));
  }

  Widget getFeild(int i, Map m){
    if(i < Patient.numFields){
      if(i > 0){
        final value = m.values.elementAt(i);
        final key = m.keys.elementAt(i);
        return TextField(
          controller: TextEditingController()..text = value,
          decoration: InputDecoration(labelText: key),
          onChanged: (s){onChanged(key,s);},
        );
      }else{
      return Text('id: ${m['id']}');
      }
    }else{
    return But(text: 'Save', onpress: save);
    }
  }

  @override
  Widget build(BuildContext context) {
 final patient = Provider.of<Patient>(context) ?? [];
  pat = patient;
  
    return Padding(
      padding: EdgeInsets.all(20),
      child:
      ListView.builder(
      shrinkWrap: true,
      itemCount: Patient.numFields+1,
      itemBuilder: (_,i) {
        return getFeild(i, (patient as Patient).toMap);
      }
     )
    );
  }
}
