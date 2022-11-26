typedef Matrix<T> = List<List<T>>;

Matrix<T?> createMatrix<T>(int matrixSize) {
  Matrix<T?> matrix = [
    for (var i = 0; i < matrixSize; i++)
      [
        for (var i = 0; i < matrixSize; i++) null,
      ],
  ];
  return matrix;
}
