import 'package:flutter/material.dart';

import '../../constants/color_constants.dart';
import '../../utils/styles.dart';

Future<bool> showExitDialog(BuildContext context) async {
  final theme = Theme.of(context);
  final cs = theme.colorScheme;
  final shouldExit = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (ctx, anim1, anim2) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: cs.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
       
                Text(
                  'تنويه',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cairo'),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text('هل تريد الخروج من التطبيق؟',
                      textAlign: TextAlign.center,
                      style: Styles.textStyle16(context)),
                ),
                const SizedBox(height: 16),
                Divider(color: cs.onSurface.withOpacity(0.6), height: 1),
                SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Center(
                            child: Text(
                              'لا',
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 16,
                                  fontFamily: 'Cairo'),
                            ),
                          ),
                        ),
                      ),
                      Container(width: 1, color: Colors.grey.shade700),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: Center(
                            child: Text(
                              'نعم',
                              style: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 16,
                                  fontFamily: 'Cairo'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

  return shouldExit ?? false;
}
