import 'package:flutter/material.dart';
import 'package:pasacao_hotline/components/feedback.dart';
import 'package:pasacao_hotline/components/office_tile.dart';
import 'package:pasacao_hotline/models/office.dart';
import 'package:pasacao_hotline/pages/about_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pasacao_hotline/pages/office_details_page.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Office> offices = [];
  String _version = '';

  @override
  void initState() {
    super.initState();
    loadOfficesFromHive();
    fetchOfficesFromSupabase();
    _loadVersion();
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

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'Version ${info.version}+${info.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Offices',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                // logo
                DrawerHeader(
                  child: Image.asset(
                    'assets/images/logos/mayors_office.png',
                    width: 500,
                    // color: Colors.black,
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Divider(
                //     color: Colors.grey[800],
                //   ),
                // ),

                // other pages
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.feedback_outlined,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'F E E D B A C K',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pop(context); // close drawer
                      // You’ll hook up the Supabase feedback logic here later
                      // showDialog(
                      //   context: context,
                      //   builder: (_) => const FeedbackDialog(),
                      // );
                      showFeedbackDialog(context);
                    },
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.info_outline,
                      color: Colors.black,
                    ),
                    title: const Text(
                      'A B O U T',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                title: Text(
                  _version,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
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
                    // const Text(
                    //   'Offices',
                    //   style: TextStyle(
                    //     fontSize: 22,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
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
