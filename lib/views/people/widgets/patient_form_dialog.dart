import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/patient.dart';
import '../../../services/database_service.dart';

class PatientFormDialog extends StatefulWidget {
  final Patient? existingPatient;
  const PatientFormDialog({super.key, this.existingPatient});

  @override
  State<PatientFormDialog> createState() => _PatientFormDialogState();
}

class _PatientFormDialogState extends State<PatientFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late TextEditingController _addressController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.existingPatient?.name ?? '');
    _cityController = TextEditingController(text: widget.existingPatient?.city ?? '');
    _addressController = TextEditingController(text: widget.existingPatient?.address ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final db = context.read<DatabaseService>();
    final isEditing = widget.existingPatient != null;

    return AlertDialog(
      title: Text(isEditing ? 'Modify Profile' : 'New Patient Record'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: 'Patient Name')),
              const SizedBox(height: 10),
              TextFormField(controller: _cityController, decoration: const InputDecoration(labelText: 'City')),
              const SizedBox(height: 10),
              TextFormField(controller: _addressController, decoration: const InputDecoration(labelText: 'Address')),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              if (isEditing) {
                final updated = Patient(
                  id: widget.existingPatient!.id,
                  name: _nameController.text.trim(),
                  city: _cityController.text.trim(),
                  address: _addressController.text.trim(),
                  createdDate: widget.existingPatient!.createdDate,
                  medicineCards: widget.existingPatient!.medicineCards,
                );
                await db.updatePatient(updated);
              } else {
                final fresh = Patient(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  name: _nameController.text.trim(),
                  city: _cityController.text.trim(),
                  address: _addressController.text.trim(),
                  createdDate: DateTime.now(),
                  medicineCards: [],
                );
                await db.addPatient(fresh);
              }
              if (context.mounted) Navigator.pop(context);
            }
          },
          child: const Text('Save File'),
        )
      ],
    );
  }
}