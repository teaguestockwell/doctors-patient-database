import 'package:doctors_patient_database/screens/profile_edit.dart';
import 'package:doctors_patient_database/screens/profile_home.dart';
import 'package:doctors_patient_database/screens/profile_search.dart';

import 'screens/profile_add.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: ProfileSearch()
      //home: LastCheckup(id:'234567890')
    )
  );
}


