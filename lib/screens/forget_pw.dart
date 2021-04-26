import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                  icon: Icon(Icons.account_circle), labelText: "Email"),
              validator: (String value) {
                if (value.isEmpty) {
                  return "없는 이메일입니다.";
                }
                return null;
              },
            ),
            TextButton(onPressed: ()async{
              await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text);
              final snackBar = SnackBar(
                content: Text('비밀번호 초기화를 위해 메일함을 확인하세요.'),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }, child: Text('Reset Password'))
          ]
        ),
      ),
    );
  }
}
