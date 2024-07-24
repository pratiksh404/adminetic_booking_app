import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';

class BookingList extends StatefulWidget {
  final List<Booking> bookings;
  const BookingList({super.key, required this.bookings});

  @override
  State<BookingList> createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.bookings
          .length, // Adjust according to the number of dummy bookings you want
      itemBuilder: (context, index) {
        return BookingCard(booking: widget.bookings[index]);
      },
    );
  }
}
