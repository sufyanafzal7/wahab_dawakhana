import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/custom_field.dart';
import '../../../models/medicine_card.dart';
import '../../../models/patient.dart';
import '../../../services/database_service.dart';
import '../../../utils/app_theme.dart';

class MedicineCardFormDialog extends StatefulWidget {
  final Patient patient;
  final MedicineCard? existingCard;

  const MedicineCardFormDialog({super.key, required this.patient, this.existingCard});

  @override
  State<MedicineCardFormDialog> createState() => _MedicineCardFormDialogState();
}

class _MedicineCardFormDialogState extends State<MedicineCardFormDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _medNameController;
  late TextEditingController _costController;
  late TextEditingController _qtyController;
  late TextEditingController _durationController;

  List<CustomField> _localCustomFields = [];

  @override
  void initState() {
    super.initState();
    final card = widget.existingCard;
    _medNameController = TextEditingController(text: card?.medicineName ?? '');
    _costController = TextEditingController(text: card?.cost ?? '');
    _qtyController = TextEditingController(text: card?.quantity ?? '');
    _durationController = TextEditingController(text: card?.duration ?? '');

    if (card != null) {
      _localCustomFields = card.customFields.map((f) => CustomField(key: f.key, value: f.value)).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<DatabaseService>();
    final isEditing = widget.existingCard != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Medicine Treatment Card' : 'Add Treatment Card'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(controller: _medNameController, decoration: const InputDecoration(labelText: 'Medicine Formula/Name')),
              const SizedBox(height: 10),
              TextFormField(controller: _costController, decoration: const InputDecoration(labelText: 'Cost')),
              const SizedBox(height: 10),
              TextFormField(controller: _qtyController, decoration: const InputDecoration(labelText: 'Quantity')),
              const SizedBox(height: 10),
              TextFormField(controller: _durationController, decoration: const InputDecoration(labelText: 'Medicine Duration')),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Other Notes', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.secondaryTeal)),
                  IconButton(
                    icon: const Icon(Icons.add_circle, color: AppTheme.primaryTeal),
                    onPressed: () => setState(() => _localCustomFields.add(CustomField(key: '', value: ''))),
                  )
                ],
              ),
              const Divider(),

              // Infinite Inline Dynamic Custom Field Inputs Engine Layout Wrapper
              ...List.generate(_localCustomFields.length, (idx) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: _localCustomFields[idx].key,
                          decoration: const InputDecoration(hintText: 'e.g., Avoid', contentPadding: EdgeInsets.all(8)),
                          onChanged: (val) => _localCustomFields[idx].key = val,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: TextFormField(
                          initialValue: _localCustomFields[idx].value,
                          decoration: const InputDecoration(hintText: 'e.g., cold drinks', contentPadding: EdgeInsets.all(8)),
                          onChanged: (val) => _localCustomFields[idx].value = val,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: AppTheme.alertCoral, size: 20),
                        onPressed: () => setState(() => _localCustomFields.removeAt(idx)),
                      )
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              // Clean dynamic list entries of empty properties
              _localCustomFields.removeWhere((element) => element.key.trim().isEmpty);

              if (isEditing) {
                final index = widget.patient.medicineCards.indexWhere((c) => c.id == widget.existingCard!.id);
                if (index != -1) {
                  widget.patient.medicineCards[index] = MedicineCard(
                    id: widget.existingCard!.id,
                    medicineName: _medNameController.text.trim(),
                    cost: _costController.text.trim(),
                    quantity: _qtyController.text.trim(),
                    duration: _durationController.text.trim(),
                    dateTime: widget.existingCard!.dateTime, // Preserved automatically
                    customFields: _localCustomFields,
                  );
                }
              } else {
                widget.patient.medicineCards.add(
                  MedicineCard(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    medicineName: _medNameController.text.trim(),
                    cost: _costController.text.trim(),
                    quantity: _qtyController.text.trim(),
                    duration: _durationController.text.trim(),
                    dateTime: DateTime.now(), // Auto-generated
                    customFields: _localCustomFields,
                  ),
                );
              }

              await db.updatePatient(widget.patient);
              if (context.mounted) Navigator.pop(context);
            }
          },
          child: const Text('Save Card'),
        )
      ],
    );
  }
}