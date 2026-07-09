import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../Core/utils/styles.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField(
      {super.key,
      this.onSubmitted,
      required this.controller,
      required this.onSearch,
      required this.onScan});
  final void Function(String)? onSubmitted;

  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback onScan;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: cs.primaryContainer.withAlpha(150),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              strokeAlign: BorderSide.strokeAlignCenter,
              color: cs.primary.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: TextField(
          style: Styles.textStyle16(context),
          cursorColor: cs.primary,
          controller: controller,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12),
              child: InkWell(
                onTap: onScan,
                child: SvgPicture.asset(
                  'assets/images/icon_barcode.svg',
                  color: cs.primary,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: cs.primary.withOpacity(0.5),
                )),
            suffixIcon: InkWell(
              mouseCursor: MaterialStateMouseCursor.clickable,
              onTap: onSearch,
              child: Icon(
                Icons.search,
                color: cs.primary,
              ),
            ),
            hintText: 'ادخل باركود أو اسم المنتج',
            hintStyle: Styles.textStyle15(context).copyWith(
              color: cs.onSurface.withOpacity(0.7),
            ),
            border: InputBorder.none,
          ),
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
