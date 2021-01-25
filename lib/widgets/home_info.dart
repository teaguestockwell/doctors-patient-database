import 'package:doctors_patient_database/models/patient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pat = Provider.of<Patient>(context) ?? Patient();
    return ListView.builder(
      itemCount: Patient.numFields,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (_,i)
        => Text('${Patient().toMap.keys.elementAt(i)}: ${pat.toMap.values.elementAt(i)}')
    );
  }
}