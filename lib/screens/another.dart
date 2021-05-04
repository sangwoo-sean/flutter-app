import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/main.dart';
import 'package:flutter_intro/screens/main_page.dart';

class anotherRoute extends StatelessWidget {

  anotherRoute({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(child: Text('Drawer Header'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            ),
            ListTile(
              title: Text("Item1"),
            ),
            ListTile(
              title: Text("close"),
              onTap: (){
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text("Logout"),
              onTap: (){
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Splash()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Hi, $email"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(email: email)));

          },
          child: Text("StartUp Name Generator"),
        ),
      ),
    );
  }


}
