import '../../domain/entities/inspection_item.dart';

class InspectionItemModel extends InspectionItem {
  const InspectionItemModel({
    required super.id,
    required super.title,
    required super.subtitle,
  });

  factory InspectionItemModel.fromJson(Map<String, dynamic> json) {
    return InspectionItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
    };
  }
}
