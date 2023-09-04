import 'package:minesweeper/cells.dart';

typedef Matrix<T> = List<List<T>>;

Matrix<T?> createMatrix<T>(int matrixSize) {
  return [
    for (var i = 0; i < matrixSize; i++)
      [for (var i = 0; i < matrixSize; i++) null],
  ];
}

Matrix<T?> matrixFromDimensions<T>(int x, int y) {
  return [
    for (var i = 0; i < y; i++) [for (var i = 0; i < x; i++) null],
  ];
}

class MineField {
  final int height;
  final int width;
  Matrix<CellBase?> matrix;
  MineField(int x, int y)
      : matrix = matrixFromDimensions<CellBase>(x, y),
        height = y,
        width = x;
}
