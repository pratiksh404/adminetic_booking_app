import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/repositories/booking_repository.dart';
import 'package:fpdart/fpdart.dart';

class AllBookings implements UseCase<List<Booking>, NoParams> {
  final BookingRepository bookingRepository;
  AllBookings({required this.bookingRepository});
  @override
  Future<Either<Failure, List<Booking>>> call(NoParams params) async {
    return await bookingRepository.all();
  }
}
