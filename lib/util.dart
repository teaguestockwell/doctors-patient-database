
import 'models/checkup.dart';
import 'models/patient.dart';

String getDateTime(int dt){
if(dt != null){
  var ret = dt.toString();
  if(ret.length == 12){
    var year = ret.substring(0,3);
    var month = ret.substring(4,5);
    var day = ret.substring(6,7);
    var hh = ret.substring(8,9);
    var mm = ret.substring(10,11);
    return '${year}-${month}-${day} ${hh}:${mm}';
  }
}
  return 'Invalid Date';
}

String getAge(String dob){
  if(dob != null){
  var ret = dob;
  if(ret.length == 12){
    var year = int.parse(ret.substring(0,4));
    var month = int.parse(ret.substring(5,6));
    var day =  int.parse(ret.substring(7,8));
    var hh =  int.parse(ret.substring(9,10));
    var mm =  int.parse(ret.substring(11,12));
    var now = DateTime.now();
    var then = DateTime(year,month,day,hh,mm);
    int age  = now.year - then.year;
    if(then.month > now.month){
      age--;
    } else if(then.month == now.month){
      if(then.day > now.day){
        age--;
      }
    }
    return age.toString();
  }
}
  return 'Invalid Age';
}

String getPatientButtonText(Patient p){
  if(p.name != null && p.gender != null && p.dob !=null){
    if(getAge(p.dob) != 'Invalid Age'){
      var age = getAge(p.dob);
      return '${p.name}, ${p.gender}, ${age}';
    }
  }
  return 'Invalid Patient';
}

String getChecupButtonText(Checkup c){
  return 'datetime: ${c.datetime}, Doc: ${c.doctor}';
}

