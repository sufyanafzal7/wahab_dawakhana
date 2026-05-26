import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/patient.dart';
import '../../../utils/app_theme.dart';

class PatientTileCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientTileCard({super.key, required this.patient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    patient.name.isEmpty ? 'Unnamed Patient' : patient.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textSlate),
                  ),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: AppTheme.mutedText),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat('dd/MM/yyyy').format(patient.createdDate),
                        style: const TextStyle(fontSize: 12, color: AppTheme.mutedText),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.secondaryTeal),
                  const SizedBox(width: 4),
                  Text(
                    patient.city.isEmpty ? 'No City' : patient.city,
                    style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.secondaryTeal),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  patient.address.isEmpty ? 'No Address Listed' : patient.address,
                  style: const TextStyle(color: AppTheme.mutedText, fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}