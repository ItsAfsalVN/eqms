import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserHomepageBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const UserHomepageBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unselectedColor = theme.unselectedWidgetColor;
    final selectedIconColor = theme.colorScheme.onPrimary;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 0.8)),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              index: 0,
              label: 'Calibration',
              isSelected: selectedIndex == 0,
              iconBuilder: (isSelected) => SvgPicture.asset(
                'assets/icons/caliberation.svg',
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  isSelected ? selectedIconColor : unselectedColor,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () => onItemSelected(0),
            ),
            _NavItem(
              index: 1,
              label: 'Catch Test',
              isSelected: selectedIndex == 1,
              iconBuilder: (isSelected) => SvgPicture.asset(
                'assets/icons/scale.svg',
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  isSelected ? selectedIconColor : unselectedColor,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () => onItemSelected(1),
            ),
            _NavItem(
              index: 2,
              label: 'Quality Check',
              isSelected: selectedIndex == 2,
              iconBuilder: (isSelected) => SvgPicture.asset(
                'assets/icons/qualitycheck.svg',
                width: 22,
                height: 22,
                colorFilter: ColorFilter.mode(
                  isSelected ? selectedIconColor : unselectedColor,
                  BlendMode.srcIn,
                ),
              ),
              onTap: () => onItemSelected(2),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final String label;
  final bool isSelected;
  final Widget Function(bool isSelected) iconBuilder;
  final VoidCallback onTap;

  const _NavItem({
    required this.index,
    required this.label,
    required this.isSelected,
    required this.iconBuilder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final unselectedColor = theme.unselectedWidgetColor;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon or Pill container
          isSelected
              ? Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: iconBuilder(true),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: iconBuilder(false),
                ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? theme.colorScheme.onSurface : unselectedColor,
            ),
          ),
        ],
      ),
    );
  }
}
