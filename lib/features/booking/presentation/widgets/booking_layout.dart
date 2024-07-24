import 'package:adminetic_booking/features/booking/presentation/widgets/booking_bottom_navbar.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_search_bar.dart';
import 'package:flutter/material.dart';

class BookingLayout extends StatelessWidget {
  final Widget body;
  const BookingLayout({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: BookingSearchBar()),
      body: body,
      bottomNavigationBar: const BookingBottomNavbar(),
    );
  }
}
