import 'dart:async';

import 'package:adminetic_booking/features/booking/presentation/pages/searched_booking_page.dart';
import 'package:flutter/material.dart';

class BookingSearchBar extends StatefulWidget {
  const BookingSearchBar({super.key});

  @override
  State<BookingSearchBar> createState() => _BookingSearchBarState();
}

class _BookingSearchBarState extends State<BookingSearchBar> {
  Timer? _debounce;
  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged(String search) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => SearchedBookingPage(search: search)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        textAlign: TextAlign.center,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            _onSearchChanged(value);
          }
        },
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.email),
          prefixIcon:
              const Icon(Icons.search, size: 20, color: Color(0xffFF5A60)),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search Booking",
          hintStyle: TextStyle(color: Colors.black.withOpacity(.75)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}
