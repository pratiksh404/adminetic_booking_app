part of 'booking_bloc.dart';

@immutable
sealed class BookingEvent {}

final class GetAllBookingsEvent extends BookingEvent {}

final class GetAllPendingBookingsEvent extends BookingEvent {}

final class GetAllApprovedBookingsEvent extends BookingEvent {}

final class GetAllTerminatedBookingsEvent extends BookingEvent {}
