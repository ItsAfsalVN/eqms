import 'package:flutter/material.dart';

import '../../data/datasources/inspection_local_datasource.dart';
import '../../data/repositories/inspection_repository_impl.dart';
import '../../domain/usecases/get_inspections.dart';
import '../controllers/user_homepage_notifier.dart';
import '../widgets/inspection_section_widget.dart';
import '../widgets/user_homepage_bottom_nav.dart';
import '../widgets/user_homepage_header.dart';
import '../widgets/user_homepage_tab_bar.dart';

class UserHomepagePage extends StatefulWidget {
  const UserHomepagePage({super.key});

  @override
  State<UserHomepagePage> createState() => _UserHomepagePageState();
}

class _UserHomepagePageState extends State<UserHomepagePage> {
  late final UserHomepageNotifier _notifier;

  @override
  void initState() {
    super.initState();
    // Dependency Injection (Clean Architecture)
    final localDataSource = InspectionLocalDataSourceImpl();
    final repository = InspectionRepositoryImpl(
      localDataSource: localDataSource,
    );
    final getInspectionsUseCase = GetInspectionsUseCase(repository);

    _notifier = UserHomepageNotifier(
      getInspectionsUseCase: getInspectionsUseCase,
    );
    _notifier.loadInspections();
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: ListenableBuilder(
          listenable: _notifier,
          builder: (context, _) {
            return Column(
              children: [
                // Top Header (Logo + Afsal VN QA Analyst)
                const UserHomepageHeader(
                  userName: 'Afsal VN',
                  userRole: 'QA Analyst',
                ),

                // Tab Bar (Inspection Form / Dashboard)
                UserHomepageTabBar(
                  selectedIndex: _notifier.selectedTabIndex,
                  onTabSelected: _notifier.setTabIndex,
                ),

                // Main Page Content Area
                Expanded(
                  child: _notifier.selectedTabIndex == 0
                      ? _buildInspectionFormView(theme)
                      : _buildDashboardView(theme),
                ),

                // Bottom Navigation Bar
                UserHomepageBottomNav(
                  selectedIndex: _notifier.selectedBottomNavIndex,
                  onItemSelected: _notifier.setBottomNavIndex,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildInspectionFormView(ThemeData theme) {
    if (_notifier.isLoading)
     {
      return Center(
        child: CircularProgressIndicator(color: theme.colorScheme.primary),
      );
    }

    if (_notifier.errorMessage != null) {
      return Center(
        child: Text(
          _notifier.errorMessage!,
          style: TextStyle(
            fontFamily: 'Urbanist',
            color: theme.colorScheme.error,
            fontSize: 14,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _notifier.loadInspections,
      color: theme.colorScheme.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notifier.sections.length,
        itemBuilder: (context, index) {
          final section = _notifier.sections[index];
          final isCollapsed = _notifier.isSectionCollapsed(section.id);

          return InspectionSectionWidget(
            section: section,
            isCollapsed: isCollapsed,
            onToggleCollapse: () => _notifier.toggleSectionCollapse(section.id),
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
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
