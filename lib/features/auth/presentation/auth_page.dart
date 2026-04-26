import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:have_you_heard/core/di/service_locator.dart';
import 'package:have_you_heard/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:have_you_heard/features/auth/presentation/widgets/auth_button.dart';
import 'package:have_you_heard/features/auth/presentation/widgets/slide_up_widget.dart';

@RoutePage()
class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(sl()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              SvgPicture.asset('assets/svg/logo.svg',
                  fit: BoxFit.scaleDown, height: 100, width: 250),
              SlideUpWidget(
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AuthButton(
                        onPressed: () {
                          context
                              .read<AuthBloc>()
                              .add(LoginWithSpotifyEvent());
                        },
                        isActive: state is! AuthLoading);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
