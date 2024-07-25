import 'package:adminetic_booking/core/utils/widgets/app_loader.dart';
import 'package:adminetic_booking/core/utils/widgets/app_snack_bar.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:adminetic_booking/core/presentation/widgets/app_layout.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_list.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/no_booking_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PendingBookingPage extends StatefulWidget {
  const PendingBookingPage({super.key});

  @override
  State<PendingBookingPage> createState() => _PendingBookingPageState();
}

class _PendingBookingPageState extends State<PendingBookingPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(GetAllPendingBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      body: BlocConsumer<BookingBloc, BookingState>(listener: (context, state) {
        if (state is BookingFailure) {
          showErrorMessage(context, state.message);
        }
      }, builder: (context, state) {
        if (state is BookingListSuccess) {
          if (state.bookings.isEmpty) {
            return const NoBookingFoundPage();
          }
          final List<Booking> bookings = state.bookings;
          return BookingList(bookings: bookings);
        } else {
          return const NoBookingFoundPage();
        }
      }),
    );
  }
}
