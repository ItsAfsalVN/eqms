import 'package:flutter/foundation.dart';
import '../../domain/entities/inspection_section.dart';
import '../../domain/usecases/get_inspections.dart';

class UserHomepageNotifier extends ChangeNotifier {
  final GetInspectionsUseCase getInspectionsUseCase;

  UserHomepageNotifier({required this.getInspectionsUseCase});

  int _selectedTabIndex = 0; // 0: Inspection Form, 1: Dashboard
  int _selectedBottomNavIndex = 2; // 2: Quality Check
  final Set<String> _collapsedSectionIds = {};

  List<InspectionSection> _sections = [];
  bool _isLoading = false;
  String? _errorMessage;

  int get selectedTabIndex => _selectedTabIndex;
  int get selectedBottomNavIndex => _selectedBottomNavIndex;
  List<InspectionSection> get sections => _sections;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  bool isSectionCollapsed(String sectionId) =>
      _collapsedSectionIds.contains(sectionId);

  void setTabIndex(int index) {
    if (_selectedTabIndex != index) {
      _selectedTabIndex = index;
      notifyListeners();
    }
  }

  void setBottomNavIndex(int index) {
    if (_selectedBottomNavIndex != index) {
      _selectedBottomNavIndex = index;
      notifyListeners();
    }
  }

  void toggleSectionCollapse(String sectionId) {
    if (_collapsedSectionIds.contains(sectionId)) {
      _collapsedSectionIds.remove(sectionId);
    } else {
      _collapsedSectionIds.add(sectionId);
    }
    notifyListeners();
  }

  Future<void> loadInspections() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _sections = await getInspectionsUseCase();
    } catch (e) {
      _errorMessage = 'Failed to load inspections: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
