import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../screens/checkup_home.dart';
import '../services/patient_service.dart';
import '../widgets/but.dart';
import '../widgets/checkup_para.dart';
import '../widgets/home_info.dart';
import 'profile_edit.dart';

class ProfileHome extends StatefulWidget {
  final String patientid;
  ProfileHome({@required this.patientid});
  @override
  _ProfileHomeState createState() => _ProfileHomeState();
}

class _ProfileHomeState extends State<ProfileHome> {
  Stream<Patient> value;
  
  @override
    void initState() {
      super.initState();
      value = PatientService().getPatientGivenPatientid(this.widget.patientid);
    }

    void updateProfile(){
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (_) => ProfileEdit(patientid: this.widget.patientid)
      ));
    }

    void checkups(){
       Navigator.push(
      context,
      MaterialPageRoute(
      builder: (context) => CheckupHome(patientid: this.widget.patientid,)
      ));
    }

  @override
  Widget build(BuildContext context) {
   return StreamProvider<Patient>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Patient Profile')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            shrinkWrap: true,
            children: [
            HomeProvider(this.widget.patientid),
            //PastTripsView(this.widget.patientid),
            CheckupParaProvider(this.widget.patientid),
            Center(child: But(text: 'Update Profile', onpress: updateProfile)),
            Center(child: But(text: 'Checkups', onpress: checkups))
          ]),
        )
      )
    );
  }
}



