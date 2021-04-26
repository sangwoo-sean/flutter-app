import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_intro/data/join_or_login.dart';
import 'package:flutter_intro/helper/login_background.dart';
import 'package:flutter_intro/screens/forget_pw.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: LoginBackground(
                isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _logoImage,
              Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              Consumer<JoinOrLogin>(
                builder: (BuildContext context, JoinOrLogin joinOrLogin,
                        Widget child) =>
                    GestureDetector(
                        onTap: () {
                          joinOrLogin.toggle();
                        },
                        child: Text(
                          joinOrLogin.isJoin ? "Go back to Login" : "Sign in",
                          style: TextStyle(
                              color: joinOrLogin.isJoin
                                  ? Colors.redAccent
                                  : Colors.lightBlue),
                        )),
              ),
              Container(
                height: size.height * 0.05,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _inputForm(Size size) => Padding(
        // 입력폼
        padding: EdgeInsets.all(size.width * 0.05),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12, top: 12, bottom: 32),
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    TextFormField(
                      obscureText: true,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          icon: Icon(Icons.vpn_key), labelText: "Password"),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "비밀번호를 입력하세요";
                        }
                        return null;
                      },
                    ),
                    Container(
                      height: 8,
                    ),
                    Consumer<JoinOrLogin>(
                      builder: (context, value, child) => Opacity(
                          opacity: value.isJoin ? 0 : 1,
                          child: GestureDetector(
                              onTap: value.isJoin ? null : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ForgetPw()));
                              },
                              child: Text("비밀번호 찾기"))),
                    ),
                  ],
                )),
          ),
        ),
      );

  Widget _authButton(Size size) => Positioned(
        // 로그인버튼
        left: size.width * 0.15,
        right: size.width * 0.15,
        bottom: 0,
        child: SizedBox(
          height: 50,
          child: Consumer<JoinOrLogin>(
            builder: (context, value, chold) => ElevatedButton(
                child: Text(value.isJoin ? "Join" : "Login"),
                style: ElevatedButton.styleFrom(
                    primary: value.isJoin ? Colors.redAccent : Colors.lightBlue,
                    onPrimary: Colors.white,
                    textStyle: TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    value.isJoin ? _register(context) : _login(context);
                    _emailController.text.toString();
                    _passwordController.text.toString();
                  }
                }),
          ),
        ),
      );

  Widget get _logoImage => Expanded(
        // 로그인창 이미지
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
          child: FittedBox(
            fit: BoxFit.contain,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://cdn.dribbble.com/users/31664/screenshots/1407208/page-gif.gif"),
            ),
          ),
        ),
      );

  void _register(BuildContext context) async {
    // 회원가입
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, '비밀번호가 너무 짧습니다.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, '이미 존재하는 이메일입니다.');
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    showSnackBar(context, '회원가입이 완료되었습니다.');
  }

  void _login(BuildContext context) async {
    // 로그인
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      print(userCredential.user.email);
      print("Login success");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void showSnackBar(BuildContext context, String text){
    final snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}
