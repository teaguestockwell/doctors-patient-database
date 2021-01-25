import 'package:doctors_patient_database/models/checkup.dart';
import 'package:doctors_patient_database/services/checkup_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LastCheckupParaProvider extends StatefulWidget {
  final String id;
  LastCheckupParaProvider({@required this.id});
  @override
  _LastCheckupParaProviderState createState() => _LastCheckupParaProviderState();
}

class _LastCheckupParaProviderState extends State<LastCheckupParaProvider> {
  var value;
  
  initState(){
    super.initState();
    value = CheckupService().getLastCheckupGiven_id(this.widget.id);
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Checkup.numFields,
        itemBuilder: (_,i) =>
Text('${Checkup().toMap.keys.elementAt(i)}:  ${checkup.toMap.values.elementAt(i)}')
      ),
    );
  }
}