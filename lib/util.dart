
import 'package:intl/intl.dart';
import 'models/checkup.dart';
import 'models/patient.dart';

String getDateTime(String dt){
  var ret = dt.trim();
  if(ret.length == 12){
    var year = ret.substring(0,4);
    var month = ret.substring(4,6);
    var day = ret.substring(6,8);
    var hh = ret.substring(8,10);
    var mm = ret.substring(10,12);
    return '${year}-${month}-${day} ${hh}:${mm}';
  }
  return 'Invalid Date';
}

String getAge(String dob){
  dob = dob.trim();
  if(dob.length == 12){
    try{
      final then = DateTime(
        int.parse(dob.substring(0,4)),//year
        int.parse(dob.substring(5,6)),//month
        int.parse(dob.substring(7,8)),//day
        int.parse(dob.substring(9,10)),//hh
        int.parse(dob.substring(11,12)),//mm
      );

      var now = DateTime.now();
      int age  = now.year - then.year;

      if(then.month > now.month){age--;}
      else if(
        then.month == now.month
        && then.day > now.day
      ){
        age--;
      } 
      return age.toString();
    } 
    // ignore: avoid_catches_without_on_clauses
    catch(_){return 'Invalid DOB';}
  }
  return 'Invald DOB';
  } 


String getPatientButtonText(Patient p){
  String age = getAge(p.dob);
  return 'name: ${p.name}\ngender: ${p.gender}\nage: ${age}\nssn: ${p.ssn}';
}

String getChecupButtonText(Checkup c){
  String dt = getDateTime(c.datetime);
  return '${dt}\ndoctor: ${c.doctor}';
}

