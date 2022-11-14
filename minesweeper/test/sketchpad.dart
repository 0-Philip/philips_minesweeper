import "dart:io";
import 'package:minesweeper/matrices.dart';
import 'package:minesweeper/scatter_throughout.dart';

class MutableString {
  var contents = "";
  MutableString(this.contents);
}

void main() {
  print("hi!");

  const matrixSize = 9;

  //testMatrix();

  var matrix = createMatrix<String>(matrixSize);

  var strings = [for (var i = 0; i < 10; i++) "$i"];

  scatter(strings, throughoutField: matrix);

  //printStringMatrix(matrix);

  var matrix2 = createMatrix<MutableString>(matrixSize);

  var scatterables = [for (var i = 0; i < 10; i++) MutableString("$i")];

  scatter(scatterables, throughoutField: matrix2);

  printMutableStringMatrix(matrix2);

  print("");

  scatterables[3].contents = "🚩";

  printMutableStringMatrix(matrix2);
}

void testMatrix() {
  var matrix = [
    ["d", null, null, "e"],
    [null, "█", null, "🍅"],
    ["😉", null, "🦡", "█"],
  ];

  printStringMatrix(matrix);
}

void printStringMatrix(List<List<String?>> matrix) {
  for (var row in matrix) {
    for (var cell in row) {
      stdout.write(cell ?? "░");
    }
    stdout.writeln('');
  }
}

void printMutableStringMatrix(List<List<MutableString?>> matrix) {
  for (var row in matrix) {
    for (var cell in row) {
      stdout.write(cell?.contents ?? "░");
    }
    stdout.writeln('');
  }
}
