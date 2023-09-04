import 'package:minesweeper/minesweeper.dart';

void main() {
  var minesweeper = Minesweeper(fieldSize: 9, mineCount: 10);
  minesweeper.printMineswithDebug();
  minesweeper.minefield[4][6]?.uncover();
  prettyPrintMinefield(minesweeper);
}
