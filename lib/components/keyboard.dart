import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  String currentKey;

  Keyboard(this.currentKey, {Key? key}) : super(key: key);

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  final String keyboard1 = "QWERTYUIOP";

  final String keyboard2 = "ASDFGHJKL";

  final String keyboard3 = "ZXCVBNM";

  Widget addTecla(BuildContext ctx, String key) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              widget.currentKey = key;
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                color: Colors.black54,
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
