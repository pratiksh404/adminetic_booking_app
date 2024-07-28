import 'package:adminetic_booking/core/exceptions/failure.dart';
import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/booking/domain/entities/analytics.dart';
import 'package:adminetic_booking/features/booking/domain/repositories/booking_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetBookingAnalytics implements UseCase<Analytics, NoParams> {
  final BookingRepository bookingRepository;
  GetBookingAnalytics({required this.bookingRepository});
  @override
  Future<Either<Failure, Analytics>> call(NoParams params) async {
    return await bookingRepository.analytics(params);
  }
}
