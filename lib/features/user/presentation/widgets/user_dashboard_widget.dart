import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserDashboardWidget extends StatefulWidget {
  const UserDashboardWidget({super.key});

  @override
  State<UserDashboardWidget> createState() => _UserDashboardWidgetState();
}

class _UserDashboardWidgetState extends State<UserDashboardWidget> {
  String _selectedInspection = 'All Inspections';
  DateTime? _selectedDate;

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primaryColor = theme.colorScheme.primary;

    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          // Title
          Text(
            'Blue Mountain Quality Dashboard',
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : primaryColor,
            ),
          ),

          // Subtitle & Dropdown Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'INSPECTIONS',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.secondary,
                  letterSpacing: 0.5,
                ),
              ),
              PopupMenuButton<String>(
                offset: const Offset(0, 32),
                color: theme.scaffoldBackgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                  side: BorderSide(color: theme.colorScheme.outlineVariant),
                ),
                onSelected: (value) {
                  setState(() {
                    _selectedInspection = value;
                  });
                },
                itemBuilder: (context) => [
                  _buildPopupItem('All', isDark, primaryColor),
                  _buildPopupItem('QA Line Inspection', isDark, primaryColor),
                  _buildPopupItem('QA Lab Inspection', isDark, primaryColor),
                ],
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: theme.colorScheme.outlineVariant),
                  ),
                  child: Row(
                    spacing: 8,
                    children: [
                      Text(
                        _selectedInspection,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : primaryColor,
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/chevron-down.svg',
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // All Tests Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ALL TESTS',
                      style: TextStyle(
                        fontFamily: 'Urbanist',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.secondary,
                        letterSpacing: 0.5,
                      ),
                    ),
                    Row(
                      spacing: 8,
                      children: [
                        if (_selectedDate != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _formatDate(_selectedDate!),
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : primaryColor,
                              ),
                            ),
                          ),
                        GestureDetector(
                          onTap: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: _selectedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              builder: (context, child) {
                                return Theme(
                                  data: theme.copyWith(
                                    colorScheme: isDark
                                        ? const ColorScheme.dark(
                                            primary: Color(0xFF013CA6),
                                            onPrimary: Colors.white,
                                            surface: Color(0xFF1E1E1E),
                                            onSurface: Colors.white,
                                          )
                                        : const ColorScheme.light(
                                            primary: Color(0xFF013CA6),
                                            onPrimary: Colors.white,
                                            surface: Colors.white,
                                            onSurface: Colors.black87,
                                          ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/filter.svg',
                            height: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '88',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 48,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : primaryColor,
                    height: 1.0,
                  ),
                ),
                Text(
                  '0 WITH ISSUES',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.secondary,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Target Rates Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(
                  'TARGET RATES',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.secondary,
                    letterSpacing: 0.5,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    spacing: 12,
                    children: List.generate(4, (index) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor, // light background
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Column(
                          spacing: 4,
                          children: [
                            Text(
                              'Cases',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : primaryColor,
                              ),
                            ),
                            Text(
                              '100%',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : primaryColor,
                              ),
                            ),
                            Text(
                              '616/616',
                              style: TextStyle(
                                fontFamily: 'Urbanist',
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: theme.colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),

          // Inspections List
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: theme.colorScheme.outline),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                Text(
                  'INSPECTIONS',
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.secondary,
                    letterSpacing: 0.5,
                  ),
                ),
                Column(
                  spacing: 8,
                  children: List.generate(6, (index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: theme.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '10:30 AM - 11:00 AM',
                            style: TextStyle(
                              fontFamily: 'Urbanist',
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: isDark ? Colors.white : primaryColor,
                            ),
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              _buildTickCircle(),
                              _buildTickCircle(),
                              _buildTickCircle(),
                            ],
                          ),
                          Row(
                            spacing: 4,
                            children: [
                              Text(
                                '3 CASES',
                                style: TextStyle(
                                  fontFamily: 'Urbanist',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: theme.colorScheme.secondary,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/icons/chevron-down.svg',
                                height: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTickCircle() {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        color: Color(0xFF00B521), // Success green
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Text(
        'T',
        style: TextStyle(
          fontFamily: 'Urbanist',
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupItem(String text, bool isDark, Color primaryColor) {
    return PopupMenuItem<String>(
      value: text,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : primaryColor,
              ),
            ),
          ),
          Divider(height: 1, thickness: 1, color: isDark ? Colors.grey[800] : Colors.blue.withOpacity(0.2)),
        ],
      ),
    );
  }
}
