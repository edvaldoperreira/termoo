import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termoo/components/line.dart';
import 'package:termoo/providers/word.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  Color getColorBoard(Word word, int position, int line, String key) {
    var color = Colors.black54;
    var greenLine = word.blueLetters[line + 1];
    var yellowLine = word.yellowLetters[line + 1];

    if (greenLine?[position] == key) {
      color = Colors.teal;
    } else if (yellowLine?[position] == key) {
      color = Colors.orangeAccent.shade700;
    }
    return color;
  }

  List<Widget> getLines(int quantity, int line, BuildContext ctx) {
    final Word provider = Provider.of<Word>(ctx);
    final String wordLine = provider.wordsBoard[line + 1] as String;
    List<Widget> items = [];
    bool currentLine = provider.currentLine == line + 1;

    var text = "";
    for (var i = 0; i < quantity; i++) {
      if (currentLine) {
        text = provider.positionLetters[i + 1] ?? "";
      } else {
        text = wordLine.length > i ? wordLine[i] : "";
      }
      var color =
          getColorBoard(provider, i, line, provider.removeDiacritics(text));
      items.add(Line(text, color, line, i));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        height: 400,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getLines(5, 0, context),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getLines(5, 1, context),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getLines(5, 2, context),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getLines(5, 3, context),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getLines(5, 4, context),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: getLines(5, 5, context),
            ),
          ),
        ]));
  }
}
