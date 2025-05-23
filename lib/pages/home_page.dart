import 'package:flutter/material.dart';
import 'package:pasacao_hotline/components/office_tile.dart';
import 'package:pasacao_hotline/models/office.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasacao_hotline/pages/office_details_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Office> offices = [];

  @override
  void initState() {
    super.initState();
    loadOfficesFromHive();
    fetchOfficesFromSupabase();
  }

  void loadOfficesFromHive() {
    final box = Hive.box<Office>('offices');
    setState(() {
      offices = box.values.toList();
    });
  }

  Future<void> fetchOfficesFromSupabase() async {
    try {
      final supabase = Supabase.instance.client;
      final List<dynamic> raw = await supabase
          .from('Offices')
          .select()
          .order('created_at', ascending: true);

      final freshOffices = raw
          .map((item) => Office.fromJson(item as Map<String, dynamic>))
          .toList();

      // Save to Hive
      final box = Hive.box<Office>('offices');
      await box.clear();
      await box.addAll(freshOffices);

      // Update UI
      setState(() {
        offices = freshOffices;
      });
    } catch (error) {
      // print('❌ Failed to fetch from Supabase: $error');
      // Optionally show a Snackbar or dialog:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Offline: showing cached hotlines')),
      );
    }
  }

  void onTap() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Offices',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 48),
                  itemCount: offices.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    final office = offices[index];
                    return OfficeTile(
                        office: office,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => OfficeDetailsPage(office: office),
                            ),
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
