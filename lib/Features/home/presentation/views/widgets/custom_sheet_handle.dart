import 'package:flutter/material.dart';

class CustomSheetHandle extends StatelessWidget {
  const CustomSheetHandle();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

