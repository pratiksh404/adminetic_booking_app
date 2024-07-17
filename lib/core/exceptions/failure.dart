/* Exception class for either returns */
class Failure {
  final int code;
  final String message;
  final Map<String, String>? errors;

  Failure({this.code = 0, required this.message, this.errors});
}
