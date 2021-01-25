import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/patient.dart';
import '../services/patient_service.dart';


class HomeProvider extends StatefulWidget {
  final String id;
  HomeProvider(this.id);
  @override
  _HomeProviderState createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  var value;

  @override
  void initState(){
    super.initState();
    value = PatientService().getPatient(this.widget.id);
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Patient>.value(
      value: value,
      child: HomeInfo(),
    );
  }
}
class HomeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pat = Provider.of<Patient>(context) ?? Patient();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: Patient.numFields,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_,i)
          => Text('${Patient().toMap.keys.elementAt(i)}: ${pat.toMap.values.elementAt(i)}')
      ),
    );
  }
}