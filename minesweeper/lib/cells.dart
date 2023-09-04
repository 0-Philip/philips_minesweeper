import 'dart:math';

typedef Position = ({int x, int y});

sealed class CellBase {
  final Position position;
  bool isFlagged = false;
  List<List<CellBase?>> inField;
  bool _isCovered = true;
  get isCovered => _isCovered;

  CellBase(this.position, {required this.inField}) {
    inField[position.y][position.x] = this;
  }

  void increment();

  void uncover() {
    _isCovered = false;
  }

  void forEachSurrounding(void Function(int, int) function) {
    var outerbounds = _determineOuterbounds(inField);

    for (var i = position.x - 1; i <= position.x + 1; i++) {
      if ((i < outerbounds.x) && (i >= 0)) {
        for (var j = position.y - 1; j <= position.y + 1; j++) {
          if ((j < outerbounds.y) && (j >= 0)) {
            function(i, j);
          }
        }
      }
    }
  }
}

class Mine extends CellBase {
  Mine(super.position, {required super.inField});

  factory Mine.scattered({required List<List<CellBase?>> throughoutField}) {
    final outerBounds = _determineOuterbounds(throughoutField);
    var random = Random();
    var mineDestination = _newRandomPosition(random, outerBounds);

    while (_isOccupied(throughoutField, mineDestination)) {
      mineDestination = _newRandomPosition(random, outerBounds);
    }

    return Mine(
      (x: mineDestination.x, y: mineDestination.y),
      inField: throughoutField,
    );
  }

  @override
  // ignore: no-empty-block
  void increment() {
    // Leaving increment() unimplemented for Mine instances allows them to be
    // 'skipped over' when the neighbouring values are being determined.
  }

  @override
  void uncover() {
    super.uncover();
    // TODO: boom!!!
  }

  static Position _newRandomPosition(Random random, Position outerBounds) {
    return (
      x: random.nextInt(outerBounds.x),
      y: random.nextInt(outerBounds.y),
    );
  }

  static bool _isOccupied(
    List<List<CellBase?>> throughoutField,
    Position mineDestination,
  ) {
    return throughoutField[mineDestination.y][mineDestination.x] != null;
  }
}

class NumberedCell extends CellBase {
  int adjacentMineCount;
  NumberedCell(super.position, {required super.inField})
      : adjacentMineCount = 1;

  @override
  void increment() {
    adjacentMineCount++;
  }
}

class EmptyCell extends CellBase {
  EmptyCell(super.position, {required super.inField});

  @override
  void increment() {
    assert(false, "empty cells should not be incremented");
  }

  @override
  void uncover() {
    super.uncover();
    forEachSurrounding((int x, int y) {
      var cell = inField[y][x];
      if (cell?.isCovered) cell?.uncover();
    });
  }
}

Position _determineOuterbounds(List<List<CellBase?>> throughoutField) {
  // _assertMinefieldSuitability(throughoutField);

  return (x: throughoutField.first.length, y: throughoutField.length);
}

void _assertMinefieldSuitability(List<List<CellBase?>> throughoutField) {
  assert(isRectangular(throughoutField), "field is not rectangular");
  assert(
      1 <= countEmptyCellsinMatrix(throughoutField), "not enough empty cells");
}

int countEmptyCellsinMatrix<T>(List<List<T?>> matrix) => matrix
    .map((row) => row.where((element) => element == null).length)
    .reduce((value, element) => value + element);

bool isRectangular<T>(List<List<T>> listOfLists) {
  for (int i = 1; i < listOfLists.length; i++) {
    if (listOfLists[i].length != listOfLists[i - 1].length) {
      return false;
    }
  }

  return true;
}
