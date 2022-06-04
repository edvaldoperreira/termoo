import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  const Board({Key? key}) : super(key: key);

  static Map<String, List<Widget>> itemsMap = {};

  startBoard() {
    getPositions(5, 0);
    getPositions(5, 1);
    getPositions(5, 2);
    getPositions(5, 3);
    getPositions(5, 4);
    getPositions(5, 5);
  }

  List<Widget> getRows(int quantity) {
    List<Widget> rows = [];
    for (var i = 0; i < quantity; i++) {
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: itemsMap[i.toString()]!.toList(),
      ));
      rows.add(const Spacer());
    }
    return rows;
  }

  // if (word.isRightPosition(line, index)) {
  //       colorContainer = const Color.fromARGB(255, 41, 192, 192);
  //     } else if (word.isExists(line, index) && (qtKeyAux == qtKey)) {
  //       colorContainer = const Color.fromARGB(255, 245, 176, 72);
  //     }

  void getPositions(int quantity, int line) {
    List<Widget> items = [];
    for (var i = 0; i < quantity; i++) {
      items.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            height: 60,
            width: 60,
            color: Colors.black54,
            child: Center(
              child: Text(
                "",
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    }
    itemsMap.putIfAbsent(line.toString(), () => items);
  }

  @override
  Widget build(BuildContext context) {
    startBoard();
    return Container(
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        height: 420,
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        child: Column(
          children: getRows(6),
        ));
  }
}
