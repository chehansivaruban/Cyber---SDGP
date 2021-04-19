import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:solarexlogin/Start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.orange),
      debugShowCheckedModeBanner: false,
      home: Start(),
      // routes: <String, WidgetBuilder>{
      //   "Login": (BuildContext context) => Login(),
      //   "SignUp": (BuildContext context) => SignUp(),
      //   "start": (BuildContext context) => Start(),
      // },
    );
  }
}
