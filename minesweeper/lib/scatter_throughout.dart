import 'dart:math';

import 'package:minesweeper/cells.dart';

void scatter<T>(List<T> items, {required List<List<T?>> throughoutField}) {
  assert(_isRectangular(throughoutField), "field is not rectangular");
  assert(items.length < (throughoutField[0].length * throughoutField.length),
      "too many items to scatter throughout field");
  assert(items.length <= countEmptyCellsinMatrix(throughoutField),
      "not enough empty cells");

  var random = Random();
  final xOuterBound = throughoutField[0].length;
  final yOuterBound = throughoutField.length;
  for (var item in items) {
    var yCoordinate = random.nextInt(yOuterBound);
    var xCoordinate = random.nextInt(xOuterBound);
    while (throughoutField[yCoordinate][xCoordinate] != null) {
      print("had to try a different location");
      yCoordinate = random.nextInt(yOuterBound);
      xCoordinate = random.nextInt(xOuterBound);
    }
    throughoutField[yCoordinate][xCoordinate] = item;

    if (item is Mine) {
      item.position
        ..x = xCoordinate
        ..y = yCoordinate;
    }
  }
}

int countEmptyCellsinMatrix<T>(List<List<T?>> matrix) {
  var emptySpace = 0;
  for (var row in matrix) {
    emptySpace += row.where((element) => element == null).length;
  }
  return emptySpace;
}

bool _isRectangular<T>(List<List<T>> listOfLists) {
  for (int i = 1; i < listOfLists.length; i++) {
    if (listOfLists[i].length != listOfLists[i - 1].length) {
      return false;
    }
  }
  return true;
}

List<Mine> createAndScatterMines(
    {required int count, required List<List<CellBase?>> throughoutField}) {
  assert(_isRectangular(throughoutField), "field is not rectangular");
  assert(count < (throughoutField[0].length * throughoutField.length),
      "too many items to scatter throughout field");
  assert(count <= countEmptyCellsinMatrix(throughoutField),
      "not enough empty cells");
  var mines = List<Mine>.empty(growable: true);
  var random = Random();
  final xOuterBound = throughoutField[0].length;
  final yOuterBound = throughoutField.length;
  for (var i = 0; i < count; i++) {
    var yCoordinate = random.nextInt(yOuterBound);
    var xCoordinate = random.nextInt(xOuterBound);
    while (throughoutField[yCoordinate][xCoordinate] != null) {
      print("had to try a different location");
      yCoordinate = random.nextInt(yOuterBound);
      xCoordinate = random.nextInt(xOuterBound);
    }
    var newMine = Mine(xCoordinate, yCoordinate);
    throughoutField[newMine.position.y][newMine.position.x] = newMine;
    mines.add(newMine);
  }
  return mines;
}
