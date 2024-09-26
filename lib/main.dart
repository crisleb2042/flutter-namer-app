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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
    var pair = appState.current;

    return Scaffold(
      body: Column( //  Defines Layout
        children: [
          Text('Here\'s a wicked random & AWESOME idea:'),  // ← Example change.
          BigCard(pair: pair),

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

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    //  Descendant widgets obtain the current theme's [ThemeData] object using [Theme.of].
    //  When a widget uses [Theme.of], it is automatically rebuilt if the theme later 
    //  changes, so that the changes can be applied.
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}