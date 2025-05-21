import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasacao_hotline/models/office.dart';
import 'package:pasacao_hotline/pages/intro_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pasacao_hotline/secrets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (supabaseUrl.isEmpty || supabaseKey.isEmpty) {
    print('❌ Missing Supabase env variables');
    return;
  }

  // Initialize Supabase
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  // Initialize Hive and register Office adapter
  await Hive.initFlutter();
  Hive.registerAdapter(OfficeAdapter());
  await Hive.openBox<Office>('offices');

  runApp(const MyApp());
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
