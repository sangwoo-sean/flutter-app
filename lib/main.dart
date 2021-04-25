import 'package:flutter/material.dart';
import 'package:flutter_intro/data/join_or_login.dart';
import 'package:flutter_intro/screens/login.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<JoinOrLogin>.value(
        value: JoinOrLogin(),
          child: AuthPage()
      ),
    );
  }

}