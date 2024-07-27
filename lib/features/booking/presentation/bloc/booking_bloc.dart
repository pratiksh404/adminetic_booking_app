import 'package:adminetic_booking/core/usecase.dart';
import 'package:adminetic_booking/features/booking/domain/entities/analytics.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/all_bookings.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/approved_bookings.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/get_booking_analytics.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/all_booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/booking_status_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/pending_bookings.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/set_booking_status.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/show_booking.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/terminated_bookings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final AllBookings _allBookings;
  final PendingBookings _pendingBookings;
  final ApprovedBookings _approvedBookings;
  final TerminatedBookings _terminatedBookings;
  final SetBookingStatus _setBookingStatus;
  final GetBookingAnalytics _getBookingAnalytics;
  final ShowBooking _showBooking;
  BookingBloc(
      {required AllBookings allBookings,
      required PendingBookings pendingBookings,
      required ApprovedBookings approvedBookings,
      required TerminatedBookings terminatedBookings,
      required SetBookingStatus setBookingStatus,
      required GetBookingAnalytics getBookingAnalytics,
      required ShowBooking showBooking})
      : _allBookings = allBookings,
        _pendingBookings = pendingBookings,
        _approvedBookings = approvedBookings,
        _terminatedBookings = terminatedBookings,
        _setBookingStatus = setBookingStatus,
        _getBookingAnalytics = getBookingAnalytics,
        _showBooking = showBooking,
        super(BookingInitial()) {
    on<BookingEvent>((_, emit) => emit(BookingLoading()));
    on<GetAllBookingsEvent>(_onGetAllBookingsEvent);
    on<GetAllPendingBookingsEvent>(_onGetAllPendingBookingsEvent);
    on<GetAllApprovedBookingsEvent>(_onGetAllApprovedBookingsEvent);
    on<GetAllTerminatedBookingsEvent>(_onGetAllTerminatedBookingsEvent);
    on<SetBookingStatusEvent>(_onSetBookingStatusEvent);
    on<GetBookingAnalyticsEvent>(_onGetBookingAnalyticsEvent);
    on<ShowBookingEvent>(_onShowBookingEvent);
  }

  void _onGetAllBookingsEvent(
      GetAllBookingsEvent event, Emitter<BookingState> emit) async {
    final response = await _allBookings(AllBookingParams());
    response.fold((failure) => emit(BookingFailure(message: failure.message)),
        (bookings) => emit(BookingListSuccess(bookings: bookings)));
  }

  void _onGetAllPendingBookingsEvent(
      GetAllPendingBookingsEvent event, Emitter<BookingState> emit) async {
    final response = await _pendingBookings(AllBookingParams());
    response.fold((failure) => emit(BookingFailure(message: failure.message)),
        (bookings) => emit(BookingListSuccess(bookings: bookings)));
  }

  void _onGetAllApprovedBookingsEvent(
      GetAllApprovedBookingsEvent event, Emitter<BookingState> emit) async {
    final response = await _approvedBookings(AllBookingParams());
    response.fold((failure) => emit(BookingFailure(message: failure.message)),
        (bookings) => emit(BookingListSuccess(bookings: bookings)));
  }

  void _onGetAllTerminatedBookingsEvent(
      GetAllTerminatedBookingsEvent event, Emitter<BookingState> emit) async {
    final response = await _terminatedBookings(AllBookingParams());
    response.fold((failure) => emit(BookingFailure(message: failure.message)),
        (bookings) => emit(BookingListSuccess(bookings: bookings)));
  }

  void _onSetBookingStatusEvent(
      SetBookingStatusEvent event, Emitter<BookingState> emit) async {
    final response = await _setBookingStatus(BookingStatusParams(
      booking: event.booking,
      status: event.status,
    ));
    return response.fold(
        (failure) => emit(BookingFailure(message: failure.message)),
        (booking) => emit(BookingSuccess()));
  }

  void _onGetBookingAnalyticsEvent(
      GetBookingAnalyticsEvent event, Emitter<BookingState> emit) async {
    final response = await _getBookingAnalytics(NoParams());
    response.fold((failure) => emit(BookingFailure(message: failure.message)),
        (analytics) => emit(BookingAnalyticsSuccess(analytics: analytics)));
  }

  void _onShowBookingEvent(
      ShowBookingEvent event, Emitter<BookingState> emit) async {
    final response = await _showBooking(BookingParam(id: event.id));
    response.fold((failure) => emit(BookingFailure(message: failure.message)),
        (booking) => emit(ShowBookingSuccess(booking: booking)));
  }
}
