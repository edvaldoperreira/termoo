import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termoo/providers/word.dart';

class Keyboard extends StatelessWidget {
  final String keyboard1 = "QWERTYUIOP";
  final String keyboard2 = "ASDFGHJKL";
  final String keyboard3 = "ZXCVBNM";
  final String keyboard4 = "";

  const Keyboard({Key? key}) : super(key: key);

  Color getColorKey(Word word, String key) {
    var color = Colors.black54;

    bool blue = false;
    for (var element in word.blueLetters.values) {
      if (element.values.contains(key)) {
        blue = true;
        break;
      }
    }

    bool yellow = false;
    for (var element in word.yellowLetters.values) {
      if (element.values.contains(key)) {
        yellow = true;
        break;
      }
    }

    if (blue) {
      color = Colors.teal;
    } else if (yellow) {
      color = Colors.orangeAccent.shade700;
    } else if (word.wrongLetters.contains(key)) {
      color = Colors.black26;
    }
    return color;
  }

  Widget addTecla(BuildContext ctx, String key) {
    final Word wordProvider = Provider.of<Word>(ctx);

    return Column(
      children: [
        GestureDetector(
          onTap: () => wordProvider.writeLetter(key),
          child: SizedBox(
            height: 50,
            width: key == "DEL"
                ? 70
                : key == "ENTER"
                    ? 100
                    : 36,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Container(
                  padding: EdgeInsets.all(MediaQuery.of(ctx).size.width / 55),
                  color: getColorKey(wordProvider, key),
                  child: Center(
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
          ),
        ),
      ],
    );
  }

  List<Widget> keyboard(BuildContext ctx, String letters) {
    List<Widget> keyboard = [];

    for (var i = 0; i < letters.length; i++) {
      keyboard.add(addTecla(ctx, letters[i]));
      if (letters[i] == "M") {
        keyboard.add(addTecla(ctx, "DEL"));
      }
      //if (letters[i] == "M") {
      //}
    }
    if (letters.isEmpty) keyboard.add(addTecla(ctx, "ENTER"));
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
        Row(
          children: keyboard(context, keyboard4),
        ),
      ],
    );
  }
}
