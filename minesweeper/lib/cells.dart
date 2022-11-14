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
  Mine(super.x, super.y);
  @override
  void increment() {
    // do nothing
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
