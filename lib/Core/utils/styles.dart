import 'package:flutter/material.dart';

abstract class Styles {
  static TextStyle textStyle11(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 11,
      fontWeight: FontWeight.w500,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

  static TextStyle textStyle16(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.38,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

  static TextStyle textStyle16z(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.primary.withOpacity(0.8),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

  static TextStyle textStyle15(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 15,
      fontWeight: FontWeight.w400,
      height: 1.50,
      letterSpacing: 0.50,
      fontFamily: 'Cairo',
    );
  }

  static TextStyle textStyle15z(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.primary.withOpacity(0.8),
      fontSize: 15,
      fontWeight: FontWeight.w700,
      height: 1.47,
      letterSpacing: -0.43,
      fontFamily: 'Cairo',
    );
  }

  static TextStyle textStyle21(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 21,
      fontWeight: FontWeight.w700,
      height: 1.47,
      letterSpacing: -0.43,
      fontFamily: 'Cairo',
    );
  }

  static TextStyle textStyle19(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 19,
      fontWeight: FontWeight.w700,
      height: 1.47,
      letterSpacing: -0.43,
      fontFamily: 'Cairo',
    );
  }

  static TextStyle textStyle18(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: 'Cairo',
      letterSpacing: 0.43,
    );
  }

  static TextStyle textStyle22(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 22,
      fontWeight: FontWeight.w700,
      height: 1.47,
      letterSpacing: -0.43,
      fontFamily: 'Cairo',
    );
  }

  static TextStyle textStyle12(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 12,
      color: cs.onSurface,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

  static TextStyle textStyle13(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 13,
      fontWeight: FontWeight.w400,
      height: 1.33,
      letterSpacing: 0.40,
      fontFamily: 'Cairo',
    );
  }

  static TextStyle textStyle10(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 10,
      color: cs.onSurface,
      fontWeight: FontWeight.w400,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

 
  static TextStyle textStyle14(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      fontSize: 14,
      color: cs.onSurface,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

  static TextStyle textStyle20(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

  static TextStyle textStyle17(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onBackground.withOpacity(0.8),
      fontSize: 17,
      fontWeight: FontWeight.w400,
      height: 1.29,
      letterSpacing: -0.43,
      fontFamily: 'Cairo',
    );
  }

  static TextStyle textStyle30(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TextStyle(
      color: cs.onSurface,
      fontSize: 30,
      fontWeight: FontWeight.w700,
      height: 0.69,
      fontFamily: 'Cairo',
      letterSpacing: 0.5,
    );
  }

  static final InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
