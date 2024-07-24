import 'package:adminetic_booking/core/extensions/extensions.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking_quantity.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/booking_bottom_status_sheet.dart';
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
        showBookingBottomStatusSheet(context);
      },
      child: Card(
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    booking.serial_no,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      booking.status.label,
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: HexColor.fromHex(booking.status.color),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                booking.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(booking.email),
              SizedBox(height: 15),
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
              Divider(),
              Text(booking.activity.name,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(booking.activity.type),
              SizedBox(height: 10),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      10), // Optional: for rounded corners
                  child: Image.network(
                    booking.activity.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Start Date: ${booking.start_date}"),
                      Text("End Date: ${booking.end_date}"),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("Duration: ${booking.duration} day"),
                      Text("Fee: ${booking.fee}"),
                      Text("Dues: ${booking.dues}"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text("Created at: ${booking.created_at}"),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
