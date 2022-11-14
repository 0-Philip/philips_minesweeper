import 'package:minesweeper/cells.dart';
import 'dart:io';
import 'package:minesweeper/matrices.dart';
import 'package:minesweeper/scatter_throughout.dart';

int calculate() {
  return 6 * 7;
}

class Minesweeper {
  Minesweeper({int fieldSize = 9, int mineCount = 10})
      : minefield = createMatrix<CellBase>(fieldSize),
        mines = [for (var i = 0; i < mineCount; i++) Mine(0, 0)];

  List<List<CellBase?>> minefield;
  List<Mine> mines;

  void initialize() {
    scatter(mines, throughoutField: minefield);

    for (var row in minefield) {
      for (var cell in row) {
        stdout.write(cell == null ? "░" : "@");
      }
      stdout.writeln('');
    }

    for (var mine in mines) {
      print("My coordinates are ${mine.position.x},${mine.position.y}");
    }
  }
}
