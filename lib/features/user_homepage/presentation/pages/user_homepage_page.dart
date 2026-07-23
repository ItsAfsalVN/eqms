import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/inspection_local_datasource.dart';
import '../../data/repositories/inspection_repository_impl.dart';
import '../../domain/usecases/get_inspections.dart';
import '../bloc/user_homepage_cubit.dart';
import '../bloc/user_homepage_state.dart';
import '../widgets/inspection_section_widget.dart';
import 'package:eqms/core/widgets/app_bottom_navigation.dart';
import 'package:eqms/core/widgets/app_header.dart';
import 'package:eqms/core/widgets/app_tab_bar.dart';

class UserHomepagePage extends StatefulWidget {
  const UserHomepagePage({super.key});

  @override
  State<UserHomepagePage> createState() => _UserHomepagePageState();
}

class _UserHomepagePageState extends State<UserHomepagePage> {
  late final UserHomepageCubit _cubit;

  @override
  void initState() {
    super.initState();
    // Dependency Injection (Clean Architecture)
    final localDataSource = InspectionLocalDataSourceImpl();
    final repository = InspectionRepositoryImpl(
      localDataSource: localDataSource,
    );
    final getInspectionsUseCase = GetInspectionsUseCase(repository);

    _cubit = UserHomepageCubit(getInspectionsUseCase: getInspectionsUseCase);
    _cubit.loadInspections();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocProvider.value(
          value: _cubit,
          child: BlocBuilder<UserHomepageCubit, UserHomepageState>(
            builder: (context, state) {
              return Column(
                children: [
                  // Top Header (Logo + Afsal VN QA Analyst)
                  const AppHeader(userName: 'Afsal VN', userRole: 'QA Analyst'),

                  // Main Page Content Area (switch by bottom nav)
                  if (state.selectedBottomNavIndex == 2) ...[
                    // Quality Check: show tab bar + content
                    AppTabBar(
                      selectedIndex: state.selectedTabIndex,
                      onTabSelected: _cubit.setTabIndex,
                    ),
                    Expanded(
                      child: state.selectedTabIndex == 0
                          ? _buildInspectionFormView(theme, state)
                          : _buildDashboardView(theme),
                    ),
                  ] else ...[
                    // Calibration / Catch Test: simple Coming Soon pages
                    Expanded(
                      child: Center(
                        child: Text(
                          state.selectedBottomNavIndex == 0
                              ? 'Calibration — Coming Soon'
                              : 'Catch Test — Coming Soon',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],

                  // Bottom Navigation Bar
                  AppBottomNavigation(
                    selectedIndex: state.selectedBottomNavIndex,
                    onItemSelected: _cubit.setBottomNavIndex,
                    items: const [
                      BottomNavItem(
                        'Calibration',
                        'assets/icons/caliberation.svg',
                      ),
                      BottomNavItem('Catch Test', 'assets/icons/scale.svg'),
                      BottomNavItem(
                        'Quality Check',
                        'assets/icons/qualitycheck.svg',
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInspectionFormView(ThemeData theme, UserHomepageState state) {
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
      onRefresh: _cubit.loadInspections,
      color: theme.colorScheme.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.sections.length,
        itemBuilder: (context, index) {
          final section = state.sections[index];
          final isCollapsed = _cubit.isSectionCollapsed(section.id);

          return InspectionSectionWidget(
            section: section,
            isCollapsed: isCollapsed,
            onToggleCollapse: () => _cubit.toggleSectionCollapse(section.id),
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
