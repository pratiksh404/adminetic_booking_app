part of 'booking_bloc.dart';

@immutable
sealed class BookingState {}

final class BookingInitial extends BookingState {}

final class BookingLoading extends BookingState {}

final class BookingSuccess extends BookingState {}

final class BookingListSuccess extends BookingState {
  final List<Booking> bookings;
  BookingListSuccess({required this.bookings});
}

final class ShowBookingSuccess extends BookingState {
  final Booking booking;
  ShowBookingSuccess({required this.booking});
}

final class BookingAnalyticsSuccess extends BookingState {
  final Analytics analytics;
  BookingAnalyticsSuccess({required this.analytics});
}

final class BookingFailure extends BookingState {
  final String message;
  final String? errors;
  BookingFailure({required this.message, this.errors});
}

final class RefreshBookingBloc extends BookingState {}
