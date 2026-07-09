import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/Function/limited_title.dart';
import '../../../../Core/helpers/navigation_helpers.dart';
import '../../../../Core/utils/styles.dart';
import '../../data/models/brand_model.dart';
import '../../data/models/product_model.dart';
import '../view_model/home_cubit/home_cubit.dart';
import 'widgets/custom_product_card.dart';


class BrandProductsScreen extends StatelessWidget {
  final BrandModel brand;
  final List<ProductModel> allProducts; 
  const BrandProductsScreen(
      {super.key, required this.brand, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final products = cubit.productsByBrand(brand.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(limitedTitle('منتجات ${brand.name}', 3),
            overflow: TextOverflow.ellipsis),
        centerTitle: true,
      ),
      body: products.isEmpty
          ? Center(
              child: Text(
              'لا توجد منتجات لهذه العلامة',
              style: Styles.textStyle18(context),
            ))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemCount: products.length,
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
              },
            ),
    );
  }
}
