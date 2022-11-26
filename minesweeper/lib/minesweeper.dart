import 'package:minesweeper/cells.dart';
import 'dart:io';
import 'package:minesweeper/matrices.dart';

class Minesweeper {
  factory Minesweeper({int fieldSize = 9, int mineCount = 10}) {
    var minefield = createMatrix<CellBase>(fieldSize);
    var mines = [
      for (var i = 0; i < mineCount; i++)
        Mine.scattered(throughoutField: minefield)
    ];
    return Minesweeper._(fieldSize, minefield, mines);
  }

  Minesweeper._(int fieldSize, this.minefield, this.mines)
      : xOuterBound = fieldSize,
        yOuterBound = fieldSize;

  Matrix<CellBase?> minefield;
  List<Mine> mines;
  final int xOuterBound;
  final int yOuterBound;

  void initialize() {
    addNeighbours();
    populateEmptyCells();
    printMineswithDebug();
  }

  void addNeighbours() {
    for (var mine in mines) {
      mine.forEachSurrounding(placeNumberAccordingly);
    }
  }

  void placeNumberAccordingly(int x, int y) {
    if (minefield[y][x] is NumberedCell) minefield[y][x]!.increment();
    minefield[y][x] ??= NumberedCell(x, y, inField: minefield);
  }

  void populateEmptyCells() {
    forEachInMatrix(minefield, (x, y) {
      minefield[y][x] ??= EmptyCell(x, y, inField: minefield);
    });
  }

  void printMineswithDebug() {
    for (var row in minefield) {
      for (var cell in row) {
        if (cell is NumberedCell) {
          stdout.write(cell.adjacentMineCount);
        } else if (cell is EmptyCell) {
          stdout.write("░");
        } else {
          stdout.write(cell == null ? "." : "@");
        }
      }
      stdout.writeln('');
    }

    for (var mine in mines) {
      print("My coordinates are ${mine.position.x},${mine.position.y}");
    }
  }
}

void forEachInMatrix<T>(Matrix<T> matrix, Function(int i, int j) function) {
  for (int i = 0; i < (matrix.length); i++) {
    for (int j = 0; j < (matrix[i].length); j++) {
      function(i, j);
    }
  }
}
