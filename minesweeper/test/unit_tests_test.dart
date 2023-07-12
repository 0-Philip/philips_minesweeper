import 'package:minesweeper/cells.dart';
import 'package:minesweeper/minesweeper.dart';
import 'package:test/test.dart';

void main() {
  test("a test to test how tests test", () => expect(true, !false));

  test("minecount correct", () {
    var minesweeper = Minesweeper(fieldSize: 9, mineCount: 10);
    minesweeper.initialize();

    expect(
      minesweeper.minefield
          .map((row) => row.countType<Mine>())
          .reduce((value, element) => value + element),
      10,
    );
  });

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
          expect(cell.adjacentMineCount, neighbours.countType<Mine>());
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

extension ListExtension<T> on List<T> {
  T? tryGet(int index) => index < 0 || index >= length ? null : this[index];
  int countType<U>() =>
      fold(0, (tCount, element) => element is U ? tCount + 1 : tCount);
}
