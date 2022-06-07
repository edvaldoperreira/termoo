import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/word.dart';

class EndGame extends StatelessWidget {
  const EndGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Word provider = Provider.of<Word>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (provider.victory)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Theme.of(context).primaryColor,
              child: const Text(
                "Congratulations, you won!",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        if (provider.finalGame && !provider.victory)
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
                    "A palavra era: ${provider.wordDay.toLowerCase()}",
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        if (provider.notValidWord)
          Row(
            children: [
              const Icon(
                Icons.block,
                color: Colors.white,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  color: Colors.blue.shade800,
                  child: const Text(
                    "Essa palavra não é válida",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
