import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termoo/components/line.dart';
import 'package:termoo/providers/word.dart';

class Board extends StatelessWidget {
  Color getColorBoard(Word word, int position, String key) {
    var color = Colors.black54;
    if (word.blueLetters[position] == key) {
      color = Color.fromARGB(255, 29, 229, 240);
    } else if (word.yellowLetters[position] == key) {
      color = Color.fromARGB(255, 255, 165, 46);
    }
    return color;
  }

  List<Widget> getLines(int quantity, int line, BuildContext ctx) {
    final Word provider = Provider.of<Word>(ctx);
    final String wordLine = provider.wordsBoard[line + 1] as String;
    List<Widget> items = [];

    for (var i = 0; i < quantity; i++) {
      var text = wordLine.length > i ? wordLine[i] : "";
      //var color = getColorBoard(provider, i, text);
      var colors = provider.wordsBoard2[line + 1]?.values.first;
      print(colors);
      var selectedColor = Colors.black54;

      if (colors != null && colors.length > i) {
        selectedColor = colors[i] ?? Colors.black54;
      }

      items.add(Line(
        text,
        selectedColor,
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        height: 350,
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getLines(5, 0, context),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getLines(5, 1, context),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getLines(5, 2, context),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getLines(5, 3, context),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getLines(5, 4, context),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: getLines(5, 5, context),
          ),
        ]));
  }
}
