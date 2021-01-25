import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/checkup.dart';
import '../services/checkup_service.dart';

class LastCheckupParaProvider extends StatefulWidget {
  final String patientid;
  LastCheckupParaProvider({@required this.patientid});
  @override
  _LastCheckupParaProviderState createState() => _LastCheckupParaProviderState();
}

class _LastCheckupParaProviderState extends State<LastCheckupParaProvider> {
  var value;
  
  initState(){
    super.initState();
    value = CheckupService().getLastCheckupGivenPatientId(this.widget.patientid);
  }
  @override
  Widget build(BuildContext context) {
    return 
    StreamProvider<Checkup>.value(
      value: value,
      child: LastCheckupBody()
    );
  }
}

class LastCheckupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final checkup = Provider.of<Checkup>(context) ?? Checkup.empty();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: Checkup.numFields+1,
        itemBuilder: (_,i){

if(i==0){return Text('Last Checkup:');}
return Text('${checkup.toMap.keys.elementAt(i-1)}: ${checkup.toMap.values.elementAt(i-1)}');


        }
      ),
    );
  }
}