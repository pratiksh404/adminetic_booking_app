import 'package:adminetic_booking/core/presentation/widgets/app_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppLayout(body: Center(child: Text('Home Page')));
  }
}
