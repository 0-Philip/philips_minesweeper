import "dart:io";

void main() {
  print("hi!");

  const matrixSize = 9;

  testMatrix();
}

void testMatrix() {
  List<List<String?>> matrix = [
    ["d", null, null, "e"],
    [null, "█", null, "🍅"],
    ["😉", null, "🦡", "█"],
  ];

  for (var row in matrix) {
    for (var cell in row) {
      stdout.write(cell ?? "░");
    }
    stdout.writeln('');
  }
}
