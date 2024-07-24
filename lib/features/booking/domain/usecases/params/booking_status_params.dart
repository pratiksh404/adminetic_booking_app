import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';

class BookingStatusParams {
  final Booking booking;
  final String status;
  BookingStatusParams({required this.booking, required this.status});
}
