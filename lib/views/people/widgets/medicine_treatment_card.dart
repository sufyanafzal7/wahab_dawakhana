import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/medicine_card.dart';
import '../../../utils/app_theme.dart';

class MedicineTreatmentCard extends StatelessWidget {
  final MedicineCard treatmentCard;
  final String patientCity;
  final String patientAddress;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MedicineTreatmentCard({
    super.key,
    required this.treatmentCard,
    required this.patientCity,
    required this.patientAddress,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        treatmentCard.medicineName.isEmpty ? 'General Treatment' : treatmentCard.medicineName,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.secondaryTeal),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('MMMM dd, yyyy - hh:mm a').format(treatmentCard.dateTime),
                        style: const TextStyle(fontSize: 12, color: AppTheme.mutedText),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18, color: AppTheme.primaryTeal),
                      onPressed: onEdit,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.delete, size: 18, color: AppTheme.alertCoral),
                      onPressed: onDelete,
                      constraints: const BoxConstraints(),
                      style: const ButtonStyle(tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                    ),
                  ],
                )
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: AppTheme.softCardBorder),
            ),
            _buildDataRow('City:', patientCity),
            _buildDataRow('Address:', patientAddress),
            _buildDataRow('Cost:', treatmentCard.cost.isEmpty ? '' : '${treatmentCard.cost} PKR'),
            _buildDataRow('Quantity:', treatmentCard.quantity),
            _buildDataRow('Duration:', treatmentCard.duration),
            if (treatmentCard.customFields.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Divider(color: AppTheme.softCardBorder, thickness: 0.5),
              ),
              ...treatmentCard.customFields.map((field) => _buildDataRow('${field.key}:', field.value)),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(label, style: const TextStyle(color: AppTheme.mutedText, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: AppTheme.textSlate, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}