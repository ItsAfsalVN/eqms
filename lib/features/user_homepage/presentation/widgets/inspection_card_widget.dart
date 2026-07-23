import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../domain/entities/inspection_item.dart';

class InspectionCardWidget extends StatelessWidget {
  final InspectionItem item;
  final VoidCallback? onTap;

  const InspectionCardWidget({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final surfaceShadowColor = theme.colorScheme.primary.withValues(
      alpha: 0.05,
    );
    final darkShadowColor = theme.colorScheme.onSurface.withValues(alpha: 0.18);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.outline, width: 1),
        boxShadow: [
          BoxShadow(
            color: isDark ? darkShadowColor : surfaceShadowColor,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          height: 1.25,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.subtitle.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  'assets/icons/dashboard.svg',
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(
                    theme.colorScheme.onSurface,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
