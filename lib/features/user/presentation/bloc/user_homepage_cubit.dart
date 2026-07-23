import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_inspections.dart';
import 'user_homepage_state.dart';

class UserHomepageCubit extends Cubit<UserHomepageState> {
  final GetInspectionsUseCase getInspectionsUseCase;

  UserHomepageCubit({required this.getInspectionsUseCase})
    : super(const UserHomepageState());

  void setTabIndex(int index) {
    if (state.selectedTabIndex != index) {
      emit(state.copyWith(selectedTabIndex: index));
    }
  }

  void setBottomNavIndex(int index) {
    if (state.selectedBottomNavIndex != index) {
      emit(state.copyWith(selectedBottomNavIndex: index));
    }
  }

  void toggleSectionCollapse(String sectionId) {
    final next = Set<String>.from(state.collapsedSectionIds);
    if (next.contains(sectionId)) {
      next.remove(sectionId);
    } else {
      next.add(sectionId);
    }
    emit(state.copyWith(collapsedSectionIds: next));
  }

  bool isSectionCollapsed(String sectionId) {
    return state.collapsedSectionIds.contains(sectionId);
  }

  Future<void> loadInspections() async {
    emit(state.copyWith(isLoading: true, clearErrorMessage: true));

    try {
      final inspections = await getInspectionsUseCase();
      emit(state.copyWith(sections: inspections, isLoading: false));
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load inspections: ${e.toString()}',
        ),
      );
    }
  }
}
