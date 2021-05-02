import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_intro/screens/another.dart';

class MainPage extends StatelessWidget {
  MainPage({this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primaryColor: Colors.redAccent,
      ),
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
  final _suggestions = <WordPair>[]; //
  final _saved = <WordPair>{}; // 저장될 세트
  final _biggerFont = TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: [ // 리스트표시
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
          IconButton(icon: Icon(Icons.arrow_circle_up), onPressed: _movePage),
        ]
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
          final index = i ~/
              1; // 1, 2, 3, 4, 5 => 1//2, 2//2, 3//2, 4//2, 5//2 => 0, 1, 1, 2, 2 (단어가 pair이기때문에 실제 단어갯수를 표기해줌)
          if (index >= _suggestions.length) {
            _suggestions
                .addAll(generateWordPairs().take(10)); // 끝까지 내리면 10개 더 생성
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      MaterialPageRoute<void>(
          builder: (BuildContext context){
            final tiles = _saved.map(
                    (WordPair pair) {
                      return ListTile(
                        title: Text(
                          pair.asPascalCase,
                          style: _biggerFont,
                        ),
                      );
                    },
            );
            final divided = ListTile.divideTiles(
              context: context,
                tiles: tiles,
            ).toList();

            return Scaffold(
              appBar: AppBar(
                title: Text('좋아요'),
              ),
              body: ListView(children: divided,)
            );
          },
      ),
    );

  }

  void _movePage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => anotherRoute()),
    );
  }
}