import 'package:flutter/material.dart';

import '../../../../../Core/helpers/navigation_helpers.dart';
import '../../../data/models/product_model.dart';
import 'custom_product_card.dart';

class AgentProductsListView extends StatelessWidget {
  final List products;
  final List<ProductModel> allProducts;

  const AgentProductsListView(
      {super.key, required this.products, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        itemBuilder: (_, i) {
          final product = products[i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: CustomProductCard(
              product: product,
              onTap: () => navigateToProductDetail(
                context,
                product: product,
                allProducts: allProducts,
              ),
            ),
          );
        });
  }
}
