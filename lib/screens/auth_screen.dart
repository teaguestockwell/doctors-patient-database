import '../services/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/patient.dart';
import '../util.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text('Welcome')),
      body: StreamProvider(
        create: (BuildContext context) => getPatientList(),
        child: AuthBody(),
      ),
    );
  }
}

class AuthBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List patients = Provider.of<List<Patient>>(context);

    return ListView.builder(
      itemCount: patients.length,
      itemBuilder: (_,i){
        return Padding(
          padding: EdgeInsets.all(5),
          child: Container(
            color: theme.cardColor,
            height: 150,
            child: Center(
              child: Text(getPatientButtonText(patients[i])),
            )
          )
        );
      },
    );
  
  }
}