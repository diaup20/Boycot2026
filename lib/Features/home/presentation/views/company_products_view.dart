import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Function/limited_title.dart';
import '../../../../Core/helpers/navigation_helpers.dart';
import '../../data/models/product_model.dart';
import '../view_model/home_cubit/home_cubit.dart';
import 'widgets/custom_product_card.dart';

class CompanyProductsScreen extends StatelessWidget {
  final String companyName;
  final List<ProductModel> allProducts;

  const CompanyProductsScreen(
      {super.key, required this.companyName, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    final products = cubit.productsByCompany(companyName);
    final companyProducts =
        products.where((p) => p.brand?.companyName == companyName).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          limitedTitle('منتجات ${companyName}', 3),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: companyProducts.isEmpty
          ? Center(child: Text('لا توجد منتجات لهذه الشركة'))
          : ListView.builder(
              itemCount: companyProducts.length,
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              itemBuilder: (_, i) {
                final product = companyProducts[i];
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
              }),
   );
  }
}
