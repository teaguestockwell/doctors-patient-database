import 'package:doctors_patient_database/models/checkup.dart';
import 'package:doctors_patient_database/models/patient.dart';
import 'package:doctors_patient_database/screens/checkup_home.dart';
import 'package:doctors_patient_database/services/checkup_service.dart';
import 'package:doctors_patient_database/widgets/but.dart';
import 'package:doctors_patient_database/widgets/home_info.dart';
import 'profile_edit.dart';
import 'package:doctors_patient_database/services/patient_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHome extends StatefulWidget {
  final String id;
  ProfileHome({@required this.id});
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  Stream<Patient> value;
  
  @override
    void initState() {
      super.initState();
      value = PatientService().getPatient(this.widget.id);
    }

    void updateProfile(){
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (_) => ProfileEdit(id: this.widget.id)
      ));
    }

    void checkups(){
       Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => CheckupHome(patientid: this.widget.id,)
      ));
    }

  @override
  Widget build(BuildContext context) {
   return StreamProvider<Patient>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Patient Profile')),
        body: ListView(
          shrinkWrap: true,
          children: [

          Padding(
            padding: const EdgeInsets.all(10.0),
            child: HomeInfo(),
          ),

          // LastCheckup(),

          Center(child: But(text: 'Update Profile', onpress: updateProfile)),

          Center(child: But(text: 'Checkups', onpress: checkups))
        ])
      )
    );
  }
}



class LastCheckup extends StatefulWidget {
  final String patientid;
  LastCheckup({@required this.patientid});
  @override
  _LastCheckupState createState() => _LastCheckupState();
}

class _LastCheckupState extends State<LastCheckup> {
  var value;
  
  initState(){
    super.initState();
    value = CheckupService().getLastCheckupGiven_patientid(this.widget.patientid);
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Checkup>.value(
      value: value,
      child: LastCheckupBody()
    );
  }
}

class LastCheckupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkup = Provider.of<Checkup>(context) ?? Checkup();

    return ListView.builder(
      shrinkWrap: true,
      itemCount: Checkup.numFields,
      itemBuilder: (_,i) =>
Text('${checkup.toMap.keys.elementAt(i)}:  ${checkup.toMap.values.elementAt(i)}')
    );
  }
}