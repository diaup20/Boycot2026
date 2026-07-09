import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../Core/constants/color_constants.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../domain/entities/app_info.dart';

class AppActionButtonsSection extends StatelessWidget {
  const AppActionButtonsSection({
    super.key,
    required this.info,
  });

  final AppInfo? info;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () => launchUrl(Uri.parse('tel:${174}')),
            icon: Icon(Icons.phone, color: cs.onSurface),
            label: Text(
              'اتصل برقم الشكاوي',
              style: Styles.textStyle16(context).copyWith(color: cs.onSurface),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: cs.surface.withOpacity(0.4),
              minimumSize: const Size.fromHeight(50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Share.share(
              info!.info,
            ),
            icon: const Icon(Icons.share),
            label: const Text('مشاركة التطبيق'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              side: BorderSide(color: kPrimaryColor.withOpacity(0.4)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
