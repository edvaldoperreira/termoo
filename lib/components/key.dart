import 'package:flutter/material.dart';

class KeyWidget extends StatelessWidget {
  final String key_;
  final Function(String) onKeyPressed;
  const KeyWidget(this.key_, this.onKeyPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onKeyPressed(key_),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                color: Colors.black54,
                child: Text(
                  key_,
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
}
