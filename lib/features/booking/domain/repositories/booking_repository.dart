import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/all_booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_status_params.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BookingRepository {
  Future<Either<Failure, List<Booking>>> all(AllBookingParams params);

  Future<Either<Failure, Booking>> show(BookingParam params);

  Future<Either<Failure, void>> setBookingStatus(BookingStatusParams params);
}
