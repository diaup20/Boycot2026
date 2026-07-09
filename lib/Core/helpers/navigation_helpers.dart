import 'package:flutter/material.dart';

import '../../../Features/home/data/models/product_model.dart';

void navigateToProductDetail(
  BuildContext context, {
  required ProductModel product,
  required List<ProductModel> allProducts,
}) {
  Navigator.pushNamed(
    context,
    '/productDetail',
    arguments: {
      'product': product,
      'allProducts': allProducts,
    },
  );
}