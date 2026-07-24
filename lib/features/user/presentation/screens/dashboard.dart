import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/inspection_local_datasource.dart';
import '../../data/repositories/inspection_repository_impl.dart';
import '../../domain/usecases/get_inspections.dart';
import '../bloc/user_homepage_cubit.dart';
import '../bloc/user_homepage_state.dart';
import 'package:eqms/core/widgets/app_bottom_navigation.dart';
import 'package:eqms/core/widgets/app_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'tabs/calibration_page.dart';
import 'tabs/catch_test_page.dart';
import 'tabs/quality_check_page.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  late final UserHomepageCubit _cubit;

  @override
  void initState() {
    super.initState();
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

    return BlocProvider.value(
      value: _cubit,
      child: BlocBuilder<UserHomepageCubit, UserHomepageState>(
        builder: (context, state) {
          Widget body;
          switch (state.selectedBottomNavIndex) {
            case 0:
              body = const CalibrationPage();
              break;
            case 1:
              body = const CatchTestPage();
              break;
            case 2:
            default:
              body = const QualityCheckPage();
          }

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: (state.selectedBottomNavIndex == 2 && state.selectedTabIndex == 1)
                ? FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: const Color(0xFF013CA6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/pen.svg',
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            body: SafeArea(
              child: Column(
                children: [
                  const AppHeader(userName: 'Afsal VN', userRole: 'QA Analyst'),
                  Expanded(child: body),
                ],
              ),
            ),
            bottomNavigationBar: AppBottomNavigation(
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
          );
        },
      ),
    );
  }
}
