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
  var value = PatientService().searchPatientName('');

   void onSearch(String name){
    setState((){value = PatientService().searchPatientName(name);});
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
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            //physics: NeverScrollableScrollPhysics(),
            children: [
              
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: TextField(
                  onChanged: onSearch,
                  decoration: InputDecoration(
                    labelText: 'Full Name Search: Case Sensative'
                  )
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
      builder: (_) => ProfileHome(id: id)
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
            onpress: () => profileHome(patients[i].id),
          )
        );
      },
    );
  }
}