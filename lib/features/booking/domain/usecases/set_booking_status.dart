import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/booking/domain/repositories/booking_repository.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_status_params.dart';
import 'package:fpdart/fpdart.dart';

class SetBookingStatus implements UseCase<void, BookingStatusParams> {
  final BookingRepository bookingRepository;
  SetBookingStatus({required this.bookingRepository});
  @override
  Future<Either<Failure, void>> call(BookingStatusParams params) async {
    return await bookingRepository.setBookingStatus(params);
  }
}
