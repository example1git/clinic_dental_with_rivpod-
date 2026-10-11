class ServerExeption implements Exception {
  final String message;
  ServerExeption({required this.message});
}

class CachExeption implements Exception {
  final String message;
  CachExeption({required this.message});
}

class RequestTimeExeption implements Exception {
  final String message;
  RequestTimeExeption({required this.message});
}

class InternetExeption implements Exception {
  final String message;
  InternetExeption({required this.message});
}
