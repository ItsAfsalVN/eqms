import '../models/inspection_item_model.dart';
import '../models/inspection_section_model.dart';

abstract class InspectionLocalDataSource {
  Future<List<InspectionSectionModel>> getInspectionSections();
}

class InspectionLocalDataSourceImpl implements InspectionLocalDataSource {
  @override
  Future<List<InspectionSectionModel>> getInspectionSections() async {
    // Simulate short network / storage delay
    await Future.delayed(const Duration(milliseconds: 150));

    return const [
      InspectionSectionModel(
        id: 'line_inspection',
        title: 'Line Inspection',
        items: [
          InspectionItemModel(
            id: 'line_1',
            title: 'Clorox LightStep 2-JUG Line Inspection',
            subtitle: 'CLOROX LIGHTSTEP 2-JUG LINE INSPECTION',
          ),
          InspectionItemModel(
            id: 'line_2',
            title: 'Clorox LightStep 2-JUG Line Inspection',
            subtitle: 'CLOROX LIGHTSTEP 2-JUG LINE INSPECTION',
          ),
        ],
      ),
      InspectionSectionModel(
        id: 'lab_inspection',
        title: 'Lab Inspection',
        items: [
          InspectionItemModel(
            id: 'lab_1',
            title: 'Clorox LightStep 2-JUG Line Inspection',
            subtitle: 'CLOROX LIGHTSTEP 2-JUG LINE INSPECTION',
          ),
          InspectionItemModel(
            id: 'lab_2',
            title: 'Clorox LightStep 2-JUG Line Inspection',
            subtitle: 'CLOROX LIGHTSTEP 2-JUG LINE INSPECTION',
          ),
        ],
      ),
    ];
  }
}
