import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo
          SvgPicture.asset(
            'assets/icons/user.svg',
            width: 34,
            height: 34,
            colorFilter: ColorFilter.mode(
              theme.colorScheme.onSurface,
              BlendMode.srcIn,
            ),
          ),

          // User details
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                userName,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSurface,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                userRole,
                style: theme.textTheme.bodySmall?.copyWith(
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
