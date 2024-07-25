import 'package:adminetic_booking/core/bloc/bloc_observer.dart';
import 'package:adminetic_booking/core/presentation/cubit/app_user/app_user_cubit.dart';
import 'package:adminetic_booking/core/presentation/pages/home_page.dart';
import 'package:adminetic_booking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:adminetic_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:flutter/material.dart';

import 'package:adminetic_booking/core/init_dependencies.dart';
import 'package:adminetic_booking/core/theme/theme.dart';
import 'package:adminetic_booking/features/auth/presentation/pages/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

// Dependencies Initialization
  await initDependencies();
  Bloc.observer = GlobalBlocObserver();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => serviceLocator<AppUserCubit>()),
      BlocProvider(create: (context) => serviceLocator<AuthBloc>()),
      BlocProvider(create: (context) => serviceLocator<BookingBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheck());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Adminetic Booking Management',
      theme: AppTheme.light(context),
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isUserLoggedIn) {
          return isUserLoggedIn ? const HomePage() : const SignIn();
        },
      ),
    );
  }
}
