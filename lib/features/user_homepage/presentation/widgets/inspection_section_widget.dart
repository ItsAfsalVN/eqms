import 'package:flutter/material.dart';
import '../../domain/entities/inspection_section.dart';
import 'inspection_card_widget.dart';

class InspectionSectionWidget extends StatelessWidget {
  final InspectionSection section;
  final bool isCollapsed;
  final VoidCallback onToggleCollapse;
  final ValueChanged<String>? onItemTap;

  const InspectionSectionWidget({
    super.key,
    required this.section,
    required this.isCollapsed,
    required this.onToggleCollapse,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header with Title, Down Arrow & Line Divider
        GestureDetector(
          onTap: onToggleCollapse,
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    section.title,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : primaryColor,
                    ),
                  ),
                  AnimatedRotation(
                    turns: isCollapsed ? -0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      size: 18,
                      color: isDark ? Colors.white : primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Container(
                height: 1.2,
                color: theme.colorScheme.outlineVariant,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Collapsible Items List
        AnimatedCrossFade(
          firstChild: Column(
            children: section.items.map((item) {
              return InspectionCardWidget(
                item: item,
                onTap: () => onItemTap?.call(item.id),
              );
            }).toList(),
          ),
          secondChild: const SizedBox.shrink(),
          crossFadeState: isCollapsed
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
