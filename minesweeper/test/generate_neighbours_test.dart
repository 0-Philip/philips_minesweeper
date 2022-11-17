import 'dart:io';

import 'package:minesweeper/cells.dart';
import 'package:minesweeper/matrices.dart';

var minefield = createMatrix<CellBase>(4);
var mines = [
  Mine(2, 1, inField: minefield),
  Mine(1, 3, inField: minefield),
  Mine(3, 3, inField: minefield),
];

var xOuterBound = 4;
var yOuterBound = 4;

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

void main() {
  for (var mine in mines) {
    minefield[mine.position.y][mine.position.x] = mine;
  }

  addNeighbours();
  printMineswithDebug();
}
