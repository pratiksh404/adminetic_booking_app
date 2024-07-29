import 'package:adminetic_booking/core/presentation/widgets/booking_count_list_tile.dart';
import 'package:adminetic_booking/features/booking/domain/entities/analytics.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/approved_booking_page.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/pending_booking_page.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/terminated_booking_page.dart';
import 'package:flutter/material.dart';

class BookingStatusCountTiles extends StatelessWidget {
  final Analytics analytics;
  const BookingStatusCountTiles({super.key, required this.analytics});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookingCountListTile(
            text: 'Pending',
            leading:
                Image.asset('assets/pending.png', width: 30.0, height: 30.0),
            trailing: Text('${analytics.pendingBookingCount}'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const PendingBookingPage()));
            }),
        const SizedBox(height: 15),
        BookingCountListTile(
            text: 'Approved',
            leading:
                Image.asset('assets/approved.png', width: 30.0, height: 30.0),
            trailing: Text('${analytics.approvedBookingCount}'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const ApprovedBookingPage()));
            }),
        const SizedBox(height: 15),
        BookingCountListTile(
            text: 'Terminated',
            leading:
                Image.asset('assets/terminated.png', width: 30.0, height: 30.0),
            trailing: Text('${analytics.terminatedBookingCount}'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const TerminatedBookingPage()));
            }),
      ],
    );
  }
}
