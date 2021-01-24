import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';
import '../util.dart';
import '../widgets/but.dart';

class PatientSearch extends StatefulWidget {

  @override
  _PatientSearchState createState() => _PatientSearchState();
}

class _PatientSearchState extends State<PatientSearch> {
  var value = PatientService().searchPatientName('');

   void onSearch(String name){
    print(name);
    setState((){value = PatientService().searchPatientName(name);});
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Patient>>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Patient Search')),
        body: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextField(onChanged: onSearch, decoration: InputDecoration(labelText: 'Full Name Search: Case Sensative'),)
            ),
            PatientList()
          ]
        )
      ),
    );
  }
}

class PatientList extends StatefulWidget {
  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  @override
  Widget build(BuildContext context) {
    final patients = Provider.of<List<Patient>>(context) ?? [];
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child:
      ListView.builder(
      shrinkWrap: true,
      itemCount: patients.length,
      itemBuilder: (_,i) {
        return Center(
          child: But(
            text: getPatientButtonText(patients[i]),
            onpress: (){patients[i].id;},
          )
        );
      },
    ));
  }
}