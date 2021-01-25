import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../models/checkup.dart';
import '../services/checkup_service.dart';
import '../widgets/but.dart';

class CheckupEdit extends StatefulWidget {
  final String checkupid;
  CheckupEdit({@required this.checkupid});
  @override
  _CheckupEditState createState() => _CheckupEditState();
}

class _CheckupEditState extends State<CheckupEdit> {
  var value;

  initState(){
    super.initState();
    value = CheckupService().getCheckupGivenCheckupid(this.widget.checkupid);
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Checkup>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Edit Checkup')),
        body: CheckupFields(this.widget.checkupid)
      )
    );
  }
}

class CheckupFields extends StatefulWidget {
 final String checkupid;
  CheckupFields(this.checkupid);
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
    service.updateWhereCheckupid(check.toMap, this.widget.checkupid).then((_){ showSnack();});
  }

  void delete(){
    service.deleteWhereCheckupid(check.checkupid).then(
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

      if(i==0){return Text('${check.toMap.keys.elementAt(i)}: ${check.toMap.values.elementAt(i)}');}
      if(i==1){return Text('${check.toMap.keys.elementAt(i)}: ${check.toMap.values.elementAt(i)}');}
      
      final value = m.values.elementAt(i);;
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
