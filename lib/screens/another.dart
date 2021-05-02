import 'package:flutter/material.dart';

class anotherRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
