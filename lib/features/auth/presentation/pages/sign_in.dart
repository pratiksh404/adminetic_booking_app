import 'package:adminetic_booking/core/contants/ghaps.dart';
// ignore: unused_import
import 'package:adminetic_booking/core/theme/app_colors.dart';
import 'package:adminetic_booking/core/theme/app_defaults.dart';
import 'package:adminetic_booking/core/utils/widgets/app_snack_bar.dart';
import 'package:adminetic_booking/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Dispose
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            AppToast(context: context).show("Login Successful");
          }
          if (state is AuthFailure) {
            AppToast(
                    context: context,
                    backgroundColor: GFColors.DANGER,
                    color: GFColors.WHITE,
                    icon: Icons.close)
                .show(state.message);
            if (state.errors != null) {
              // Shoe App Toast for each map of errors
              state.errors!.forEach((key, value) {
                AppToast(
                        context: context,
                        backgroundColor: GFColors.DANGER,
                        color: GFColors.WHITE,
                        icon: Icons.close)
                    .show(value);
              });
            }
          }
        },
        builder: (context, state) {
          return state is AuthLoading
              ? const GFLoader()
              : SafeArea(
                  child: Form(
                    key: _formKey,
                    child: Center(
                      child: SingleChildScrollView(
                        child: Center(
                          child: SizedBox(
                            width: 296,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Sign In',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                gapH24,
                                Text(
                                  'Adminetic Booking Management',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                gapH24,

                                /// EMAIL TEXT FIELD
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                    ),
                                    hintText: 'Your email',
                                  ),
                                  controller: _emailController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                                gapH16,

                                /// PASSWORD TEXT FIELD
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock_outline,
                                    ),
                                    hintText: 'Password',
                                  ),
                                  controller: _passwordController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                gapH16,

                                /// SIGN IN BUTTON
                                SizedBox(
                                  width: 296,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        BlocProvider.of<AuthBloc>(context).add(
                                          AuthSignIn(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      }
                                    },
                                    child: const Text('Sign in'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
