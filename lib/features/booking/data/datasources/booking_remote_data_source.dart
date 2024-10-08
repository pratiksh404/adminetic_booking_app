import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/booking/data/models/analytics_model.dart';
import 'package:adminetic_booking/features/booking/data/models/booking_model.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/all_booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_status_params.dart';

abstract interface class BookingRemoteDataSource {
  Future<List<BookingModel>> all(AllBookingParams params);
  Future<BookingModel> show(BookingParam params);
  Future<BookingModel> setBookingStatus(BookingStatusParams params);
  Future<AnalyticsModel> analytics(NoParams params);
}
