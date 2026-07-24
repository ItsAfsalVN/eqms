enum AttributeStatus {
  pending,
  target,
  acceptable,
  unacceptable,
}

class InspectionAttribute {
  final String id;
  final String name;
  AttributeStatus status;

  InspectionAttribute({
    required this.id,
    required this.name,
    this.status = AttributeStatus.pending,
  });

  InspectionAttribute copyWith({
    String? id,
    String? name,
    AttributeStatus? status,
  }) {
    return InspectionAttribute(
      id: id ?? this.id,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }
}

class InspectionSubcategory {
  final String id;
  final String name;
  final List<InspectionAttribute> attributes;

  InspectionSubcategory({
    required this.id,
    required this.name,
    required this.attributes,
  });

  InspectionSubcategory copyWith({
    String? id,
    String? name,
    List<InspectionAttribute>? attributes,
  }) {
    return InspectionSubcategory(
      id: id ?? this.id,
      name: name ?? this.name,
      attributes: attributes ?? this.attributes,
    );
  }
}

class InspectionCategory {
  final String id;
  final String name;
  final List<InspectionSubcategory>? subcategories;
  final List<InspectionAttribute>? attributes;

  InspectionCategory({
    required this.id,
    required this.name,
    this.subcategories,
    this.attributes,
  });

  InspectionCategory copyWith({
    String? id,
    String? name,
    List<InspectionSubcategory>? subcategories,
    List<InspectionAttribute>? attributes,
  }) {
    return InspectionCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      subcategories: subcategories ?? this.subcategories,
      attributes: attributes ?? this.attributes,
    );
  }
}

class InspectionDetail {
  final String id;
  final String title;
  final String timeRange;
  final List<InspectionCategory> categories;

  InspectionDetail({
    required this.id,
    required this.title,
    required this.timeRange,
    required this.categories,
  });

  InspectionDetail copyWith({
    String? id,
    String? title,
    String? timeRange,
    List<InspectionCategory>? categories,
  }) {
    return InspectionDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      timeRange: timeRange ?? this.timeRange,
      categories: categories ?? this.categories,
    );
  }
}
