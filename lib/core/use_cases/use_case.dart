/*
T => return type
P => parameter type
* */
abstract class UseCase<T, P> {
  Future<T> call(P param);
}

class NoParams{}