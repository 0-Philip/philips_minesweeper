class Position {
  final int _x;
  final int _y;
  Position(this._x, this._y);
}

abstract class CellBase {
  final Position _position;
  CellBase(int x, int y) : _position = Position(x, y) {}
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
