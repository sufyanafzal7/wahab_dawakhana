import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ExportService {
  Future<bool> exportLocalFile({required String jsonData, required bool overrideExisting}) async {
    try {
      if (kIsWeb) {
        // Fallback sharing channel wrapper for web execution layouts
        final bytes = Uri.encodeComponent(jsonData);
        await Share.share('data:text/json;charset=utf-8,$bytes', subject: 'wahab_dawakhana_backup.json');
        return true;
      }

      final Directory? directory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      if (directory == null) return false;

      String targetFileName = "patientData.json";
      File targetFile = File("${directory.path}/$targetFileName");

      if (!overrideExisting && await targetFile.exists()) {
        int index = 1;
        while (await File("${directory.path}/patientData$index.json").exists()) {
          index++;
        }
        targetFile = File("${directory.path}/patientData$index.json");
      }

      await targetFile.writeAsString(jsonData);

      // Prompt share menu sheet natively on mobile instances
      if (Platform.isAndroid || Platform.isIOS) {
        await Share.shareXFiles([XFile(targetFile.path)], text: 'Wahab Dawakhana Data Backup File');
      }
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