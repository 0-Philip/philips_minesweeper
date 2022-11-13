import "dart:io";
import 'package:minesweeper/matrices.dart';
import 'package:minesweeper/scatter_throughout.dart';

void main() {
  print("hi!");

  const matrixSize = 3;

  //testMatrix();

  var matrix = createMatrix<String>(matrixSize);

  var strings = [for (var i = 0; i < 5; i++) "$i"];

  scatter(items: strings, throughoutField: matrix);

  printMatrix(matrix);
}

void testMatrix() {
  List<List<String?>> matrix = [
    ["d", null, null, "e"],
    [null, "█", null, "🍅"],
    ["😉", null, "🦡", "█"],
  ];

  printMatrix(matrix);
}

void printMatrix(List<List<String?>> matrix) {
  for (var row in matrix) {
    for (var cell in row) {
      stdout.write(cell ?? "░");
    }
    stdout.writeln('');
  }
}
