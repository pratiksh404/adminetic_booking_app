import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/repositories/booking_repository.dart';
import 'package:fpdart/src/either.dart';

class ShowBooking implements UseCase<Booking, BookingParam> {
  final BookingRepository bookingRepository;
  ShowBooking({required this.bookingRepository});
  @override
  Future<Either<Failure, Booking>> call(BookingParam params) async {
    return await bookingRepository.show(params);
  }
}

class BookingParam {
  final Booking booking;
  BookingParam({required this.booking});
}
