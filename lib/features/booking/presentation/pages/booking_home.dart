import 'package:adminetic_booking/core/theme/app_colors.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_bottom_navbar.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_card.dart';
import 'package:flutter/material.dart';

class BookingHome extends StatefulWidget {
  const BookingHome({super.key});

  @override
  State<BookingHome> createState() => _BookingHomeState();
}

class _BookingHomeState extends State<BookingHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: AppColors.textGrey),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            // Perform search functionality here
          },
        ),
      ),
      body: ListView.builder(
        itemCount:
            1, // Adjust according to the number of dummy bookings you want
        itemBuilder: (context, index) {
          return BookingCard();
        },
      ),
      bottomNavigationBar: BookingBottomNavbar(),
    );
  }
}
