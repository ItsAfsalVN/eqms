import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_homepage_cubit.dart';
import '../../bloc/user_homepage_state.dart';
import '../../widgets/inspection_section_widget.dart';
import '../../widgets/user_dashboard_widget.dart';
import 'package:eqms/core/widgets/app_tab_bar.dart';
import '../inspection_detail_page.dart';

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InspectionDetailPage(),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildDashboardView(ThemeData theme) {
    return const UserDashboardWidget();
  }
}
