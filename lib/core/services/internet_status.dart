import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetStatus {
  final InternetConnectionChecker _internetConnectionChecker;

  InternetStatus(this._internetConnectionChecker);

  Future<bool> get isOnline => _internetConnectionChecker.hasConnection;
}
