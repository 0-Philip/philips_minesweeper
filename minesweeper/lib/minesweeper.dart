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

  List<List<CellBase?>> minefield;
  List<Mine> mines;
  final int xOuterBound;
  final int yOuterBound;

  void initialize() {
    addNeighbours2();
    printMineswithDebug();
  }

  void addNeighbours2() {
    for (var mine in mines) {
      mine.forEachSurrounding(placeNumberAccordingly);
    }
  }

  void placeNumberAccordingly(int j, int i) {
    if (minefield[j][i] is NumberedCell) minefield[j][i]!.increment();
    minefield[j][i] ??= NumberedCell(i, j, inField: minefield);
  }

  void printMineswithDebug() {
    for (var row in minefield) {
      for (var cell in row) {
        if (cell is NumberedCell) {
          stdout.write(cell.adjacentMineCount);
        } else {
          stdout.write(cell == null ? "░" : "@");
        }
      }
      stdout.writeln('');
    }

    for (var mine in mines) {
      print("My coordinates are ${mine.position.x},${mine.position.y}");
    }
  }
}
