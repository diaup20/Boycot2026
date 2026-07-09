import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../utils/styles.dart';
import 'cubit_theme/theme_cubit.dart';

Future<void> showThemeModeDialog(BuildContext context) {
  final themeCubit = context.read<ThemeCubit>();
  final current = themeCubit.state;
  final cs = Theme.of(context).colorScheme;

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: const Color(0xff16202A),
      title: Text(
        'اختر وضع الثيم',
        style: Styles.textStyle20(context),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values.map((mode) {
          String label;
          switch (mode) {
            case ThemeMode.system:
              label = 'وضع النظام';
              break;
            case ThemeMode.light:
              label = 'الوضع النهاري';
              break;
            case ThemeMode.dark:
              label = 'الوضع الليلي';
              break;
          }
          return RadioListTile<ThemeMode>(
            title: Text(label, style: Styles.textStyle16z(context)),
            activeColor: cs.primary,
            value: mode,
            groupValue: current,
            onChanged: (value) {
              if (value == null) return;
              switch (value) {
                case ThemeMode.system:
                  themeCubit.setSystem();
                  break;
                case ThemeMode.light:
                  themeCubit.setLight();
                  break;
                case ThemeMode.dark:
                  themeCubit.setDark();
                  break;
              }
              Navigator.of(context).pop();
            },
          );
        }).toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('إلغاء', style: Styles.textStyle16z(context)),
        ),
      ],
    ),
  );
}
