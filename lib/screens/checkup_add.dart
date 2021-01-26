import 'package:flutter/material.dart';
import '../models/checkup.dart';
import '../services/checkup_service.dart';
import '../widgets/but.dart';

class CheckupAdd extends StatefulWidget {
  final String patientid;
  CheckupAdd({@required this.patientid});
  @override
  _CheckupAddState createState() => _CheckupAddState();
}

class _CheckupAddState extends State<CheckupAdd> {
  Checkup check;

  @override
  void initState(){
    super.initState();
     check = Checkup(patientid: this.widget.patientid);
  }
  final service = CheckupService();
  
  void save(){
    service.create(check.toMap).then((_){
       Navigator.pop(context);
    });
  }

   void onChanged(String k, String v){
    check = Checkup.fromJson(check.toMap..[k]=v);
  }

  Widget getField(int i, Map m){
    if(i < Checkup.numFields ){
      if(i==0){return Text('${check.toMap.keys.elementAt(i)}: ${check.toMap.values.elementAt(i)}');}
      if(i==1){return Text('${check.toMap.keys.elementAt(i)}: ${check.toMap.values.elementAt(i)}');}

      final value = m.values.elementAt(i);
      final key = m.keys.elementAt(i);
      return TextField(
        controller: TextEditingController()..text = value,
        decoration: InputDecoration(labelText: key),
        onChanged: (s){onChanged(key,s);},
      );
    }
    return But(text: 'Add Checkup & Return', onpress: save);
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Checkup')),
        body: Padding(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: Checkup.numFields+1,
        itemBuilder: (_,i) {
          return getField(i, check.toMap);
        }
        )
      ) 
    );
  }
}