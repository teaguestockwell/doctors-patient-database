import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constant.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      title: 'LPG Patient Care',
      theme: theme,
      home: Auth()
      //home: LastCheckup(id:'234567890')
    )
  );
}


