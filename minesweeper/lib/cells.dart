import 'dart:math';

import 'package:minesweeper/scatter_throughout.dart';

class Position {
  int x = 0;
  int y = 0;
  Position(this.x, this.y);
}

abstract class CellBase {
  Position position;
  CellBase(int x, int y) : position = Position(x, y);
  void increment();
}

class Mine extends CellBase {
  List<List<CellBase?>> inField;
  Mine(super.x, super.y, {required this.inField});

  factory Mine.scattered({required throughoutField}) {
    assert(isRectangular(throughoutField), "field is not rectangular");

    assert(1 <= countEmptyCellsinMatrix(throughoutField),
        "not enough empty cells");
    var random = Random();
    final xOuterBound = throughoutField[0].length;
    final yOuterBound = throughoutField.length;
    var yCoordinate = random.nextInt(yOuterBound);
    var xCoordinate = random.nextInt(xOuterBound);
    while (throughoutField[yCoordinate][xCoordinate] != null) {
      print("had to try a different location");
      yCoordinate = random.nextInt(yOuterBound);
      xCoordinate = random.nextInt(xOuterBound);
    }
    var newMine = Mine(xCoordinate, yCoordinate, inField: throughoutField);
    throughoutField[newMine.position.y][newMine.position.x] = newMine;

    return newMine;
  }

  @override
  void increment() {
    // Leaving increment() unimplemented for Mine instances allows them to be
    // 'skipped over' when the neighbouring values are being determined
  }
}

class NumberedCell extends CellBase {
  int adjacentMineCount;
  NumberedCell(super.x, super.y) : adjacentMineCount = 1;

  @override
  void increment() {
    adjacentMineCount++;
  }
}

class EmptyCell extends CellBase {
  EmptyCell(super.x, super.y);

  @override
  void increment() {
    assert(false, "empty cells should not be incremented");
  }
}
