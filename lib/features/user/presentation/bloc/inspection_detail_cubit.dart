import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/inspection_detail_model.dart';
import 'inspection_detail_state.dart';

class InspectionDetailCubit extends Cubit<InspectionDetailState> {
  InspectionDetailCubit() : super(const InspectionDetailState());

  void loadMockData() {
    emit(state.copyWith(isLoading: true));

    // Generate mock attributes
    List<InspectionAttribute> generateAttributes(int count, String prefix) {
      return List.generate(
        count,
        (index) => InspectionAttribute(
          id: '${prefix}_attr_$index',
          name: 'Wrinkled Sleeve',
          status: AttributeStatus.pending,
        ),
      );
    }

    final mockData = InspectionDetail(
      id: '1',
      title: 'Clorox LightStep 2-JUG Line Inspection',
      timeRange: '11:30 AM - 12:00PM',
      categories: [
        InspectionCategory(
          id: 'c1',
          name: 'CASE',
          subcategories: [
            InspectionSubcategory(
              id: 'sc1',
              name: 'Sleeve',
              attributes: generateAttributes(9, 'sc1'),
            ),
            InspectionSubcategory(
              id: 'sc2',
              name: 'Cap',
              attributes: generateAttributes(9, 'sc2'),
            ),
            InspectionSubcategory(
              id: 'sc3',
              name: 'Jug',
              attributes: generateAttributes(9, 'sc3'),
            ),
            InspectionSubcategory(
              id: 'sc4',
              name: 'Date Code',
              attributes: generateAttributes(9, 'sc4'),
            ),
          ],
        ),
        InspectionCategory(
          id: 'c2',
          name: 'JUG 1',
          subcategories: [
            InspectionSubcategory(
              id: 'sc5',
              name: 'Sleeve',
              attributes: generateAttributes(7, 'sc5'),
            ),
            InspectionSubcategory(
              id: 'sc6',
              name: 'Cap',
              attributes: generateAttributes(7, 'sc6'),
            ),
          ],
        ),
        InspectionCategory(
          id: 'c3',
          name: 'JUG 2',
          subcategories: [
            InspectionSubcategory(
              id: 'sc7',
              name: 'Sleeve',
              attributes: generateAttributes(7, 'sc7'),
            ),
          ],
        ),
        InspectionCategory(
          id: 'c4',
          name: 'JUG 3',
          attributes: generateAttributes(5, 'c4'), // Category with no subcategories
        ),
      ],
    );

    emit(state.copyWith(
      isLoading: false,
      inspection: mockData,
      selectedCategoryIndex: 0,
      selectedSubcategoryIndex: 0,
    ));
  }

  void selectCategory(int index) {
    emit(state.copyWith(
      selectedCategoryIndex: index,
      selectedSubcategoryIndex: 0, // Reset subcategory when category changes
    ));
  }

  void selectSubcategory(int index) {
    emit(state.copyWith(selectedSubcategoryIndex: index));
  }

  void updateAttributeStatus(String attributeId, AttributeStatus newStatus) {
    if (state.inspection == null) return;

    final updatedCategories = state.inspection!.categories.map((category) {
      if (category.subcategories != null) {
        final updatedSubcategories = category.subcategories!.map((sub) {
          final updatedAttributes = sub.attributes.map((attr) {
            if (attr.id == attributeId) {
              return attr.copyWith(status: newStatus);
            }
            return attr;
          }).toList();
          return sub.copyWith(attributes: updatedAttributes);
        }).toList();
        return category.copyWith(subcategories: updatedSubcategories);
      } else if (category.attributes != null) {
        final updatedAttributes = category.attributes!.map((attr) {
          if (attr.id == attributeId) {
            return attr.copyWith(status: newStatus);
          }
          return attr;
        }).toList();
        return category.copyWith(attributes: updatedAttributes);
      }
      return category;
    }).toList();

    emit(state.copyWith(
      inspection: state.inspection!.copyWith(categories: updatedCategories),
    ));
  }

  void fillAllTarget() {
    if (state.inspection == null) return;

    bool allTarget = true;
    for (var cat in state.inspection!.categories) {
      if (cat.subcategories != null) {
        for (var sub in cat.subcategories!) {
          if (sub.attributes.any((attr) => attr.status != AttributeStatus.target)) {
            allTarget = false;
          }
        }
      } else if (cat.attributes != null) {
        if (cat.attributes!.any((attr) => attr.status != AttributeStatus.target)) {
          allTarget = false;
        }
      }
    }

    final targetStatus = allTarget ? AttributeStatus.pending : AttributeStatus.target;

    final updatedCategories = state.inspection!.categories.map((category) {
      if (category.subcategories != null) {
        final updatedSubcategories = category.subcategories!.map((sub) {
          final updatedAttributes = sub.attributes.map((attr) {
            return attr.copyWith(status: targetStatus);
          }).toList();
          return sub.copyWith(attributes: updatedAttributes);
        }).toList();
        return category.copyWith(subcategories: updatedSubcategories);
      } else if (category.attributes != null) {
        final updatedAttributes = category.attributes!.map((attr) {
          return attr.copyWith(status: targetStatus);
        }).toList();
        return category.copyWith(attributes: updatedAttributes);
      }
      return category;
    }).toList();

    emit(state.copyWith(
      inspection: state.inspection!.copyWith(categories: updatedCategories),
    ));
  }

  void setAllTargetForCurrentView() {
    if (state.inspection == null) return;

    final category = state.inspection!.categories[state.selectedCategoryIndex];
    final updatedCategories = List<InspectionCategory>.from(state.inspection!.categories);

    bool allTarget = true;
    if (category.subcategories != null && category.subcategories!.isNotEmpty) {
      final subcategory = category.subcategories![state.selectedSubcategoryIndex];
      if (subcategory.attributes.any((attr) => attr.status != AttributeStatus.target)) {
        allTarget = false;
      }
    } else if (category.attributes != null) {
      if (category.attributes!.any((attr) => attr.status != AttributeStatus.target)) {
        allTarget = false;
      }
    }

    final targetStatus = allTarget ? AttributeStatus.pending : AttributeStatus.target;

    if (category.subcategories != null && category.subcategories!.isNotEmpty) {
      final subcategory = category.subcategories![state.selectedSubcategoryIndex];
      final updatedAttributes = subcategory.attributes.map((attr) {
        return attr.copyWith(status: targetStatus);
      }).toList();

      final updatedSubcategories = List<InspectionSubcategory>.from(category.subcategories!);
      updatedSubcategories[state.selectedSubcategoryIndex] = subcategory.copyWith(attributes: updatedAttributes);

      updatedCategories[state.selectedCategoryIndex] = category.copyWith(subcategories: updatedSubcategories);
    } else if (category.attributes != null) {
      final updatedAttributes = category.attributes!.map((attr) {
        return attr.copyWith(status: targetStatus);
      }).toList();

      updatedCategories[state.selectedCategoryIndex] = category.copyWith(attributes: updatedAttributes);
    }

    emit(state.copyWith(
      inspection: state.inspection!.copyWith(categories: updatedCategories),
    ));
  }
}
