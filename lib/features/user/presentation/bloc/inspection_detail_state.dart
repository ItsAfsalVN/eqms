import '../../domain/entities/inspection_detail_model.dart';

class InspectionDetailState {
  final bool isLoading;
  final InspectionDetail? inspection;
  final int selectedCategoryIndex;
  final int selectedSubcategoryIndex;

  const InspectionDetailState({
    this.isLoading = false,
    this.inspection,
    this.selectedCategoryIndex = 0,
    this.selectedSubcategoryIndex = 0,
  });

  InspectionDetailState copyWith({
    bool? isLoading,
    InspectionDetail? inspection,
    int? selectedCategoryIndex,
    int? selectedSubcategoryIndex,
  }) {
    return InspectionDetailState(
      isLoading: isLoading ?? this.isLoading,
      inspection: inspection ?? this.inspection,
      selectedCategoryIndex:
          selectedCategoryIndex ?? this.selectedCategoryIndex,
      selectedSubcategoryIndex:
          selectedSubcategoryIndex ?? this.selectedSubcategoryIndex,
    );
  }
}
