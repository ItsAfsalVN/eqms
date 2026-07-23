import 'package:eqms/core/widgets/app_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    const bool isLoading = false;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Better control over spacing
                    children: [
                      SvgPicture.asset(
                        "assets/images/logo-alt-${isLight ? "light" : "dark"}.svg",
                        width: 100,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        flex: 2,
                        child: SvgPicture.asset(
                          "assets/images/hero-image.svg",
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                    Text(
                      "Sign in with your organizational Microsoft account to access your workspace.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.6),
                      ),
                    ),

                    const SizedBox(height: 36.0),
                    AppActionButton(
                      icon: SvgPicture.asset(
                        "assets/icons/microsoft.svg",
                        width: 24,
                        height: 24,
                        colorFilter: isLight
                            ? null
                            : const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                      ),
                      isLoading: isLoading,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          "/user_homepage",
                        );
                      },
                      label: "Sign in with Microsoft",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
