import 'package:flutter/material.dart';
import 'package:find_intern/app/app.bottomsheets.dart';
import 'package:find_intern/app/app.dialogs.dart';
import 'package:find_intern/app/app.locator.dart';
import 'package:find_intern/app/app.router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: 'https://xtyuelkuhnmmdohqaamf.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh0eXVlbGt1aG5tbWRvaHFhYW1mIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTkxNTEzMzYsImV4cCI6MjA3NDcyNzMzNn0.wlFOzMKsdHkovLYPkXUbxNoV5njWs5kUwUUyJPoB_Yo');
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Staj Bul',
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
      builder: EasyLoading.init(),
    );
  }
}
