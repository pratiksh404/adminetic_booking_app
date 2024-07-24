import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/all_bookings.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/approved_bookings.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/params/all_booking_params.dart';
import 'package:adminetic_booking/features/booking/domain/usecases/pending_bookings.dart';
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
  BookingBloc({
    required AllBookings allBookings,
    required PendingBookings pendingBookings,
    required ApprovedBookings approvedBookings,
    required TerminatedBookings terminatedBookings,
  })  : _allBookings = allBookings,
        _pendingBookings = pendingBookings,
        _approvedBookings = approvedBookings,
        _terminatedBookings = terminatedBookings,
        super(BookingInitial()) {
    on<GetAllBookingsEvent>(_onGetAllBookingsEvent);
    on<GetAllPendingBookingsEvent>(_onGetAllPendingBookingsEvent);
    on<GetAllApprovedBookingsEvent>(_onGetAllApprovedBookingsEvent);
    on<GetAllTerminatedBookingsEvent>(_onGetAllTerminatedBookingsEvent);
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
}
