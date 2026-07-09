import 'package:flutter/material.dart';

import '../../../../../Core/utils/styles.dart';
import '../../../domain/entities/app_info.dart';

class AppInfoCardSection extends StatelessWidget {
  const AppInfoCardSection({
    super.key,
    required this.info,
  });

  final AppInfo? info;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: ShapeDecoration(
          color: cs.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: cs.primary.withOpacity(0.4)),
          ),
          shadows: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 4, offset: Offset(0, 2)),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '${info?.info}',
            style: Styles.textStyle16(context),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
