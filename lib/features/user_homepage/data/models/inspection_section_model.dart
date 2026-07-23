import '../../domain/entities/inspection_section.dart';
import 'inspection_item_model.dart';

class InspectionSectionModel extends InspectionSection {
  const InspectionSectionModel({
    required super.id,
    required super.title,
    required List<InspectionItemModel> super.items,
  });

  factory InspectionSectionModel.fromJson(Map<String, dynamic> json) {
    return InspectionSectionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => InspectionItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'items': items
          .map((item) => (item as InspectionItemModel).toJson())
          .toList(),
    };
  }
}
