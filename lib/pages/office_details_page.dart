import 'package:flutter/material.dart';
import 'package:pasacao_hotline/models/office.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:pasacao_hotline/utils/network_utils.dart';

class OfficeDetailsPage extends StatelessWidget {
  final Office office;

  const OfficeDetailsPage({super.key, required this.office});

  void _launchCall(String number) async {
    final sanitizedNumber = number.replaceAll(RegExp(r'\s+'), '');
    final Uri url = Uri(scheme: 'tel', path: sanitizedNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _launchSms(String number) async {
    final sanitizedNumber = number.replaceAll(RegExp(r'\s+'), '');
    final Uri url = Uri(scheme: 'sms', path: sanitizedNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _copyToClipboard(BuildContext context, String number) {
    Clipboard.setData(ClipboardData(text: number));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied $number to clipboard')),
    );
  }

  Widget _buildPhoneRow(BuildContext context, String number,
      {bool sms = false}) {
    final iconPath = getNetworkIcon(number);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onLongPress: () => _copyToClipboard(context, number),
              child: Row(
                children: [
                  Text(
                    number,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  if (iconPath != null)
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: SizedBox(
                        height: 25,
                        width: 30,
                        child: Image.asset(
                          iconPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () => _launchCall(number),
          ),
          if (sms)
            IconButton(
              icon: const Icon(Icons.sms),
              onPressed: () => _launchSms(number),
            ),
        ],
      ),
    );
  }

  Widget _buildSection(String emoji, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text('$emoji ', style: const TextStyle(fontSize: 20)),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...children
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          office.name,
          style: const TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'assets/images/logos/${office.imageAsset}',
                height: 180,
              ),
            ),
            if (office.mobile != null && office.mobile!.isNotEmpty)
              _buildSection(
                '📱',
                'Mobile',
                office.mobile!
                    .map((num) => _buildPhoneRow(context, num, sms: true))
                    .toList(),
              ),
            if (office.phone != null && office.phone!.isNotEmpty)
              _buildSection(
                '☎️',
                'Landline',
                office.phone!
                    .map((num) => _buildPhoneRow(context, num))
                    .toList(),
              ),
            if (office.radio != null && office.radio!.isNotEmpty)
              _buildSection(
                '📻',
                'Radio',
                [
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      office.radio!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
