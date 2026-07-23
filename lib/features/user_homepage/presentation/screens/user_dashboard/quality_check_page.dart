import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_homepage_cubit.dart';
import '../../bloc/user_homepage_state.dart';
import '../../widgets/inspection_section_widget.dart';
import 'package:eqms/core/widgets/app_tab_bar.dart';

class QualityCheckPage extends StatelessWidget {
  const QualityCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserHomepageCubit>();
    final theme = Theme.of(context);

    return BlocBuilder<UserHomepageCubit, UserHomepageState>(
      builder: (context, state) {
        return Column(
          children: [
            AppTabBar(
              selectedIndex: state.selectedTabIndex,
              onTabSelected: cubit.setTabIndex,
            ),
            Expanded(
              child: state.selectedTabIndex == 0
                  ? _buildInspectionFormView(context, theme, state, cubit)
                  : _buildDashboardView(theme),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInspectionFormView(
    BuildContext context,
    ThemeData theme,
    UserHomepageState state,
    UserHomepageCubit cubit,
  ) {
    if (state.isLoading) {
      return Center(
        child: CircularProgressIndicator(color: theme.colorScheme.primary),
      );
    }

    if (state.errorMessage != null) {
      return Center(
        child: Text(
          state.errorMessage!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: cubit.loadInspections,
      color: theme.colorScheme.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.sections.length,
        itemBuilder: (context, index) {
          final section = state.sections[index];
          final isCollapsed = cubit.isSectionCollapsed(section.id);

          return InspectionSectionWidget(
            section: section,
            isCollapsed: isCollapsed,
            onToggleCollapse: () => cubit.toggleSectionCollapse(section.id),
            onItemTap: (itemId) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Opening inspection: $itemId'),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDashboardView(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dashboard_outlined,
            size: 48,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 12),
          Text(
            'Dashboard View',
            style: theme.textTheme.titleLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
