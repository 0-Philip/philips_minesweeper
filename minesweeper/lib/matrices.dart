List<List<T?>> createMatrix<T>(int matrixSize) {
  List<List<T?>> matrix = [
    for (var i = 0; i <= matrixSize; i++)
      [
        for (var i = 0; i <= matrixSize; i++) null,
      ],
  ];
  return matrix;
}
