import 'package:flutter/material.dart';
import 'custom_icons.dart';

class UserHomepageHeader extends StatelessWidget {
  final String userName;
  final String userRole;

  const UserHomepageHeader({
    super.key,
    this.userName = 'Afsal VN',
    this.userRole = 'QA Analyst',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          AppDropLogo(size: 34, color: primaryColor),

          // User details
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : primaryColor,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                userRole,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
