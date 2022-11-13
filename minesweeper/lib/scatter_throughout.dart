import 'dart:math';

void scatter<T>(
    {required List<T> items, required List<List<T?>> throughoutField}) {
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
  }
}

int countEmptyCellsinMatrix(List<List<dynamic>> throughoutField) {
  var emptySpace = 0;

  for (var row in throughoutField) {
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
