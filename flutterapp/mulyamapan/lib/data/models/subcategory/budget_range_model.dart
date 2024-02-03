class SubcategoryModel {
  String id;
  String subcategoryName;
  List<BudgetRange> budgetRanges;
  bool isSelected;

  SubcategoryModel({
    required this.id,
    required this.subcategoryName,
    required this.budgetRanges,
    required this.isSelected,
  });

  factory SubcategoryModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> budgetRangesJson = json['budgetRanges'];
    List<BudgetRange> budgetRanges = budgetRangesJson
        .map((budgetRangeJson) => BudgetRange.fromJson(budgetRangeJson))
        .toList();

    return SubcategoryModel(
      id: json['id'],
      subcategoryName: json['subcategoryName'],
      budgetRanges: budgetRanges,
      isSelected: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subcategoryName': subcategoryName,
      'budgetRanges':
          budgetRanges.map((budgetRange) => budgetRange.toJson()).toList(),
      'isSelected': isSelected,
    };
  }
}

class BudgetRange {
  int? fromRange;
  int? toRange;

  BudgetRange({
    required this.fromRange,
    required this.toRange,
  });

  factory BudgetRange.fromJson(Map<String, dynamic> json) {
    return BudgetRange(
      fromRange: json['fromRange'],
      toRange: json['toRange'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fromRange': fromRange,
      'toRange': toRange,
    };
  }
}
