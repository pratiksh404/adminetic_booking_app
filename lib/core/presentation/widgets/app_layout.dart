import 'package:adminetic_booking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:adminetic_booking/core/presentation/widgets/app_bottom_navbar.dart';
import 'package:adminetic_booking/core/presentation/widgets/booking_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLayout extends StatelessWidget {
  final Widget body;
  final Widget? floatingActionWidget;
  const AppLayout({super.key, required this.body, this.floatingActionWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BookingSearchBar(),
        actions: [
          // Logout Button

          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return state is AuthLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : IconButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthSignOut());
                      },
                      icon: const Icon(Icons.logout),
                    );
            },
          ),
        ],
      ),
      body: body,
      bottomNavigationBar: const AppBottomNavbar(),
      floatingActionButton: floatingActionWidget,
    );
  }
}
