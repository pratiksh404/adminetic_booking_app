import 'package:adminetic_booking/core/utils/widgets/app_loader.dart';
import 'package:adminetic_booking/core/utils/widgets/app_snack_bar.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:adminetic_booking/core/presentation/widgets/app_layout.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_list.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/no_booking_found_page.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchedBookingPage extends StatefulWidget {
  final String search;
  const SearchedBookingPage({super.key, required this.search});

  @override
  State<SearchedBookingPage> createState() => _SearchedBookingPageState();
}

class _SearchedBookingPageState extends State<SearchedBookingPage> {
  late EasyRefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    context
        .read<BookingBloc>()
        .add(GetAllSearchedBookingsEvent(search: widget.search));
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      body: EasyRefresh(
        controller: _refreshController,
        header: const MaterialHeader(),
        footer: const MaterialFooter(),
        onRefresh: () {
          context
              .read<BookingBloc>()
              .add(GetAllSearchedBookingsEvent(search: widget.search));
          _refreshController.finishRefresh();
          _refreshController.resetFooter();
        },
        onLoad: () => _refreshController.finishLoad(),
        child:
            BlocConsumer<BookingBloc, BookingState>(listener: (context, state) {
          if (state is BookingFailure) {
            showErrorMessage(context, state.message);
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
      ),
    );
  }
}
