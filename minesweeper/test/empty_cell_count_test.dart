import 'package:test/test.dart';
import 'package:minesweeper/cells.dart';

void main() {
  test("countEmptyCellsInMatrix works as expected", () {
    List<List<int?>> testMatrix = [
      [1, 2, 3, null],
      [4, 3, 2, 1],
      [null, 2, 3, 4],
      [1, 2, null, 4],
    ];
    expect(countEmptyCellsinMatrix(testMatrix), 3);
  });
}
