class CustomField {
  String key;
  String value;

  CustomField({required this.key, required this.value});

  Map<String, dynamic> toJson() => {'key': key, 'value': value};
  factory CustomField.fromJson(Map<String, dynamic> json) =>
      CustomField(key: json['key'] ?? '', value: json['value'] ?? '');
}