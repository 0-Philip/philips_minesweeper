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
      mine.forEachSurrounding(placeNumberAccordingly2);
    }
  }

  void placeNumberAccordingly(int j, int i) {
    if (minefield[j][i] == null) {
      minefield[j][i] = NumberedCell(i, j, inField: minefield);
    } else {
      minefield[j][i]!.increment();
    }
  }

  void placeNumberAccordingly2(int j, int i) {
    if (minefield[j][i] is NumberedCell) minefield[j][i]!.increment();
    minefield[j][i] ??= NumberedCell(i, j, inField: minefield);
  }

  void forEachAdjacent(int coordinate, int outerbound, Function function) =>
      () {
        for (var i = coordinate - 1; i <= coordinate + 1; i++) {
          if ((i < outerbound) && (i >= 0)) {
            function();
          }
        }
      };

  void forEachAdjacentCell(
      Position location, Position outerbounds, Function function) {
    forEachAdjacent(location.x, outerbounds.x, () {
      forEachAdjacent(location.y, outerbounds.y, function);
    });
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
