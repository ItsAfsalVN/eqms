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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        // Section Header with Title, Down Arrow & Line Divider
        GestureDetector(
          onTap: onToggleCollapse,
          behavior: HitTestBehavior.opaque,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                spacing: 6,
                children: [
                  Text(
                    section.title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  AnimatedRotation(
                    turns: isCollapsed ? -0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              Container(height: 1.2, color: theme.colorScheme.outlineVariant),
            ],
          ),
        ),

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
