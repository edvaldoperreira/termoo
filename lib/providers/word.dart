import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:termoo/data/dictionary_data.dart';
import '../data/words_data.dart';

class Word with ChangeNotifier {
  String _wordDay = "TERMO"; //words[Random().nextInt(words.length)];
  int maxLetters = 5;
  int maxLine = 6;
  int currentLine = 1;
  int currentPosition = 1;
  bool finalGame = false;
  bool victory = false;
  bool notValidWord = false;
  Map<int, Map<int, String>> blueLetters = {};
  Map<int, Map<int, String>> yellowLetters = {};
  List<String> wrongLetters = [];
  Map<int, String> wordsBoard = {1: "", 2: "", 3: "", 4: "", 5: "", 6: ""};
  Map<int, String> positionLetters = {};

  String get wordDay {
    return removeDiacritics(_wordDay);
  }

  String get wordDayOriginal {
    return _wordDay;
  }

  setPosition(int line, int position) {
    if (line == currentLine) {
      currentPosition = position;
      notifyListeners();
    }
  }

  writeLetter(String key) {
    if (!finalGame) {
      if (key == "DEL") {
        notValidWord = false;
        wordsBoard.update(currentLine, (value) {
          return value.isNotEmpty
              ? value.substring(0, value.length - 1)
              : value;
        });
        positionLetters.remove(currentPosition);
        positionLetters.remove(currentPosition - 1);

        if (currentPosition > 1) {
          currentPosition--;
        }
      } else if (key == "ENTER") {
        if (positionLetters.length == 5) {
          var replacedWord = checkWord();
          if (replacedWord.isNotEmpty) {
            wordsBoard.update(
                currentLine, (value) => value = replacedWord.toUpperCase());
            colorLetters();
            checkResult();
            if (currentLine <= maxLine) {
              currentLine++;
              currentPosition = 1;
              positionLetters.clear();
            }
          } else {
            notValidWord = true;
          }
        }
      } else if (key != "") {
        if (currentPosition <= maxLetters) {
          positionLetters.addEntries([MapEntry(currentPosition, key)]);
          if (currentPosition <= maxLetters) {
            currentPosition++;
          } else {
            var values = [1, 2, 3, 4, 5];
            for (var i = 1; i < values.length; i++) {
              if (!positionLetters.containsKey(i)) {
                currentPosition = i;
                break;
              }
            }
          }
          wordsBoard.update(currentLine, (value) {
            return value.length < maxLetters ? value += key : value;
          });
        }
      }
      notifyListeners();
    }
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

    var wordBoard = removeDiacritics(wordsBoard[currentLine] as String);

    for (var i = 0; i < wordBoard.length; i++) {
      var letter = wordBoard[i];
      int countLetter = qtLetter[letter] ?? 0;

      if (wordBoard[i] == wordDay[i] && countLetter > 0) {
        addBlueLetter(i, letter);
        qtLetter.update(letter, (value) => value = value - 1);
      }
    }

    for (var i = 0; i < wordBoard.length; i++) {
      var letter = wordBoard[i];
      int countLetter = qtLetter[letter] ?? 0;
      var currentblueLine = blueLetters[currentLine];
      bool bluePosition = currentblueLine == null
          ? false
          : blueLetters[currentLine]?.keys.contains(i) as bool;

      if (wordDay.contains(wordBoard[i]) && countLetter > 0 && !bluePosition) {
        addYellowLetter(i, letter);
        qtLetter.update(letter, (value) => value = value - 1);
      } else {
        wrongLetters.add(letter);
      }
    }
  }

  String checkWord() {
    var currentWord = "";
    for (var i = 1; i <= positionLetters.length; i++) {
      currentWord += positionLetters[i] as String;
    }
    String currentWordReplaced = dictionary.firstWhere(
        (element) => removeDiacritics(element) == currentWord.toUpperCase(),
        orElse: () {
      return "";
    });
    return currentWordReplaced;
  }

  checkResult() {
    victory = removeDiacritics(wordsBoard[currentLine] as String) == wordDay;
    if (victory || currentLine == maxLine) {
      finalGame = true;
    }
  }

  void startGame() {
    _wordDay = words[Random().nextInt(words.length)];
    finalGame = false;
    victory = false;
    notValidWord = false;
    wrongLetters = [];
    wordsBoard = {1: "", 2: "", 3: "", 4: "", 5: "", 6: ""};
    currentLine = 1;
    currentPosition = 1;
    blueLetters.clear();
    yellowLetters.clear();
    positionLetters.clear();
    notifyListeners();
  }

  addBlueLetter(int position, String letter) {
    if (blueLetters.containsKey(currentLine)) {
      blueLetters.update(currentLine, (oldValue) {
        var newValue = oldValue;
        newValue.addEntries([MapEntry(position, letter)]);
        return newValue;
      });
    } else {
      var item = {position: letter};
      var line = {currentLine: item};
      blueLetters.addAll(line);
    }
  }

  addYellowLetter(int position, String letter) {
    if (yellowLetters.containsKey(currentLine)) {
      yellowLetters.update(currentLine, (oldValue) {
        var newValue = oldValue;
        newValue.addEntries([MapEntry(position, letter)]);
        return newValue;
      });
    } else {
      var item = {position: letter};
      var line = {currentLine: item};
      yellowLetters.addAll(line);
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
}
