import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasacao_hotline/models/office.dart';
import 'package:pasacao_hotline/pages/intro_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pasacao_hotline/secrets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await runZonedGuarded(() async {
    try {
      if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
        print('❌ Missing Supabase env variables');
        runApp(const MissingConfigApp());
        return;
      }

      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseKey,
      );

      await Hive.initFlutter();
      Hive.registerAdapter(OfficeAdapter());
      await Hive.openBox<Office>('offices');

      runApp(const MyApp());
    } catch (e, stack) {
      print('❌ Exception in main: $e');
      print(stack);
      runApp(CrashApp(error: e.toString()));
    }
  }, (error, stack) {
    print('❌ Uncaught Zone Error: $error');
    runApp(CrashApp(error: error.toString()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}

class MissingConfigApp extends StatelessWidget {
  const MissingConfigApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Missing Supabase config")),
      ),
    );
  }
}

class CrashApp extends StatelessWidget {
  final String error;
  const CrashApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: Text("Crash during startup:\n$error")),
      ),
    );
  }
}