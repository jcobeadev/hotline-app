import 'package:flutter/material.dart';
import 'package:pasacao_hotline/components/app_drawer.dart';
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
      final List<dynamic> raw =
          await supabase.from('Offices').select().order('seq', ascending: true);

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

  Future<void> _refreshOffices() async {
    await fetchOfficesFromSupabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Pasacao Hotline'),
        backgroundColor: Colors.grey[100],
        foregroundColor: Colors.black,
        elevation: 0.5,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          color: Colors.grey[900],
          onRefresh: _refreshOffices,
          child: Scrollbar(
            thumbVisibility: false,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
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
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: offices.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                                builder: (_) =>
                                    OfficeDetailsPage(office: office),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
