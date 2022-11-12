import "dart:io";

void main() {
  print("hi!");

  const matrixSize = 9;

  //testMatrix();

  var matrix = createMatrix(matrixSize);

  printMatrix(matrix);
}

List<List<String?>> createMatrix(int matrixSize) {
  List<List<String?>> matrix = [
    for (var i = 0; i <= matrixSize; i++)
      [
        for (var i = 0; i <= matrixSize; i++) null,
      ],
  ];
  return matrix;
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
