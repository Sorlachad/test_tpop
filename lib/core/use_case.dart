abstract class UseParam<T, R> {
  Future<T> call(R params);
}

abstract class UseEmptyParam<T> {
  Future<T> call();
}
