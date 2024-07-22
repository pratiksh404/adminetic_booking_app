import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/show_booking.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BookingRepository {
  Future<Either<Failure, List<Booking>>> all();

  Future<Either<Failure, Booking>> show(BookingParam params);
}
