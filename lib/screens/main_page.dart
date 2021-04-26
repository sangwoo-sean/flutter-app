import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MainPage extends StatelessWidget {

  MainPage({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: RandomWords(),
    );


    // return Scaffold(
    //     appBar: AppBar(
    //       title: Text(email)
    //     ),
    //     body: Container(
    //       child: TextButton(onPressed: (){
    //         FirebaseAuth.instance.signOut();
    //       }, child: Text("Logout"))
    //     )
    // );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(); // 홀수줄마다 디바이더로 칸나누기

          // final index = i ~/ 2; // 1, 2, 3, 4, 5 => 1//2, 2//2, 3//2, 4//2, 5//2 => 0, 1, 1, 2, 2 (단어가 pair이기때문에 실제 단어갯수를 표기해줌)
          final index = i ~/ 1; // 1, 2, 3, 4, 5 => 1//2, 2//2, 3//2, 4//2, 5//2 => 0, 1, 1, 2, 2 (단어가 pair이기때문에 실제 단어갯수를 표기해줌)
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));  // 끝까지 내리면 10개 더 생성
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }


}