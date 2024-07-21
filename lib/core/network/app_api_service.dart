import 'package:adminetic_booking/core/network/api_service.dart';
import 'package:adminetic_booking/core/network/dio_service.dart';

class AppApiService extends ApiService {
  AppApiService({required DioService client}) : super(client: client);
}
