import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'screens/profile_search.dart';

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


