import 'package:flutter/material.dart';

class ProductIndicator extends StatelessWidget {
  final int count, current;
  const ProductIndicator(
      {super.key, required this.count, required this.current});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? Theme.of(context).primaryColor : Colors.grey[400],
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
