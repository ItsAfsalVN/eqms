import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../domain/entities/inspection_detail_model.dart';
import '../bloc/inspection_detail_cubit.dart';
import '../bloc/inspection_detail_state.dart';
import 'package:eqms/core/widgets/app_bottom_navigation.dart';

class InspectionDetailPage extends StatefulWidget {
  const InspectionDetailPage({super.key});

  @override
  State<InspectionDetailPage> createState() => _InspectionDetailPageState();
}

class _InspectionDetailPageState extends State<InspectionDetailPage> {
  late final InspectionDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = InspectionDetailCubit()..loadMockData();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        bottomNavigationBar: AppBottomNavigation(
          selectedIndex: 2, // Highlight Quality Check for context
          onItemSelected: (_) {
            Navigator.pop(context);
          },
          items: const [
            BottomNavItem('Calibration', 'assets/icons/caliberation.svg'),
            BottomNavItem('Catch Test', 'assets/icons/scale.svg'),
            BottomNavItem('Quality Check', 'assets/icons/qualitycheck.svg'),
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<InspectionDetailCubit, InspectionDetailState>(
            builder: (context, state) {
              if (state.isLoading || state.inspection == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final inspection = state.inspection!;
              final currentCategory = inspection.categories[state.selectedCategoryIndex];
              
              bool hasSubcategories = currentCategory.subcategories != null && currentCategory.subcategories!.isNotEmpty;
              InspectionSubcategory? currentSubcategory;
              List<InspectionAttribute> attributesToDisplay = [];
              String setAllTitle = '';

              if (hasSubcategories) {
                currentSubcategory = currentCategory.subcategories![state.selectedSubcategoryIndex];
                attributesToDisplay = currentSubcategory.attributes;
                setAllTitle = '${currentCategory.name} - ${currentSubcategory.name} INSPECTION'.toUpperCase();
              } else {
                attributesToDisplay = currentCategory.attributes ?? [];
                setAllTitle = '${currentCategory.name} INSPECTION'.toUpperCase();
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildTopHeader(context, theme, inspection),
                  _buildFillAllRow(context, theme),
                  _buildCategoryTabs(context, theme, inspection, state),
                  if (hasSubcategories) _buildSubcategoryTabs(context, theme, currentCategory, state),
                  
                  const Divider(height: 1, thickness: 1),
                  
                  _buildSetAllHeader(context, theme, setAllTitle),
                  
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
                      itemCount: attributesToDisplay.length + 1, // +1 for submit button
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        if (index == attributesToDisplay.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF013CA6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontFamily: 'Urbanist',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        final attr = attributesToDisplay[index];
                        return _buildAttributeCard(context, theme, attr);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context, ThemeData theme, InspectionDetail inspection) {
    final isDark = theme.brightness == Brightness.dark;
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 4.0),
              child: Icon(Icons.arrow_back, color: theme.colorScheme.primary, size: 24),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  inspection.title,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  inspection.timeRange,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFillAllRow(BuildContext context, ThemeData theme) {
    return Container(
      color: theme.brightness == Brightness.dark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8,
            children: [
              _buildStatusCircle('T', const Color(0xFF00B521)),
              _buildStatusCircle('M', const Color(0xFFFFA500)),
              _buildStatusCircle('U', const Color(0xFFFF4D4D)),
            ],
          ),
          ElevatedButton.icon(
            onPressed: () {
              _cubit.fillAllTarget();
            },
            icon: const Icon(Icons.check, color: Colors.white, size: 16),
            label: const Text(
              'FILL ALL TARGET',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF008000), // Dark green
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusCircle(String text, Color color) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(BuildContext context, ThemeData theme, InspectionDetail inspection, InspectionDetailState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 8,
          children: List.generate(inspection.categories.length, (index) {
            final category = inspection.categories[index];
            final isSelected = state.selectedCategoryIndex == index;
            return GestureDetector(
              onTap: () => _cubit.selectCategory(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${category.name} ',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : theme.colorScheme.primary,
                        ),
                      ),
                      TextSpan(
                        text: '(0/7)', // Static for mockup
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: isSelected ? Colors.white.withOpacity(0.8) : theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSubcategoryTabs(BuildContext context, ThemeData theme, InspectionCategory category, InspectionDetailState state) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 8,
          children: List.generate(category.subcategories!.length, (index) {
            final sub = category.subcategories![index];
            final isSelected = state.selectedSubcategoryIndex == index;
            return GestureDetector(
              onTap: () => _cubit.selectSubcategory(index),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(20), // Pill shape
                  border: Border.all(
                    color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant,
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${sub.name} ',
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? Colors.white : (theme.brightness == Brightness.dark ? Colors.white : Colors.black),
                        ),
                      ),
                      TextSpan(
                        text: '(0/9)', // Static for mockup
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: isSelected ? Colors.white.withOpacity(0.8) : theme.colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildSetAllHeader(BuildContext context, ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.secondary,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _cubit.setAllTargetForCurrentView();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary, // Blue
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'SET ALL TARGET',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeCard(BuildContext context, ThemeData theme, InspectionAttribute attr) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            attr.name,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _buildToggleButton(theme, 'Target', attr.status == AttributeStatus.target, const Color(0xFF00B521), () {
                _cubit.updateAttributeStatus(attr.id, AttributeStatus.target);
              })),
              const SizedBox(width: 8),
              Expanded(child: _buildToggleButton(theme, 'Acceptable', attr.status == AttributeStatus.acceptable, const Color(0xFF8BA6F4), () {
                _cubit.updateAttributeStatus(attr.id, AttributeStatus.acceptable);
              })),
              const SizedBox(width: 8),
              Expanded(child: _buildToggleButton(theme, 'Unacceptable', attr.status == AttributeStatus.unacceptable, const Color(0xFFFF8585), () {
                _cubit.updateAttributeStatus(attr.id, AttributeStatus.unacceptable);
              })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(ThemeData theme, String text, bool isSelected, Color activeColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? activeColor : activeColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? activeColor : activeColor.withOpacity(0.5),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : activeColor,
          ),
        ),
      ),
    );
  }
}
