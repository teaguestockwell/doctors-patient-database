import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/checkup.dart';
import '../services/checkup_service.dart';
import '../util.dart';
import '../widgets/but.dart';
import '../widgets/checkup_para.dart';
import '../widgets/home_info.dart';
import 'checkup_add.dart';
import 'checkup_edit.dart';

class CheckupHome extends StatefulWidget {
  final String id;
  CheckupHome({@required this.id});
  @override
  _CheckupHomeState createState() => _CheckupHomeState();
}

class _CheckupHomeState extends State<CheckupHome> {
  var value;

  @override
    void initState() {
      super.initState();
      value = CheckupService().searchCheckupGivenPatientId(this.widget.id);
    }

    void addCheckup(){
      Navigator.push(
      context,
      MaterialPageRoute(
      builder: (_) => CheckupAdd(id: this.widget.id)
    ));
    }

  @override
 Widget build(BuildContext context) {
    return StreamProvider<List<Checkup>>.value(
      value: value,
      child: Scaffold(
        appBar: AppBar(title: Text('Patient Checkups')),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              HomeProvider(this.widget.id),
              LastCheckupParaProvider(id: this.widget.id),
              Center(child: But(text: 'Add Checkup', onpress: addCheckup)),
              CheckupList(),
            ]
          ),
        )
      ),
    );
  }
}

class CheckupList extends StatefulWidget {
  @override
  _CheckupListState createState() => _CheckupListState();
}

class _CheckupListState extends State<CheckupList> {

  void checkupEdit(String uuid){
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => CheckupEdit(uuid: uuid)
    ));
  }

  @override
  Widget build(BuildContext context) {
    final checkups = Provider.of<List<Checkup>>(context) ?? [];
    return 
      ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: checkups.length,
      itemBuilder: (_,i) {
        return Center(
          child: But(
            text: getChecupButtonText(checkups[i]),
            onpress: () => checkupEdit(checkups[i].uuid),
          )
        );
      },
    );
  }
}