import 'package:flutter/material.dart';
import 'package:pasacao_hotline/models/office.dart';

class OfficeTile extends StatelessWidget {
  final Office office;
  final VoidCallback onTap;

  // const OfficeTile({super.key, required this.onTap});
  const OfficeTile({super.key, required this.office, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            office.imageAsset == 'default.png'
                ? const Icon(
                    Icons.business_center_rounded,
                    size: 100,
                  )
                : Image.asset(
                    'assets/images/logos/${office.imageAsset}',
                    height: 100,
                    fit: BoxFit.cover,
                  ),
            // Icon(office['icon'],
            //     size: 32, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              office.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
