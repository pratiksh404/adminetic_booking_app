import 'package:adminetic_booking/core/presentation/pages/home_page.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/approved_booking_page.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/pending_booking_page.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/qrcode_booking_scanner.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/terminated_booking_page.dart';
import 'package:flutter/material.dart';

class AppBottomNavbar extends StatelessWidget {
  const AppBottomNavbar({super.key});

  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.white,
      child: SizedBox(
        height: 56,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 25.0, right: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconBottomBar(
                  text: "Dashboard",
                  icon: Icons.home,
                  selected: true,
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const HomePage()));
                  }),
              IconBottomBar(
                  text: "QR Scanner",
                  icon: Icons.qr_code_scanner,
                  selected: false,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const QrcodeBookingScanner()));
                  }),
              IconBottomBar2(
                  text: "Pending",
                  icon: Icons.calendar_month,
                  selected: false,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PendingBookingPage()));
                  }),
              IconBottomBar(
                  text: "Approved",
                  icon: Icons.check_circle_sharp,
                  selected: false,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ApprovedBookingPage()));
                  }),
              IconBottomBar(
                  text: "Rejected",
                  icon: Icons.cancel_sharp,
                  selected: false,
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const TerminatedBookingPage()));
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class IconBottomBar extends StatelessWidget {
  const IconBottomBar(
      {super.key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed});
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;

  final primaryColor = const Color(0xff4338CA);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            icon,
            size: 25,
            color: selected ? primaryColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}

class IconBottomBar2 extends StatelessWidget {
  const IconBottomBar2(
      {super.key,
      required this.text,
      required this.icon,
      required this.selected,
      required this.onPressed});
  final String text;
  final IconData icon;
  final bool selected;
  final Function() onPressed;
  final primaryColor = const Color(0xff4338CA);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: primaryColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
