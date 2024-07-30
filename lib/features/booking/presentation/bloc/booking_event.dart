part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

final class GetAllBookingsEvent extends BookingEvent {}

final class GetAllPendingBookingsEvent extends BookingEvent {}

final class GetAllApprovedBookingsEvent extends BookingEvent {}

final class GetAllTerminatedBookingsEvent extends BookingEvent {}

final class GetAllSearchedBookingsEvent extends BookingEvent {
  final String search;
  GetAllSearchedBookingsEvent({required this.search});
}

final class GetBookingAnalyticsEvent extends BookingEvent {}

final class SetBookingStatusEvent extends BookingEvent {
  final Booking booking;
  final String status;
  SetBookingStatusEvent({required this.booking, required this.status});
}

final class ShowBookingEvent extends BookingEvent {
  final String code;
  ShowBookingEvent({required this.code});
}
