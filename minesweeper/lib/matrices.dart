typedef Matrix<T> = List<List<T>>;

Matrix<T?> createMatrix<T>(int matrixSize) {
  return [
    for (var i = 0; i < matrixSize; i++)
      [for (var i = 0; i < matrixSize; i++) null],
  ];
}
