import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../data/dummy_data.dart';

class Word with ChangeNotifier {
  static String _wordDay = words[Random().nextInt(words.length)];
  Map<int, String> boardWords = {};
  List<String> typedWords = ["", "", "", "", "", ""];
  List<String> trueKeys = [];
  List<String> typedWordsEnter = [];
  List<bool> showAwnser = [false, false, false, false, false, false];
  int currentPosition = 1;
  int currentLine = 1;
  int maxLine = 6;
  int maxPosition = 5;
  bool win = false;
  bool done = false;
  String messageWin = "";

  String get wordDay {
    return removeDiacritics(_wordDay);
  }

  String get wordDayOriginal {
    return _wordDay;
  }

  void startGame() {
    _wordDay = words[Random().nextInt(words.length)];
    typedWords = ["", "", "", "", "", ""];
    typedWordsEnter.clear();
    trueKeys.clear();
    showAwnser = [false, false, false, false, false, false];
    currentPosition = 1;
    currentLine = 1;
    maxLine = 6;
    maxPosition = 5;
    win = false;
    done = false;
    messageWin = "";
    notifyListeners();
  }

  void keyPressed(String key) {
    if (key == "ENTER") {
      if (currentPosition > maxPosition &&
          typedWords[currentLine - 1].length == 5) {
        boardWords.putIfAbsent(currentLine, () => typedWords[currentLine - 1]);
        showAwnser[currentLine - 1] = true;
        typedWordsEnter.add(typedWords[currentLine - 1]);
        checkResult();
        if (!win) {
          currentPosition = 1;
          currentLine++;
        }
      }
      if (currentLine > maxLine) {
        done = true;
      }
    } else if (key == "DEL" && !win) {
      if (currentPosition > 1) {
        typedWords[currentLine - 1] = typedWords[currentLine - 1]
            .substring(0, typedWords[currentLine - 1].length - 1);
        backPosition();
      }
    } else {
      if (currentPosition <= maxPosition && !win) {
        typedWords[currentLine - 1] += key.toUpperCase();
        nextPosition();
      }
    }
    // print(boardWords);
    notifyListeners();
  }

  void checkResult() {
    if (typedWords[currentLine - 1] == wordDay) {
      win = true;
      if (currentLine == 1) {
        messageWin = "Inacreditável!";
      }
      if (currentLine == 2) {
        messageWin = "Impressionante!";
      }
      if (currentLine == 3) {
        messageWin = "Incrível!";
      }
      if (currentLine == 4) {
        messageWin = "Ual!";
      }
      if (currentLine == 5) {
        messageWin = "Ufa!";
      }
      if (currentLine == 6) {
        messageWin = "Ufa";
      }
    }
  }

  void backPosition() {
    if (currentPosition >= 0) {
      currentPosition--;
    }
  }

  void nextPosition() {
    if (currentPosition <= maxPosition) {
      currentPosition++;
    }
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

  bool isRightPosition(int line, int index) {
    if (wordDay[index] == typedWords[line][index]) {
      if (!trueKeys.contains(typedWords[line][index])) {
        trueKeys.add(typedWords[line][index]);
      }
      return true;
    }
    return false;
  }

  bool isKeyInRightPosition(String key) {
    return wordDay[currentPosition - 2] == key;
  }

  bool isKeyContains(String key) {
    return wordDay[currentPosition - 2].contains(key);
  }

  bool isExists(int line, int index) {
    // print(wordDay);
    // print(typedWords[line][index]);
    // print(trueKeys);
    if (wordDay.contains(typedWords[line][index])) {
      return true;
    }
    return false;
  }
}
