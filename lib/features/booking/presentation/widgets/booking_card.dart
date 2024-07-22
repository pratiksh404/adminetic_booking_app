import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
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
                  '#00000001',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Chip(
                  avatar: Icon(Icons.warning, color: Colors.white),
                  label: Text(
                    'Pending',
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Color(0xFFFF9900),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Pratik Shrestha',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text('pratikdai404@gmail.com'),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Children'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        '1',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Student'),
                    ],
                  ),
                ),
              ],
            ),
            Divider(),
            Text("Activity: Arun River rafting"),
            Text("Type: Rafting"),
            SizedBox(height: 10),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Optional: for rounded corners
                child: Image.network(
                  'https://rafting.test/adminetic/static/default/rafting/1.jpg',
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
                    Text("Start Date: Thu 25 Jul 2024"),
                    Text("End Date: Thu 25 Jul 2024"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Duration: 1 day"),
                    Text("Fee: Rs.0"),
                    Text("Dues: Rs.0"),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text("Created at: 2024-07-14T10:20:38.000000Z"),
            SizedBox(height: 10),
            ButtonBar(
              buttonPadding: EdgeInsets.zero,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Approve action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Approve'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Reject action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Reject'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Pending action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Pending'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
