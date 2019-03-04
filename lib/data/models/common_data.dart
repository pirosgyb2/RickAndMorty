import 'dart:async';

abstract class CommonRepository<T> {
  Future<List<T>> fetch();
}

class FetchDataException implements Exception {
  String _message;

  FetchDataException(this._message);

  String toString() {
    return "Exception: $_message";
  }
}
