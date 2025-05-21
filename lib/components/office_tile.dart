import 'package:flutter/material.dart';
import 'package:pasacao_hotline/models/office.dart';

class OfficeTile extends StatelessWidget {
  final Office office;
  // final VoidCallback onTap;

  // const OfficeTile({super.key, required this.onTap});
  const OfficeTile({super.key, required this.office});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to office detail
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/city_logo.png', // Replace with your actual asset
              height: 100,
              fit: BoxFit.cover,
            ),
            // Icon(office['icon'],
            //     size: 32, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              office.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
