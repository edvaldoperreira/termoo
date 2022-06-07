import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termoo/providers/word.dart';

class Keyboard extends StatelessWidget {
  final String keyboard1 = "QWERTYUIOP";
  final String keyboard2 = "ASDFGHJKL";
  final String keyboard3 = "ZXCVBNM";

  Color getColorKey(Word word, String key) {
    var color = Colors.black54;
    if (word.blueLetters.containsValue(key)) {
      color = Color.fromARGB(255, 29, 229, 240);
    } else if (word.yellowLetters.containsValue(key)) {
      color = Color.fromARGB(255, 255, 165, 46);
    }
    return color;
  }

  Widget addTecla(BuildContext ctx, String key) {
    final Word wordProvider = Provider.of<Word>(ctx);

    return Column(
      children: [
        GestureDetector(
          onTap: () => wordProvider.writeLetter(key),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
                color: getColorKey(wordProvider, key),
                child: Text(
                  key,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> keyboard(BuildContext ctx, String letters) {
    List<Widget> keyboard = [];

    for (var i = 0; i < letters.length; i++) {
      keyboard.add(addTecla(ctx, letters[i]));
      if (letters[i] == "L") {
        keyboard.add(addTecla(ctx, "DEL"));
      }
      if (letters[i] == "M") {
        keyboard.add(addTecla(ctx, "ENTER"));
      }
    }
    return keyboard;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: keyboard(context, keyboard1),
        ),
        Row(
          children: keyboard(context, keyboard2),
        ),
        Row(
          children: keyboard(context, keyboard3),
        ),
      ],
    );
  }
}
