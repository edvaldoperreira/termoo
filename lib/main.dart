import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:termoo/components/board.dart';
import 'package:termoo/components/endgame.dart';
import 'package:termoo/providers/word.dart';

import 'components/keyboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = 'termoo';
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: Colors.brown.shade400),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (_) => Word(),
        )
      ], child: MyHomePage(title: title)),
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
  @override
  Widget build(BuildContext context) {
    final Word provider = Provider.of<Word>(context);

    var appBar = AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          icon: const Icon(Icons.skateboarding_rounded),
          onPressed: () => provider.harModeSwitch(),
        ),
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => provider.startGame(),
        ),
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          SizedBox(
            height: availableHeight * 0.60,
            child: const Board(),
          ),
          SizedBox(
            height: availableHeight * 0.10,
            child: const EndGame(),
          ),
          SizedBox(
            height: availableHeight * 0.30,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Keyboard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
