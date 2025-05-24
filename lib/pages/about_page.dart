import 'package:flutter/material.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  // String _version = '';

  @override
  void initState() {
    super.initState();
    // _loadVersion();
  }

  // Future<void> _loadVersion() async {
  //   final info = await PackageInfo.fromPlatform();
  //   setState(() {
  //     _version = 'Version ${info.version}+${info.buildNumber}';
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: const Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pasacao Hotline',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'This app provides quick access to emergency and public service hotlines in Pasacao. It is designed to help residents quickly reach important offices and services in times of need.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Developed by Jayco Bea for Pasaqueños.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 12),
            const Text(
              'Contact: jaycobea.dev@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            // Text(
            //   _version,
            //   style: const TextStyle(color: Colors.grey),
            // ),
          ],
        ),
      ),
    );
  }
}
