class Position {
  int x = 0;
  int y = 0;
  Position(this.x, this.y);
}

abstract class CellBase {
  Position position;
  CellBase(int x, int y) : position = Position(x, y);
}

class Mine extends CellBase {
  Mine(super.x, super.y);
}

class NumberedCell extends CellBase {
  NumberedCell(super.x, super.y);
}

class EmptyCell extends CellBase {
  EmptyCell(super.x, super.y);
}
