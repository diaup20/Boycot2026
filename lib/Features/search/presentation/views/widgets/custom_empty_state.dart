import 'package:flutter/material.dart';

import '../../../../../Core/utils/styles.dart';

class EmptyState extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyState({
    super.key,
    this.message = 'لم يتم العثور على منتج',
    this.icon = Icons.search_off,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 80, color: cs.primary.withOpacity(0.4)),
          const SizedBox(height: 16),
          Text(message,
              style: Styles.textStyle18(context)
                  .copyWith(color: cs.onSurface.withOpacity(0.6))),
        ],
      ),
    );
  }
}
