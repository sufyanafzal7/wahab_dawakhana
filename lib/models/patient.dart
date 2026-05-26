import 'medicine_card.dart';

class Patient {
  String id;
  String name;
  String city;
  String address;
  DateTime createdDate;
  List<MedicineCard> medicineCards;

  Patient({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.createdDate,
    required this.medicineCards,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'city': city,
    'address': address,
    'createdDate': createdDate.toIso8601String(),
    'medicineCards': medicineCards.map((e) => e.toJson()).toList(),
  };

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json['id'] ?? '',
    name: json['name'] ?? '',
    city: json['city'] ?? '',
    address: json['address'] ?? '',
    createdDate: DateTime.tryParse(json['createdDate'] ?? '') ?? DateTime.now(),
    medicineCards: (json['medicineCards'] as List?)
        ?.map((e) => MedicineCard.fromJson(e))
        .toList() ?? [],
  );
}