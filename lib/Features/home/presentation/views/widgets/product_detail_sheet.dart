import 'package:consumer_prices_app/Core/utils/styles.dart';
import 'package:consumer_prices_app/Features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'custom_product_alternatives.dart';
import 'custom_product_barcode.dart';
import 'custom_product_info_rows.dart';
import 'custom_sheet_handle.dart';

class ProductDetailSheet extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> allProducts;

  final DraggableScrollableController dssController;

  const ProductDetailSheet({
    super.key,
    required this.product,
    required this.dssController,
    required this.allProducts,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return DraggableScrollableSheet(
      controller: dssController,
      initialChildSize: .55,
      minChildSize: .55,
      maxChildSize: .9,
      builder: (ctx, scroll) => Container(
        decoration: ShapeDecoration(
          color: cs.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            side: BorderSide(color: cs.primary.withOpacity(0.3)),
          ),
          shadows: [
            BoxShadow(color: cs.shadow, blurRadius: 15, spreadRadius: 10),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: ListView(
          controller: scroll,
          children: [
            const CustomSheetHandle(),
            const SizedBox(height: 16),
            Text(
      product.name,
      textAlign: TextAlign.center,
      style: Styles.textStyle22(context),
    ),
            const SizedBox(height: 16),
            CustomProductInfoRows(
                product: product,
                dssController: dssController,
                allProducts: allProducts),
            const SizedBox(height: 16),
            if ((product.description ?? '').isNotEmpty)
              CustomProductBarcode(barcode: product.barcode),
            const SizedBox(height: 24),
            if (product.alternatives.isNotEmpty)
              CustomProductAlternatives(
                alternatives: product.alternatives,
                parentProduct: product,
                allProducts: allProducts, 
              ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
