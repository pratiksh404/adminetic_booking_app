import 'package:adminetic_booking/core/bloc/bloc_observer.dart';
import 'package:adminetic_booking/core/presentation/cubit/app_user/app_user_cubit.dart';
import 'package:adminetic_booking/core/presentation/pages/home_page.dart';
import 'package:adminetic_booking/core/services/local_notification_service.dart';
import 'package:adminetic_booking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:adminetic_booking/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:adminetic_booking/core/init_dependencies.dart';
import 'package:adminetic_booking/core/theme/theme.dart';
import 'package:adminetic_booking/features/auth/presentation/pages/sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

// FlutterFire's Firebase Cloud Messaging plugin
import 'package:firebase_messaging/firebase_messaging.dart';

// Add stream controller
final _messageStreamController = BehaviorSubject<RemoteMessage>();
// Define the background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Dependencies Initialization
  await initDependencies();

  await LocalNotificationService().init();

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

    // Set up foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Handling a foreground message: ${message.messageId}');
        print('Message data: ${message.data}');
        print('Message notification: ${message.notification?.title}');
        print('Message notification: ${message.notification?.body}');
      }

      LocalNotificationService().showNotificationAndroid(
          message.notification?.title ?? '', message.notification?.body ?? '');
      _messageStreamController.sink.add(message);
    });
    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
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
