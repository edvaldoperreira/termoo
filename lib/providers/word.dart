import 'dart:ffi';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class Word with ChangeNotifier {
  String _wordDay = "ENTER"; //words[Random().nextInt(words.length)];
  int maxLetters = 5;
  int maxLine = 6;
  int currentLine = 1;
  int currentPosition = 1;
  Map<int, String> blueLetters = {};
  Map<int, String> yellowLetters = {};

  final Map<int, String> wordsBoard = {
    1: "",
    2: "",
    3: "",
    4: "",
    5: "",
    6: "",
  };

  final Map<int, Map<String, List<dynamic>>> wordsBoard2 = {
    1: {"": []},
    2: {"": []},
    3: {"": []},
    4: {"": []},
    5: {"": []},
    6: {"": []},
  };

  String get wordDay {
    return removeDiacritics(_wordDay);
  }

  String get wordDayOriginal {
    return _wordDay;
  }

  writeLetter(String key) {
    if (key == "DEL") {
      wordsBoard.update(currentLine, (value) {
        return value.isNotEmpty ? value.substring(0, value.length - 1) : value;
      });
    } else if (key == "ENTER") {
      colorLetters();
      checkResult();
      if (currentLine < maxLine) {
        currentLine++;
        currentPosition = 1;
      }
    } else if (key != "") {
      wordsBoard.update(currentLine, (value) {
        return value.length < maxLetters ? value += key : value;
      });

      wordsBoard2.update(currentLine, (oldValue) {
        var updatedWord = oldValue.keys.first;
        return {updatedWord += key: oldValue.values.first};
      });
    }
    print(wordsBoard2[currentLine]);
    notifyListeners();
  }

  colorLetters() {
    Map<String, int> qtLetter = {};

    for (var i = 0; i < wordDay.length; i++) {
      var letter = wordDay[i];
      int count = 0;
      for (var j = 0; j < wordDay.length; j++) {
        if (letter == wordDay[j]) {
          count++;
        }
      }
      qtLetter.addEntries([MapEntry(letter, count)]);
    }

    //print(qtLetter);

    var wordBoard = wordsBoard2[currentLine]?.keys.first as String;

    for (var i = 0; i < wordBoard.length; i++) {
      var letter = wordBoard[i];
      int countLetter = qtLetter[letter] ?? 0;

      if (wordBoard[i] == wordDay[i] && countLetter > 0) {
        //addBlueLetter(i, letter);
        wordsBoard2.update(currentLine, (oldValue) {
          var colors = oldValue.values.first;
          colors.add(Color.fromARGB(255, 29, 229, 240));
          return {oldValue.keys.first: colors};
        });
        qtLetter.update(letter, (value) => value = value - 1);
      } else if (wordDay.contains(wordBoard[i]) && countLetter > 0) {
        wordsBoard2.update(currentLine, (oldValue) {
          var colors = oldValue.values.first;
          colors.add(Color.fromARGB(255, 255, 165, 46));
          return {oldValue.keys.first: colors};
        });
        qtLetter.update(letter, (value) => value = value - 1);
      } else {
        wordsBoard2.update(currentLine, (oldValue) {
          var colors = oldValue.values.first;
          colors.add(Colors.black54);
          return {oldValue.keys.first: colors};
        });
      }
    }

    // for (var i = 0; i < wordBoard.length; i++) {
    //   var letter = wordBoard[i];
    //   int countLetter = qtLetter[letter] ?? 0;
    //   if (blueLetters[i] != letter) {
    //     if (wordDay.contains(wordBoard[i]) && countLetter > 0) {
    //       addYellowLetter(i, letter);
    //       qtLetter.update(letter, (value) => value = value - 1);
    //     }
    //   }
    // }

    print(qtLetter);
    print(blueLetters);
    print(yellowLetters);

    //wordsBoard.forEach((key, value) {
    // if (key == currentLine) {
    //   for (var i = 0; i < value.length; i++) {
    //     int countKey = value[i].allMatches(_wordDay).length;
    //     if (value[i] == _wordDay[i] && countKey > 0) {
    //       blueLetters.add(value[i]);
    //       countKey--;
    //    }
    //     if (_wordDay.contains(value[i]) && countKey > 0) {
    //      yellowLetters.add(value[i]);
    //      countKey--;
    //    }
    //  }
    // }
    //});
  }

  checkResult() {}

  void startGame() {
    _wordDay = words[Random().nextInt(words.length)];
    blueLetters.clear();
    yellowLetters.clear();
  }

  addBlueLetter(int position, String letter) {
    blueLetters.addEntries([MapEntry(position, letter)]);
  }

  addYellowLetter(int position, String letter) {
    yellowLetters.addEntries([MapEntry(position, letter)]);
  }

  String removeDiacritics(String str) {
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str.toUpperCase();
  }
}
