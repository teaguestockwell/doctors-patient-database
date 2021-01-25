import 'package:doctors_patient_database/models/checkup.dart';
import 'package:doctors_patient_database/services/checkup_service.dart';
import 'package:doctors_patient_database/util.dart';
import 'package:doctors_patient_database/widgets/but.dart';
import 'package:doctors_patient_database/widgets/checkup_para.dart';
import 'package:doctors_patient_database/widgets/home_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      value = CheckupService().searchCheckupGiven_id(this.widget.id);
    }

    void addCheckup(){

    }

    void updateCheckup(){

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

  void checkupEdit(String id){
    // Navigator.push(
    // context,
    // MaterialPageRoute(
    //   builder: (_) => CheckupEdit(id: id)
    // ));
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
        print('checkup builder: '+ checkups[i].toMap.toString());
        return Center(
          child: But(
            text: getChecupButtonText(checkups[i]),
            onpress: () => checkupEdit(checkups[i].id),
          )
        );
      },
    );
  }
}