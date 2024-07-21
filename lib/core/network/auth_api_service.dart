import 'package:adminetic_booking/core/network/api_service.dart';
import 'package:adminetic_booking/core/network/dio_service.dart';
import 'package:adminetic_booking/core/services/shared_preferences_service.dart';

class AuthApiService extends ApiService {
  final SharedPreferencesService sharedPreferences;
  AuthApiService({required DioService client, required this.sharedPreferences})
      : super(client: client);
}
