import 'package:adminetic_booking/features/booking/data/models/booking_model.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/show_booking.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BookingRemoteDataSource {
  Future<List<BookingModel>> all();
  Future<BookingModel> show(BookingParam params);
}
