import '../../domain/entities/inspection_section.dart';
import '../../domain/repositories/inspection_repository.dart';
import '../datasources/inspection_local_datasource.dart';

class InspectionRepositoryImpl implements InspectionRepository {
  final InspectionLocalDataSource localDataSource;

  InspectionRepositoryImpl({required this.localDataSource});

  @override
  Future<List<InspectionSection>> getInspectionSections() async {
    return await localDataSource.getInspectionSections();
  }
}
