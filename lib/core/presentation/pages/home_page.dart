import 'package:adminetic_booking/core/entities/user.dart';
import 'package:adminetic_booking/core/presentation/cubit/app_user/app_user_cubit.dart';
import 'package:adminetic_booking/core/presentation/widgets/app_layout.dart';
import 'package:adminetic_booking/core/presentation/widgets/booking_count_list_tile.dart';
import 'package:adminetic_booking/core/presentation/widgets/booking_status_count_tiles.dart';
import 'package:adminetic_booking/core/presentation/widgets/charts/booking_status_pie_chart.dart';
import 'package:adminetic_booking/core/presentation/widgets/charts/chart_holder.dart';
import 'package:adminetic_booking/core/presentation/widgets/charts/monthly_booking_count_bar_chart.dart';
import 'package:adminetic_booking/core/presentation/widgets/top_bookings.dart';
import 'package:adminetic_booking/core/theme/app_colors.dart';
import 'package:adminetic_booking/core/utils/widgets/app_loader.dart';
import 'package:adminetic_booking/core/utils/widgets/app_snack_bar.dart';
import 'package:adminetic_booking/features/booking/domain/entities/analytics.dart';
import 'package:adminetic_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/approved_booking_page.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/pending_booking_page.dart';
import 'package:adminetic_booking/features/booking/presentation/pages/terminated_booking_page.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EasyRefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
    context.read<BookingBloc>().add(GetBookingAnalyticsEvent());
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      body: EasyRefresh(
        controller: _refreshController,
        header: const MaterialHeader(),
        footer: const MaterialFooter(),
        onRefresh: () async {
          context.read<BookingBloc>().add(GetBookingAnalyticsEvent());
          _refreshController.finishRefresh();
          _refreshController.resetFooter();
        },
        onLoad: () async {
          _refreshController.finishLoad();
        },
        child: BlocConsumer<BookingBloc, BookingState>(
          listener: (context, state) {
            if (state is BookingFailure) {
              showErrorMessage(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is BookingLoading) {
              return AppLoader();
            } else {
              if (state is BookingAnalyticsSuccess) {
                final Analytics analytics = state.analytics;
                return Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BlocBuilder<AppUserCubit, AppUserState>(
                              builder: (context, state) {
                            if (state is AppUserLoggedIn) {
                              return WelcomeBar(
                                title: "Welcome,",
                                upperTitle: state.user.name,
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                          const SizedBox(height: 15),
                          ChartHolder(
                              height: 250,
                              chart: MonthlyBookingCountBarChart(
                                  bookingCountPerMonthInterval:
                                      analytics.bookingCountPerMonthInterval),
                              name: "Booking Count Per Month"),
                          const SizedBox(height: 15),
                          Container(
                              child: BookingStatusCountTiles(
                                  analytics: analytics)),
                          const SizedBox(height: 15),
                          TopBookings(
                              topBookings: analytics.topBookings.map(
                                  (key, value) =>
                                      MapEntry(key, int.parse(value)))),
                        ],
                      ),
                    ));
              }
              return const Center(
                  child: Text('Failed to load booking analytics'));
            }
          },
        ),
      ),
    );
  }
}

class WelcomeBar extends StatelessWidget {
  final String title;
  final String upperTitle;
  const WelcomeBar({required this.title, required this.upperTitle, Key? key})
      : super(key: key);
  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          AppColors.appPrimaryColor,
          AppColors.appSecondaryColor
        ])),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.normal)),
              Text(upperTitle,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    );
  }
}
