import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//  Every app is considered a Widget and they all contain a build() method
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

//  The ChangeNotifier Class is like a megaphone that shouts out to your app whenever 
//  something important changes, so everyone stays in the loop and up-to-date!
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // MyAppState is always being watched for updates, and if there is any change
    // to the appState, then the build() method will re-build
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column( //  Defines Layout
        children: [
          Text('Here\'s a wicked random & AWESOME idea:'),  // ← Example change.
          Text(appState.current.asLowerCase),

          ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}