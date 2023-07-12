import 'dart:math';

import 'package:minesweeper/cells.dart';
import 'package:minesweeper/minesweeper.dart';
import 'package:test/test.dart';

void main() {
  test("a test to test how tests test", () => expect(true, !false));
  test('the numbers are correctly placed', () {
    var minesweeper = Minesweeper(fieldSize: 9, mineCount: 10);
    minesweeper.initialize();

    for (var row in minesweeper.minefield) {
      for (var cell in row) {
        if (cell is NumberedCell) {
          var neighbours = List.empty(growable: true);
          var (:x, :y) = cell.position;
          forEachSurrounding(x, y, (i, j) {
            neighbours.add(minesweeper.minefield.tryGet(j)?.tryGet(i));
          });
          expect(
            cell.adjacentMineCount,
            neighbours.fold(0, (mineCount, element) {
              return element is Mine ? mineCount + 1 : mineCount;
            }),
          );
        }
      }
    }
  });
}

void forEachSurrounding(int x, int y, void Function(int, int) function) {
  for (var i = x - 1; i <= x + 1; i++) {
    for (var j = y - 1; j <= y + 1; j++) {
      function(i, j);
    }
  }
}

extension ListGetExtension<T> on List<T> {
  T? tryGet(int index) => index < 0 || index >= length ? null : this[index];
}
