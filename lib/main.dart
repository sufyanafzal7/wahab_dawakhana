import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/database_service.dart';
import 'utils/app_theme.dart';
import 'views/main_navigation_hub.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive Engine
  await DatabaseService.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => DatabaseService(),
      child: const WahabDawakhanaApp(),
    ),
  );
}

class WahabDawakhanaApp extends StatelessWidget {
  const WahabDawakhanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wahab Dawakhana',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MainNavigationHub(),
    );
  }
}