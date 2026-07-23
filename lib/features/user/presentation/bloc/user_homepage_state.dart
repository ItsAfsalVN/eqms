import '../../domain/entities/inspection_section.dart';

class UserHomepageState {
  final int selectedTabIndex;
  final int selectedBottomNavIndex;
  final Set<String> collapsedSectionIds;
  final List<InspectionSection> sections;
  final bool isLoading;
  final String? errorMessage;

  const UserHomepageState({
    this.selectedTabIndex = 0,
    this.selectedBottomNavIndex = 2,
    this.collapsedSectionIds = const <String>{},
    this.sections = const <InspectionSection>[],
    this.isLoading = false,
    this.errorMessage,
  });

  UserHomepageState copyWith({
    int? selectedTabIndex,
    int? selectedBottomNavIndex,
    Set<String>? collapsedSectionIds,
    List<InspectionSection>? sections,
    bool? isLoading,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) {
    return UserHomepageState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      selectedBottomNavIndex:
          selectedBottomNavIndex ?? this.selectedBottomNavIndex,
      collapsedSectionIds: collapsedSectionIds ?? this.collapsedSectionIds,
      sections: sections ?? this.sections,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearErrorMessage
          ? null
          : (errorMessage ?? this.errorMessage),
    );
  }
}
