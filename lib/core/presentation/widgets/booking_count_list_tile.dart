import 'package:flutter/material.dart';

class BookingCountListTile extends StatelessWidget {
  final String text;
  final Widget leading;
  final Widget trailing;
  final Function() onTap;
  final Color color;
  const BookingCountListTile(
      {required this.text,
      required this.leading,
      required this.trailing,
      required this.onTap,
      this.color = const Color(0xFF4338CA),
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 5,
      child: ListTileTheme(
        textColor: color,
        iconColor: color,
        child: ListTile(
          leading: leading,
          title: Text(
            text,
          ),
          trailing: trailing,
          selected: false,
          onTap: onTap,
        ),
      ),
    );
  }
}
