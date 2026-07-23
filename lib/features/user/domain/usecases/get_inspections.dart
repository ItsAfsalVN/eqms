import '../entities/inspection_section.dart';
import '../repositories/inspection_repository.dart';

class GetInspectionsUseCase {
  final InspectionRepository repository;

  GetInspectionsUseCase(this.repository);

  Future<List<InspectionSection>> call() async {
    return await repository.getInspectionSections();
  }
}
