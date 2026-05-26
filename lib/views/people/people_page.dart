import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/patient.dart';
import '../../services/database_service.dart';
import '../../utils/app_theme.dart';
import 'patient_detail_page.dart';
import 'widgets/patient_form_dialog.dart';
import 'widgets/patient_tile_card.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends State<PeoplePage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();

  bool _isFilterOpen = false;
  String _searchQuery = "";

  // Custom Filter Properties
  String _filterDate = "";
  String _filterYear = "";
  String _filterMonth = "";

  @override
  Widget build(BuildContext context) {
    final db = context.watch<DatabaseService>();

    // --- Optimized Live Compound Evaluation Logic Filter Module ---
    final filteredPatients = db.patients.where((patient) {
      final matchesSearch = patient.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          patient.city.toLowerCase().contains(_searchQuery.toLowerCase());

      bool matchesDateCondition = true;
      if (_filterDate.isNotEmpty) {
        final formattedPatientDate = DateFormat('dd/MM/yyyy').format(patient.createdDate);
        matchesDateCondition = (formattedPatientDate == _filterDate);
      } else {
        bool matchesYear = true;
        bool matchesMonth = true;
        if (_filterYear.isNotEmpty) {
          matchesYear = (patient.createdDate.year.toString() == _filterYear);
        }
        if (_filterMonth.isNotEmpty) {
          matchesMonth = (patient.createdDate.month.toString().padLeft(2, '0') == _filterMonth);
        }
        matchesDateCondition = matchesYear && matchesMonth;
      }
      return matchesSearch && matchesDateCondition;
    }).toList();

    return Scaffold(
      backgroundColor: AppTheme.backgroundMist,
      body: Column(
        children: [
          // Header Accent Block Module Layout Style
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16, left: 16, right: 16, bottom: 20),
            decoration: const BoxDecoration(
              color: AppTheme.primaryTeal,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Wahab Dawakhana',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: RepublicStyles.searchDecoration,
                        child: TextField(
                          controller: _searchController,
                          onChanged: (val) => setState(() => _searchQuery = val),
                          decoration: const InputDecoration(
                            hintText: 'Search by name or city...',
                            prefixIcon: Icon(Icons.search, color: AppTheme.mutedText),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.25),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        minimumSize: const Size(0, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => setState(() => _isFilterOpen = !_isFilterOpen),
                      icon: const Icon(Icons.filter_alt_outlined, size: 18),
                      label: const Text('Filter'),
                    ),
                  ],
                ),
                // Expanded Contextual Overlay Configuration (Matches Screen layout wd2.png)
                if (_isFilterOpen) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Filter Options', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.white, size: 18),
                              onPressed: () => setState(() => _isFilterOpen = false),
                            )
                          ],
                        ),
                        const Text('Specific Date', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _dateController,
                          style: const TextStyle(color: AppTheme.textSlate),
                          decoration: RepublicStyles.filterInputStyle('DD/MM/YYYY (e.g., 14/02/2020)'),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(child: Text('OR', style: TextStyle(color: Colors.white60, fontSize: 11))),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Year', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  TextField(
                                    controller: _yearController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: AppTheme.textSlate),
                                    decoration: RepublicStyles.filterInputStyle('YYYY'),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Month', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  TextField(
                                    controller: _monthController,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(color: AppTheme.textSlate),
                                    decoration: RepublicStyles.filterInputStyle('MM'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryTeal,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              setState(() {
                                _filterDate = _dateController.text.trim();
                                _filterYear = _yearController.text.trim();
                                _filterMonth = _monthController.text.trim();
                                _isFilterOpen = false;
                              });
                            },
                            child: const Text('Apply Filters', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  )
                ]
              ],
            ),
          ),
          // Patient List Dynamic Framework Render View
          Expanded(
            child: filteredPatients.isEmpty
                ? const Center(child: Text('No active patients found matching filter parameters.'))
                : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: filteredPatients.length,
              itemBuilder: (context, index) {
                final item = filteredPatients[index];
                return PatientTileCard(
                  patient: item,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PatientDetailPage(patientId: item.id)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryTeal,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        onPressed: () => showDialog(context: context, builder: (_) => const PatientFormDialog()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class RepublicStyles {
  static BoxDecoration searchDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  static InputDecoration filterInputStyle(String hint) => InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
  );
}