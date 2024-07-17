/* Exception class for either returns */
class Failure {
  final String message;
  final Map<String, String>? errors;

  Failure({required this.message, this.errors});
}
