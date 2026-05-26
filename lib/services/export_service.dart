import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  Future<bool> exportLocalFile({
    required String jsonData,
    required bool overrideExisting,
  }) async {
    try {
      final bytes = utf8.encode(jsonData);

      // 1. Web case (keep as is)
      if (kIsWeb) {
        final encoded = base64Encode(bytes);
        await Share.share(
          'data:application/json;base64,$encoded',
          subject: 'patientData.json',
        );
        return true;
      }

      // 2. Desktop + Mobile (FIXED APPROACH)
      String? outputPath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Patient Backup',
        fileName: overrideExisting ? 'patientData.json' : null,
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (outputPath == null) return false;

      if (!outputPath.endsWith('.json')) {
        outputPath = '$outputPath.json';
      }

      final file = File(outputPath);
      await file.writeAsString(jsonData);

      // Optional: open share sheet (works everywhere)
      await Share.shareXFiles(
        [XFile(file.path)],
        text: 'Wahab Dawakhana Backup File',
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String?> importLocalFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json', 'txt'],
      );

      if (result != null && result.files.single.path != null) {
        File file = File(result.files.single.path!);
        return await file.readAsString();
      } else if (result != null && result.files.single.bytes != null) {
        return utf8.decode(result.files.single.bytes!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}