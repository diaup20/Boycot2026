import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../Core/constants/color_constants.dart';
import '../../../../../Core/utils/styles.dart';

class CustomProductBarcode extends StatelessWidget {
  final String? barcode;
  const CustomProductBarcode({required this.barcode});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('الباركود', style: Styles.textStyle18(context)),
        const SizedBox(height: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Theme.of(context).colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.10),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: kPrimaryColor.withOpacity(0.18),
                width: 1.1,
              ),
            ),
            child: BarcodeWidget(
              barcode: Barcode.code128(),
              style: TextStyle(color: kPrimaryColor),
              data: barcode ?? '',
              width: 200,
              height: 80,
            ),
          ),
        ),
      ],
    );
  }
}
