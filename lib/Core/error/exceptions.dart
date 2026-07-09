class ServerException implements Exception {
  final int statusCode;
  ServerException(this.statusCode);
}

class TimeoutException implements Exception {}

class NetworkException implements Exception {}

class ParsingException implements Exception {}
