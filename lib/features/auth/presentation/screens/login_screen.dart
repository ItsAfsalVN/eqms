import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:eqms/core/widgets/app_action_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 28,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
                      SvgPicture.asset(
                        'assets/images/logo-light.svg',
                        height: 72,
                      ),
                      SvgPicture.asset(
                        'assets/images/logo-text-light.svg',
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                  AppActionButton(
                    isLoading: false,
                    label: 'Login',
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed('/user_homepage');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
