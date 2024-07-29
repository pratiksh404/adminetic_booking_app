import 'package:adminetic_booking/core/extensions/extensions.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking_quantity.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/booking_page.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatefulWidget {
  final Booking booking;

  const BookingCard({super.key, required this.booking});
  @override
  State<BookingCard> createState() => _BookingCardState();
}

class _BookingCardState extends State<BookingCard> {
  @override
  Widget build(BuildContext context) {
    final Booking booking = widget.booking;
    final List<BookingQuantity> quantities = booking.quantities;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => BookingPage(
                      booking: booking,
                      bookingID: booking.id,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    booking.serial_no,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      booking.status.label,
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: HexColor.fromHex(booking.status.color),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                booking.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(booking.email),
              const SizedBox(height: 15),
              if (quantities.isNotEmpty)
                ListView.builder(
                  shrinkWrap:
                      true, // Makes ListView occupy only as much space as needed
                  physics:
                      const NeverScrollableScrollPhysics(), // Prevents ListView from scrolling
                  itemCount: 1, // Since you are creating only one Row
                  itemBuilder: (context, index) {
                    return Row(
                      children: List.generate(quantities.length, (index) {
                        final BookingQuantity quantity = quantities[index];
                        return Expanded(
                          child: Column(
                            children: [
                              Text(
                                quantity.qty,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(quantity.name),
                            ],
                          ),
                        );
                      }),
                    );
                  },
                ),
              const Divider(),
              Text("${booking.activity.name} - ${booking.activity.type}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
