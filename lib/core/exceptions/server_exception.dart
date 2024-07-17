/* Custom exception class of the application */
class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}
