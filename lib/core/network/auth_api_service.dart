import 'package:adminetic_booking/core/network/api_service.dart';
import 'package:adminetic_booking/core/services/shared_preferences_service.dart';

class AuthApiService extends ApiService {
  final SharedPreferencesService sharedPreferences;
  AuthApiService({required super.client, required this.sharedPreferences});
}
