import 'package:doctors_patient_database/util.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test(
    'given an dob string, when get age is called, age will return', (){
      expect(
        getAge('199901010101'), // 1999-01-01 0101
        '22'
      );
    }
  );
}