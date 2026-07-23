import 'inspection_item.dart';

class InspectionSection {
  final String id;
  final String title;
  final List<InspectionItem> items;

  const InspectionSection({
    required this.id,
    required this.title,
    required this.items,
  });
}
