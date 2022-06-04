import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:termoo/components/board.dart';

import 'components/keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'termoo';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.brown.shade400),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String keyboardPress = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => {},
          ),
        ],
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 50),
        child: Column(
          children: [
            const Board(),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (true)
                  const Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.white,
                  ),
                if (false)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Theme.of(context).primaryColor,
                      child: Text(
                        "word.messageWin",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                if (false)
                  Row(
                    children: [
                      const Icon(
                        Icons.sentiment_very_dissatisfied_outlined,
                        color: Colors.white,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          color: Colors.blue.shade800,
                          child: Text(
                            "A palavra era: word",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  )
              ],
            ),
            const Spacer(),
            Text(keyboardPress),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Keyboard(keyboardPress),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
