import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:termoo/providers/word.dart';

class Line extends StatelessWidget {
  final String text;
  final Color color;
  final int line;
  final int position;
  const Line(this.text, this.color, this.line, this.position, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Word provider = Provider.of<Word>(context);
    bool currentPosition = position + 1 == provider.currentPosition &&
        line + 1 == provider.currentLine;
    bool currentLine = line + 1 == provider.currentLine;

    return GestureDetector(
      onTap: () => provider.setPosition(line + 1, position + 1),
      child: Container(
        decoration: BoxDecoration(
          color: currentLine ? Colors.black26 : color,
          border:
              Border.all(width: currentPosition ? 5 : 3, color: Colors.black45),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        height: 57,
        width: 57,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
