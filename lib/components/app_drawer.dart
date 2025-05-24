import 'package:flutter/material.dart';
import 'package:pasacao_hotline/components/feedback.dart';
import 'package:pasacao_hotline/pages/about_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:lottie/lottie.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'Version ${info.version}+${info.buildNumber}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[100],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // ICON ANIMATION
              Container(
                padding: const EdgeInsets.only(top: 80),
                alignment: Alignment.center,
                child: Lottie.asset('assets/animations/call.json', width: 200),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(
                  color: Colors.grey[800],
                ),
              ),

              // ABOUT
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('A B O U T'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutPage()),
                    );
                  },
                ),
              ),

              // FEEDBACK
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: const Icon(Icons.feedback),
                  title: const Text('F E E D B A C K'),
                  onTap: () {
                    Navigator.pop(context);
                    showFeedbackDialog(context);
                  },
                ),
              ),
            ],
          ),

          // VERSION + BUILD NUMBER
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Text(
                _version,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          )
        ],
      ),
    );
  }
}
