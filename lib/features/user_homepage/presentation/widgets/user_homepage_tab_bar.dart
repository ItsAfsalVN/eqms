import 'package:flutter/material.dart';

class UserHomepageTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const UserHomepageTabBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _TabItem(
                  title: 'Inspection Form',
                  isSelected: selectedIndex == 0,
                  onTap: () => onTabSelected(0),
                ),
              ),
              Expanded(
                child: _TabItem(
                  title: 'Dashboard',
                  isSelected: selectedIndex == 1,
                  onTap: () => onTabSelected(1),
                ),
              ),
            ],
          ),
          Container(
            height: 1,
            color: theme.dividerColor,
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? (isDark ? Colors.white : primaryColor)
                    : (isDark ? Colors.white60 : theme.colorScheme.onSurface.withValues(alpha: 0.7)),
              ),
            ),
          ),
          Container(
            height: 3,
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
