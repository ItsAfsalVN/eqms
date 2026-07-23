import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final List<BottomNavItem> items;

  const AppBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unselectedColor = theme.unselectedWidgetColor;

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
      child: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: onItemSelected,
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: theme.colorScheme.onSurface,
          unselectedItemColor: unselectedColor,
          selectedLabelStyle: theme.textTheme.bodySmall,
          unselectedLabelStyle: theme.textTheme.bodySmall,
          items: List.generate(items.length, (i) {
            final d = items[i];
            return BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 8,
                ),
                child: SvgPicture.asset(
                  d.asset,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    unselectedColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: SvgPicture.asset(
                  d.asset,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              label: d.label,
            );
          }),
        ),
      ),
    );
  }
}

class BottomNavItem {
  final String label;
  final String asset;

  const BottomNavItem(this.label, this.asset);
}
