import '../entities/inspection_section.dart';

abstract class InspectionRepository {
  Future<List<InspectionSection>> getInspectionSections();
}
