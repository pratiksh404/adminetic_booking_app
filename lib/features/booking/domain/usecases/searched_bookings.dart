import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/repositories/booking_repository.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/all_booking_params.dart';
import 'package:fpdart/src/either.dart';

class SearchedBookings implements UseCase<List<Booking>, AllBookingParams> {
  final BookingRepository bookingRepository;
  SearchedBookings({required this.bookingRepository});
  @override
  Future<Either<Failure, List<Booking>>> call(AllBookingParams params) async {
    return await bookingRepository.all(params.copyWith(search: params.search));
  }
}
