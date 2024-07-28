import 'package:flutter/material.dart';

class TopBookings extends StatelessWidget {
  final Map<String, int> topBookings;

  const TopBookings({
    super.key,
    required this.topBookings,
  });

  @override
  Widget build(BuildContext context) {
    // Sort the bookings by count in descending order and take the top 10
    final sortedBookings = topBookings.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value))
      ..take(10);

    return Column(
      children: [
        const Text(
          'Top Bookings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300,
          child: ListView.builder(
            itemCount: sortedBookings.length,
            itemBuilder: (context, index) {
              final booking = sortedBookings.elementAt(index);
              final position = index + 1;
              final Widget leading;

              if (position == 1) {
                leading = Image.asset(
                  'assets/first.png',
                  height: 25,
                );
              } else if (position == 2) {
                leading = Image.asset('assets/second.png', height: 25);
              } else if (position == 3) {
                leading = Image.asset('assets/third.png', height: 25);
              } else {
                leading = Icon(
                  Icons.star,
                  color: Colors.amber[600],
                );
              }

              return ListTile(
                leading: leading,
                title: Text(
                  booking.key,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: Text(
                  '${booking.value}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                tileColor: index.isEven ? Colors.grey[100] : Colors.white,
              );
            },
          ),
        ),
      ],
    );
  }
}
