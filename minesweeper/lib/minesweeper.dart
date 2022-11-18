import 'package:minesweeper/cells.dart';
import 'dart:io';
import 'package:minesweeper/matrices.dart';
import 'package:minesweeper/scatter_throughout.dart';

int calculate() {
  return 6 * 7;
}

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

  void initializeWithScatter() {
    scatter(mines, throughoutField: minefield);
    addNeighbours();
    printMineswithDebug();
  }

  void initializeByCount(int count) {
    mines = createAndScatterMines(count: count, throughoutField: minefield);
    addNeighbours();
    printMineswithDebug();
    print("There are ${mines.length} mines");
  }

  void initialize() {
    addNeighbours();
    printMineswithDebug();
  }

  void addNeighbours() {
    for (var mine in mines) {
      var xStart = mine.position.x;
      var yStart = mine.position.y;

      for (var i = xStart - 1; i <= xStart + 1; i++) {
        if ((i < xOuterBound) && (i >= 0)) {
          for (var j = yStart - 1; j <= yStart + 1; j++) {
            if ((j < yOuterBound) && (j >= 0)) {
              if (minefield[j][i] == null) {
                minefield[j][i] = NumberedCell(i, j);
              } else {
                minefield[j][i]!.increment();
              }
            }
          }
        }
      }
    }
  }

  void addNeighbours2() {
    for (var mine in mines) {
      forEachSurrounding(mine, placeNumberAccordingly);
    }
  }

  void forEachSurrounding(CellBase cell, Function function) {
    int xStart = cell.position.x;
    int yStart = cell.position.y;
    for (var i = xStart - 1; i <= xStart + 1; i++) {
      if ((i < xOuterBound) && (i >= 0)) {
        for (var j = yStart - 1; j <= yStart + 1; j++) {
          if ((j < yOuterBound) && (j >= 0)) {
            function(j, i);
          }
        }
      }
    }
  }

  void placeNumberAccordingly(int j, int i) {
    if (minefield[j][i] == null) {
      minefield[j][i] = NumberedCell(i, j);
    } else {
      minefield[j][i]!.increment();
    }
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
