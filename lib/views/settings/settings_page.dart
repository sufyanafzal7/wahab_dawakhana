import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/database_service.dart';
import '../../services/export_service.dart';
import '../../services/google_drive_service.dart';
import '../../utils/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _overrideExistingFile = true;
  final ExportService _exportService = ExportService();
  final GoogleDriveService _googleDriveService = GoogleDriveService();

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DatabaseService>();

    return Scaffold(
      backgroundColor: AppTheme.backgroundMist,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
        title: const Text('Wahab Dawakhana'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Export Settings Option Module
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.download, color: AppTheme.primaryTeal),
                      SizedBox(width: 8),
                      Text('Export Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Text('Save your patient entries locally.', style: TextStyle(color: AppTheme.mutedText, fontSize: 12)),
                  const SizedBox(height: 12),
                  RadioListTile<bool>(
                    value: true,
                    groupValue: _overrideExistingFile,
                    title: const Text('Override Existing File', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Replace old dataset cleanly with current database state.', style: TextStyle(fontSize: 11)),
                    activeColor: AppTheme.primaryTeal,
                    onChanged: (val) => setState(() => _overrideExistingFile = val!),
                  ),
                  RadioListTile<bool>(
                    value: false,
                    groupValue: _overrideExistingFile,
                    title: const Text('Create New File', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    subtitle: const Text('Generates auto-incrementing files (e.g., patientData1.json).', style: TextStyle(fontSize: 11)),
                    activeColor: AppTheme.primaryTeal,
                    onChanged: (val) => setState(() => _overrideExistingFile = val!),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryTeal,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final rawJson = db.exportRawJson();
                        final success = await _exportService.exportLocalFile(
                          jsonData: rawJson,
                          overrideExisting: _overrideExistingFile,
                        );
                        _showSnackBar(success ? 'Data exported successfully!' : 'Export failed.');
                      },
                      icon: const Icon(Icons.file_upload_outlined, size: 18),
                      label: const Text('Export to JSON', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Import Settings Option Module
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.upload_file, color: AppTheme.primaryTeal),
                      SizedBox(width: 8),
                      Text('Import Data', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Text('Restore clinical registers from backup files.', style: TextStyle(color: AppTheme.mutedText, fontSize: 12)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.backgroundMist,
                        foregroundColor: AppTheme.secondaryTeal,
                        side: const BorderSide(color: AppTheme.softCardBorder),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final rawContent = await _exportService.importLocalFile();
                        if (rawContent != null) {
                          final success = await db.importRawJson(rawContent);
                          _showSnackBar(success ? 'Database updated successfully!' : 'Invalid backup format.');
                        }
                      },
                      icon: const Icon(Icons.download, size: 18),
                      label: const Text('Import from JSON', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Cloud Integration Component Card Module
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.cloud_queue, color: AppTheme.primaryTeal),
                      SizedBox(width: 8),
                      Text('Cloud Backup', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const Text('Export to Google Drive storage.', style: TextStyle(color: AppTheme.mutedText, fontSize: 12)),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.backgroundMist,
                        foregroundColor: AppTheme.secondaryTeal,
                        side: const BorderSide(color: AppTheme.softCardBorder),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () async {
                        final rawData = db.exportRawJson();
                        final status = await _googleDriveService.uploadBackup(rawData);
                        _showSnackBar(status ? 'Cloud backup complete!' : 'Google Drive authentication or transmission failed.');
                      },
                      icon: const Icon(Icons.cloud_upload_outlined, size: 18),
                      label: const Text('Backup to Google Drive', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Diagnostic App Information Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.info_outline, color: AppTheme.primaryTeal),
                      SizedBox(width: 8),
                      Text('App Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _infoRow('App Name', 'Wahab Dawakhana'),
                  const Divider(color: AppTheme.softCardBorder),
                  _infoRow('Version', '1.0.0'),
                  const Divider(color: AppTheme.softCardBorder),
                  _infoRow('Total Patients Logged', db.patients.length.toString()),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infoRow(String label, String val) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppTheme.mutedText, fontSize: 13)),
          Text(val, style: const TextStyle(color: AppTheme.textSlate, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}