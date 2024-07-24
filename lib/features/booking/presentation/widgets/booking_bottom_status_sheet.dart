import 'package:flutter/material.dart';

void showBookingBottomStatusSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return BookingBottomStatusSheet();
    },
  );
}

class BookingBottomStatusSheet extends StatefulWidget {
  const BookingBottomStatusSheet({super.key});

  @override
  State<BookingBottomStatusSheet> createState() =>
      _BookingBottomStatusSheetState();
}

class _BookingBottomStatusSheetState extends State<BookingBottomStatusSheet> {
  String? _status = 'Approved';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Select Status',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ListTile(
            title: Text('Approved'),
            leading: Radio<String>(
              value: 'Approved',
              groupValue: _status,
              onChanged: (String? value) {
                setState(() {
                  _status = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Pending'),
            leading: Radio<String>(
              value: 'Pending',
              groupValue: _status,
              onChanged: (String? value) {
                setState(() {
                  _status = value;
                });
              },
            ),
          ),
          ListTile(
            title: Text('Rejected'),
            leading: Radio<String>(
              value: 'Rejected',
              groupValue: _status,
              onChanged: (String? value) {
                setState(() {
                  _status = value;
                });
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(60),
            ),
            child: Text('Submit'),
            onPressed: () {
              Navigator.pop(context, _status);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Selected status: $_status')),
              );
            },
          ),
        ],
      ),
    );
  }
}
