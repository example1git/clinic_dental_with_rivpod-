abstract class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class CachFailure extends Failure {
  CachFailure(super.message);
}

class RequetsTimeFailure extends Failure {
  RequetsTimeFailure(super.message);
}

class InternetFailure extends Failure {
  InternetFailure(super.message);
}
