import 'package:flutter/material.dart';

import '../../../../../Core/helpers/navigation_helpers.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../data/models/product_model.dart';
import 'my_badge_widget.dart';
import 'prominent_product_card.dart';

class CustomProductAlternatives extends StatelessWidget {
  final List alternatives;
  final ProductModel parentProduct;
  final List<ProductModel> allProducts;

  const CustomProductAlternatives({
    required this.alternatives,
    required this.parentProduct,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {

    final allProducts =
        (ModalRoute.of(context)?.settings.arguments as Map?)?['allProducts'] ??
            [];
    final filteredAlternatives =
        alternatives.where((alt) => alt.isBoycott != true).toList();

    if (filteredAlternatives.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('البدائل', style: Styles.textStyle18(context)),
        const SizedBox(height: 12),
        SizedBox(
          height: 210,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: filteredAlternatives.length,
            itemBuilder: (ctx, i) {
              final alt = filteredAlternatives[i];
              // ابحث عن المنتج الأصلي الذي يطابق id البديل
              final altProduct =
                  allProducts.where((p) => p.id == alt.id).isNotEmpty
                      ? allProducts.firstWhere((p) => p.id == alt.id)
                      : null;

              return ProminentProductCard(
                imageUrl: altProduct?.image,
                title: altProduct?.name,
                width: 160,
                imageSize: 100,
                price: altProduct?.price != null
                    ? '${altProduct?.price} ر.ي'
                    : null,
                badge: buildBadge(product: altProduct),
                onTap: () => navigateToProductDetail(
                  context,
                  product:
                      altProduct ?? alt.toProductModelFromParent(parentProduct),
                  allProducts: allProducts,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
