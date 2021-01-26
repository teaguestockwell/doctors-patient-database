import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';
import '../util.dart';
import '../widgets/but.dart';
import 'profile_add.dart';
import 'profile_home.dart';

class ProfileSearch extends StatefulWidget {

  @override
  _ProfileSearchState createState() => _ProfileSearchState();
}

class _ProfileSearchState extends State<ProfileSearch> {
  var value = PatientService().searchPatientName('patientid','');
  var k = TextEditingController(text: 'patientid');
  var v = TextEditingController(text: '');

  @override
  void dispose(){
    k.dispose();
    v.dispose();
    super.dispose();
  }

   void onSearch(_){
     String kk;
     // do not give api empty key, instead pass name
     if(k.text != ''){kk =k.text;}else{kk ='patientid';}
    setState((){value = PatientService().searchPatientName(kk,v.text);});
  }

  void profileAdd(){
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProfileAdd()
    ));
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Patient>>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Patient Search')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              
                TextField(
                  controller: k,
                  onChanged: onSearch,
                  decoration: InputDecoration(
                    labelText: 'Search Key: Case Sensative'
                  )
                ),
            
                TextField(
                  onChanged: onSearch,
                  controller: v,
                  decoration: InputDecoration(
                    labelText: 'Search Value: Case Sensative'
                  )
                ),
              
              Center(child: But(text: 'Add Patient', onpress: profileAdd)),
  
              ProfileList(),
            ]
          ),
        )
      ),
    );
  }
}

class ProfileList extends StatefulWidget {
  @override
  _ProfileListState createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

    void profileHome(String id){
     Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProfileHome(patientid: id)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final patients = Provider.of<List<Patient>>(context) ?? [];
    return 
      ListView.builder(
      shrinkWrap: true,
      itemCount: patients.length,
      itemBuilder: (_,i) {
        return Center(
          child: But(
            text: getPatientButtonText(patients[i]),
            onpress: () => profileHome(patients[i].patientid),
          )
        );
      },
    );
  }
}