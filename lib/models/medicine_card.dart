import 'custom_field.dart';

class MedicineCard {
  String id;
  String medicineName;
  String cost;
  String quantity;
  String duration;
  DateTime dateTime;
  List<CustomField> customFields;

  MedicineCard({
    required this.id,
    required this.medicineName,
    required this.cost,
    required this.quantity,
    required this.duration,
    required this.dateTime,
    required this.customFields,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'medicineName': medicineName,
    'cost': cost,
    'quantity': quantity,
    'duration': duration,
    'dateTime': dateTime.toIso8601String(),
    'customFields': customFields.map((e) => e.toJson()).toList(),
  };

  factory MedicineCard.fromJson(Map<String, dynamic> json) => MedicineCard(
    id: json['id'] ?? '',
    medicineName: json['medicineName'] ?? '',
    cost: json['cost'] ?? '',
    quantity: json['quantity'] ?? '',
    duration: json['duration'] ?? '',
    dateTime: DateTime.tryParse(json['dateTime'] ?? '') ?? DateTime.now(),
    customFields: (json['customFields'] as List?)
        ?.map((e) => CustomField.fromJson(e))
        .toList() ?? [],
  );
}