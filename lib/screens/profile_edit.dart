
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';
import '../widgets/but.dart';

class ProfileEdit extends StatefulWidget {
  final String patientid;
  ProfileEdit({@required this.patientid});
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  Stream<Patient> value;

  initState(){
    super.initState();
    value = PatientService().getPatientGivenPatientid(this.widget.patientid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Patient>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Patient')),
        body: PatientFeilds(this.widget.patientid)
      )
    );
  }
}

class PatientFeilds extends StatefulWidget {
 final String patientid;
  PatientFeilds(this.patientid);
  @override
  _PatientFeildsState createState() => _PatientFeildsState();
}

class _PatientFeildsState extends State<PatientFeilds> {
  final service = PatientService();
  Patient pat;

  //copy the new key and value into a new patient
  void onChanged(String k, String v){
    pat = Patient.fromJson(pat.toMap..[k]=v);
  }

  void save(){
    service.updateWherePatientid(pat.toMap, this.widget.patientid).then((_){ showSnack();});
  }

  void delete(){
    int count = 0;
    service.delete(this.widget.patientid).then(
      (_) => Navigator.popUntil(context, (route) {
      return count++ == 2;
      })
    );
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

      if(i==0){return Text('${pat.toMap.keys.elementAt(i)}: ${pat.toMap.values.elementAt(i)}');}
      
      final value = m.values.elementAt(i);
      final key = m.keys.elementAt(i);
      return TextField(
        controller: TextEditingController()..text = value,
        decoration: InputDecoration(labelText: key),
        onChanged: (s){onChanged(key,s);},
      );
    }

    if(i == Patient.numFields){
      return But(text: 'Save', onpress: save);
    }
    return But(text: 'Delete & Return', onpress: delete);
   }


  @override
  Widget build(BuildContext context) {
 final patient = Provider.of<Patient>(context) ?? Patient();
  pat = patient;
  
    return Padding(
      padding: EdgeInsets.all(20),
      child:
      ListView.builder(
      shrinkWrap: true,
      itemCount: Patient.numFields+2,
      itemBuilder: (_,i) {
        return getFeild(i, (patient).toMap);
      }
     )
    );
  }
}
