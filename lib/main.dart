import 'package:flutter/material.dart';

import 'constant.dart';
import 'screens/auth_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      home: Center(child: AuthScreen())
    )
  );
}

