import 'package:adminetic_booking/core/extensions/extensions.dart';
import 'package:adminetic_booking/core/helpers/url_launcher.dart';
import 'package:adminetic_booking/core/theme/app_colors.dart';
import 'package:adminetic_booking/core/utils/widgets/app_loader.dart';
import 'package:adminetic_booking/core/utils/widgets/app_snack_bar.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking.dart';
import 'package:adminetic_booking/features/booking/domain/entities/booking_quantity.dart';
import 'package:adminetic_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:adminetic_booking/core/presentation/widgets/app_layout.dart';
import 'package:adminetic_booking/features/booking/presentation/widgets/no_booking_found_page.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class BookingPage extends StatefulWidget {
  late Booking? booking;
  final String code;

  BookingPage({super.key, this.booking, required this.code});
  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  late EasyRefreshController _refreshController;
  @override
  void initState() {
    super.initState();
    if (widget.booking == null) {
      context.read<BookingBloc>().add(ShowBookingEvent(code: widget.code));
    }
    _refreshController = EasyRefreshController(
      controlFinishRefresh: true,
      controlFinishLoad: true,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Booking? booking = widget.booking;
    final String code = widget.code;

    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingFailure) {
          showErrorMessage(context, "Failed to change status");
        }
        if (state is BookingSuccess) {
          context.read<BookingBloc>().add(ShowBookingEvent(code: code));
        }
      },
      builder: (context, state) {
        if (state is BookingLoading) {
          return AppLayout(body: const AppLoader());
        }

        if (state is ShowBookingSuccess) {
          booking = state.booking;
        }

        if (booking == null) {
          return const AppLayout(body: NoBookingFoundPage());
        }
        final List<BookingQuantity> quantities = booking!.quantities;
        return AppLayout(
          body: state is BookingLoading
              ? const AppLoader()
              : EasyRefresh(
                  controller: _refreshController,
                  header: const MaterialHeader(),
                  footer: const MaterialFooter(),
                  onRefresh: () async {
                    context
                        .read<BookingBloc>()
                        .add(ShowBookingEvent(code: booking!.code));
                    _refreshController.finishRefresh();
                    _refreshController.resetFooter();
                  },
                  onLoad: () => _refreshController.finishLoad(),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BookingTitle(
                            title: booking!.activity.type,
                            upperTitle: booking!.activity.name,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                booking!.serial_no,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Spacer(),
                              Chip(
                                label: Text(
                                  booking!.status.label,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor:
                                    HexColor.fromHex(booking!.status.color),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            booking!.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(booking!.email),
                          const SizedBox(height: 15),
                          if (quantities.isNotEmpty)
                            ListView.builder(
                              shrinkWrap:
                                  true, // Makes ListView occupy only as much space as needed
                              physics:
                                  const NeverScrollableScrollPhysics(), // Prevents ListView from scrolling
                              itemCount:
                                  1, // Since you are creating only one Row
                              itemBuilder: (context, index) {
                                return Row(
                                  children:
                                      List.generate(quantities.length, (index) {
                                    final BookingQuantity quantity =
                                        quantities[index];
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
                          const SizedBox(height: 10),
                          AspectRatio(
                            aspectRatio: 16 / 9,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10), // Optional: for rounded corners
                              child: Image.network(
                                booking!.activity.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Start Date: ${booking!.start_date}"),
                                  Text("End Date: ${booking!.end_date}"),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Duration: ${booking!.duration} day"),
                                  Text("Fee: ${booking!.fee}"),
                                  Text("Dues: ${booking!.dues}"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text("Created at: ${booking!.created_at}"),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
          floatingActionWidget: state is BookingLoading
              ? SizedBox()
              : SpeedDial(
                  animatedIcon: AnimatedIcons.menu_close,
                  animatedIconTheme: const IconThemeData(size: 22),
                  backgroundColor: AppColors.bgLight,
                  visible: true,
                  curve: Curves.bounceIn,
                  children: [
                    SpeedDialChild(
                        child: const Icon(Icons.mail),
                        backgroundColor: AppColors.bgLight,
                        onTap: () async {
                          sendEmail(booking!.email, {
                            'subject':
                                "Regarding your booking ${booking!.serial_no}",
                          });
                        },
                        label: 'Email',
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLight,
                            fontSize: 16.0),
                        labelBackgroundColor: AppColors.bgLight),
                    SpeedDialChild(
                        child: const Icon(Icons.cancel),
                        backgroundColor: AppColors.bgLight,
                        onTap: () {
                          context.read<BookingBloc>().add(SetBookingStatusEvent(
                                booking: booking!,
                                status: 'Terminated',
                              ));
                        },
                        label: 'Reject',
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLight,
                            fontSize: 16.0),
                        labelBackgroundColor: AppColors.bgLight),
                    SpeedDialChild(
                        child: const Icon(Icons.calendar_month),
                        backgroundColor: AppColors.bgLight,
                        onTap: () {
                          context.read<BookingBloc>().add(SetBookingStatusEvent(
                                booking: booking!,
                                status: 'Pending',
                              ));
                        },
                        label: 'Pending',
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLight,
                            fontSize: 16.0),
                        labelBackgroundColor: AppColors.bgLight),
                    SpeedDialChild(
                        child: const Icon(Icons.check),
                        backgroundColor: AppColors.bgLight,
                        onTap: () {
                          context.read<BookingBloc>().add(SetBookingStatusEvent(
                                booking: booking!,
                                status: 'Approved',
                              ));
                        },
                        label: 'Approve',
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.textLight,
                            fontSize: 16.0),
                        labelBackgroundColor: AppColors.bgLight),
                  ],
                ),
        );
      },
    );
  }
}

class BookingTitle extends StatelessWidget {
  final String title;
  final String upperTitle;
  const BookingTitle(
      {required this.title, required this.upperTitle, super.key});
  final primaryColor = const Color(0xff4338CA);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 110,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
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
