import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/checkup.dart';
import '../services/checkup_service.dart';
class CheckupParaProvider extends StatefulWidget {
  final String patientid;
  CheckupParaProvider(this.patientid);
  @override
  _CheckupParaProviderState createState() => _CheckupParaProviderState();
}

class _CheckupParaProviderState extends State<CheckupParaProvider> {
  var value;

  @override
  void initState(){
    super.initState();
    value = CheckupService().getLastCheckup(this.widget.patientid);
  }
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Checkup>.value(
      value: value,
      child: Para(),
    );
  }
}
class Para extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pat = Provider.of<Checkup>(context) ?? Checkup.empty();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: Checkup.numFields+1,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_,i){
          if(i==0){return Center(child:Text('last checkup'));}
          return Text('${pat.toMap.keys.elementAt(i-1)}: ${pat.toMap.values.elementAt(i-1)}');
        }
      ),
    );
  }
}