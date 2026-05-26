import 'export_service.dart'; // Local serialization bridge
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import '../models/patient.dart';

class DatabaseService extends ChangeNotifier {
  static const String _boxName = 'wahab_dawakhana_box';
  static const String _patientsKey = 'patients_list';

  final Box _box = Hive.box(_boxName);
  List<Patient> _patients = [];

  List<Patient> get patients => _patients;

  DatabaseService() {
    _loadPatients();
  }

  static Future<void> initialize() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  void _loadPatients() {
    final rawData = _box.get(_patientsKey);
    if (rawData != null) {
      try {
        final List decoded = jsonDecode(rawData);
        _patients = decoded.map((item) => Patient.fromJson(item)).toList();
      } catch (e) {
        _patients = [];
      }
    }
    notifyListeners();
  }

  Future<void> _saveToDisk() async {
    final String encoded = jsonEncode(_patients.map((p) => p.toJson()).toList());
    await _box.put(_patientsKey, encoded);
    notifyListeners();
  }

  // --- CRUD Engine Operations ---
  Future<void> addPatient(Patient patient) async {
    _patients.add(patient);
    await _saveToDisk();
  }

  Future<void> updatePatient(Patient updatedPatient) async {
    final index = _patients.indexWhere((p) => p.id == updatedPatient.id);
    if (index != -1) {
      _patients[index] = updatedPatient;
      await _saveToDisk();
    }
  }

  Future<void> deletePatient(String id) async {
    _patients.removeWhere((p) => p.id == id);
    await _saveToDisk();
  }

  String exportRawJson() {
    return jsonEncode(_patients.map((p) => p.toJson()).toList());
  }

  Future<bool> importRawJson(String rawJson) async {
    try {
      final List decoded = jsonDecode(rawJson);
      final importedPatients = decoded.map((item) => Patient.fromJson(item)).toList();
      _patients = importedPatients;
      await _saveToDisk();
      return true;
    } catch (e) {
      return false;
    }
  }
}