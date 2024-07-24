import 'package:adminetic_booking/core/utils/widgets/app_loader.dart';
import 'package:adminetic_booking/core/utils/widgets/app_snack_bar.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_layout.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_list.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/no_booking_found_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TerminatedBookingPage extends StatefulWidget {
  const TerminatedBookingPage({super.key});

  @override
  State<TerminatedBookingPage> createState() => _TerminatedBookingPageState();
}

class _TerminatedBookingPageState extends State<TerminatedBookingPage> {
  @override
  void initState() {
    super.initState();
    context.read<BookingBloc>().add(GetAllTerminatedBookingsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BookingLayout(
      body: BlocConsumer<BookingBloc, BookingState>(listener: (context, state) {
        if (state is BookingFailure) {
          showErrorMessage(context, state.message);
        }
        if (state is BookingListSuccess) {
          showSuccessMessage(
              context, "${state.bookings.length} bookings found");
        }
      }, builder: (context, state) {
        if (state is BookingLoading) {
          return const AppLoader();
        }
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
