import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/checkup.dart';
import '../services/checkup_service.dart';
import '../widgets/but.dart';

class CheckupEdit extends StatefulWidget {
  final String uuid;
  CheckupEdit({@required this.uuid});
  @override
  _CheckupEditState createState() => _CheckupEditState();
}

class _CheckupEditState extends State<CheckupEdit> {
  var value;

  initState(){
    super.initState();
    value = CheckupService().getCheckupGivenUuid(this.widget.uuid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Checkup>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Checkup')),
        body: CheckupFields(this.widget.uuid)
      )
    );
  }
}

class CheckupFields extends StatefulWidget {
 final String uuid;
  CheckupFields(this.uuid);
  @override
  _CheckupFieldsState createState() => _CheckupFieldsState();
}

class _CheckupFieldsState extends State<CheckupFields> {
  final service = CheckupService();
  Checkup check;

  //copy the new key and value into a new Checkup
  void onChanged(String k, String v){
    check = Checkup.fromJson(check.toMap..[k]=v);
  }

  void save(){
    service.update(check.toMap, this.widget.uuid).then((_){ showSnack();});
  }

  void delete(){
    service.deleteWhereUuid(check.uuid).then(
      (_) => Navigator.pop(context)
    );
  }

  void showSnack(){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        height: Snackz.y, 
        child: Center(
          child: Text('Saved',style: Snackz.ts,
    )))));
  }

  Widget getFeild(int i, Map m){
    if(i < Checkup.numFields){

      if(i==0){return Text('uuid: ${m['uuid']}');}
      if(i==1){return Text('patientid: ${m['id']}');}
      
      final value = m.values.elementAt(i);
      final key = m.keys.elementAt(i);
      return TextField(
        controller: TextEditingController()..text = value,
        decoration: InputDecoration(labelText: key),
        onChanged: (s){onChanged(key,s);},
      );
    }

    if(i == Checkup.numFields){
      return But(text: 'Save', onpress: save);
    }
    return But(text: 'Delete & Return', onpress: delete);
   }


  @override
  Widget build(BuildContext context) {
    final checkup = Provider.of<Checkup>(context) ?? Checkup();
    check = checkup;
  
    return Padding(
      padding: EdgeInsets.all(20),
      child:
      ListView.builder(
      shrinkWrap: true,
      itemCount: Checkup.numFields+2,
      itemBuilder: (_,i) {
        return getFeild(i, checkup.toMap);
      }
     )
    );
  }
}
