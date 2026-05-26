import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/medicine_card.dart';
import '../../services/database_service.dart';
import '../../utils/app_theme.dart';
import 'widgets/medicine_card_form_dialog.dart';
import 'widgets/medicine_treatment_card.dart';
import 'widgets/patient_form_dialog.dart';

class PatientDetailPage extends StatelessWidget {
  final String patientId;

  const PatientDetailPage({super.key, required this.patientId});

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DatabaseService>();
    final patientIndex = db.patients.indexWhere((p) => p.id == patientId);

    if (patientIndex == -1) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Patient record missing or deleted.')),
      );
    }

    final currentPatient = db.patients[patientIndex];

    return Scaffold(
      backgroundColor: AppTheme.backgroundMist,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
        title: Text(currentPatient.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_square),
            onPressed: () => showDialog(
              context: context,
              builder: (_) => PatientFormDialog(existingPatient: currentPatient),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_sweep_sharp),
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Delete Patient file?'),
                  content: const Text('This will permanently delete this patient record and all associated treatment cards.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete', style: TextStyle(color: AppTheme.alertCoral)),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await db.deletePatient(currentPatient.id);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: currentPatient.medicineCards.isEmpty
                ? const Center(child: Text('No treatments or medicine cards logged yet.'))
                : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: currentPatient.medicineCards.length,
              itemBuilder: (context, idx) {
                final card = currentPatient.medicineCards[idx];
                return MedicineTreatmentCard(
                  treatmentCard: card,
                  patientCity: currentPatient.city,
                  patientAddress: currentPatient.address,
                  onEdit: () => showDialog(
                    context: context,
                    builder: (_) => MedicineCardFormDialog(
                      patient: currentPatient,
                      existingCard: card,
                    ),
                  ),
                  onDelete: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Card?'),
                        content: const Text('Are you sure you want to delete this medicine treatment card?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete', style: TextStyle(color: AppTheme.alertCoral)),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      currentPatient.medicineCards.removeAt(idx);
                      await db.updatePatient(currentPatient);
                    }
                  },
                );
              },
            ),
          ),
          // Sticky Bottom Action Bar Layout Structure configuration layout view blueprint
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryTeal,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => MedicineCardFormDialog(patient: currentPatient),
                ),
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Add Medicine Card', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          )
        ],
      ),
    );
  }
}