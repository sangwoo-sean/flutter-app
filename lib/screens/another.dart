import 'package:flutter/material.dart';

class anotherRoute extends StatelessWidget {
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
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("another Route"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.pop(context);

          },
          child: Text("Go back!"),
        ),
      ),
    );
  }
}
