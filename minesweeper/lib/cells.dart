import 'dart:math';

import 'package:minesweeper/scatter_throughout.dart';

class Position {
  int x = 0;
  int y = 0;
  Position(this.x, this.y);
}

abstract class CellBase {
  final Position position;
  CellBase(int x, int y) : position = Position(x, y);
  void increment();
}

class Mine extends CellBase {
  List<List<CellBase?>> inField;
  Mine(super.x, super.y, {required this.inField}) {
    inField[position.y][position.x] = this; //TODO bring into superclass
  }

  factory Mine.scattered({required List<List<CellBase?>> throughoutField}) {
    final outerBounds = _determineOuterbounds(throughoutField);
    var random = Random();
    var mineDestination = _newRandomPosition(random, outerBounds);
    while (_isOccupied(throughoutField, mineDestination)) {
      mineDestination = _newRandomPosition(random, outerBounds);
    }
    return Mine(mineDestination.x, mineDestination.y, inField: throughoutField);
  }

  static Position _determineOuterbounds(List<List<CellBase?>> throughoutField) {
    _assertMinefieldSuitability(throughoutField);
    return Position(throughoutField[0].length, throughoutField.length);
  }

  static Position _newRandomPosition(Random random, Position outerBounds) =>
      Position(random.nextInt(outerBounds.x), random.nextInt(outerBounds.y));

  static bool _isOccupied(
          List<List<CellBase?>> throughoutField, Position mineDestination) =>
      throughoutField[mineDestination.y][mineDestination.x] != null;

  static void _assertMinefieldSuitability(
      List<List<CellBase?>> throughoutField) {
    assert(isRectangular(throughoutField), "field is not rectangular");
    assert(1 <= countEmptyCellsinMatrix(throughoutField),
        "not enough empty cells");
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
