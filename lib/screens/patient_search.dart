import '../widgets/but.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';
import '../util.dart';

class PatientSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Patient>>.value(
      value: PatientService().patients,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(title: Text('Patient Search')),
        body: PatientList()
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
    return ListView.builder(

      itemCount: patients.length,
      itemBuilder: (_,i) {
        return Center(
          child: But(
            text: getPatientButtonText(patients[i]),
            //send to patient profile
            onpress: (){patients[i];},
          )
        );
      },
    );
  }
}