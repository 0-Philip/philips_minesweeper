import "dart:io";
import 'package:minesweeper/matrices.dart';

void main() {
  print("hi!");

  const matrixSize = 9;

  //testMatrix();

  var matrix = createMatrix<String>(matrixSize);

  matrix[2][2] = "@";

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
