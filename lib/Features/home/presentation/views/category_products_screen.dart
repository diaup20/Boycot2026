import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/helpers/navigation_helpers.dart';
import '../../../../Core/utils/styles.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';
import '../view_model/category_cubit/category_cubit.dart';
import '../view_model/home_cubit/home_cubit.dart';
import 'widgets/custom_product_card.dart';

List<int> getAllCategoryIds(
    CategoryModel category, List<CategoryModel> allCategories) {
  final ids = <int>[category.id];
  final subCategories =
      allCategories.where((c) => c.parentId == category.id).toList();
  for (final sub in subCategories) {
    ids.addAll(getAllCategoryIds(sub, allCategories));
  }
  return ids;
}

class CategoryProductsScreen extends StatelessWidget {
  final CategoryModel category;
  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final allProducts = context.read<HomeCubit>().cachedAllProducts ?? [];
    final allCategories = context.read<CategoryCubit>().cachedCategories ?? [];

    final categoryIds = getAllCategoryIds(category, allCategories);

    final filtered = allProducts.where(
      (p) {
        return p.category.any((c) => ((categoryIds.contains(c.id)) ||
            (c is int && categoryIds.contains(c))));
      },
    ).toList();

    return Scaffold(
      appBar: AppBar(title: Text(category.name), centerTitle: true),
      body: filtered.isEmpty
          ? Center(
              child: Text(
                'لا توجد منتجات في هذه الفئة',
                style: Styles.textStyle18(context),
              ),
            )
          : CategoryProductsList(products: filtered, allProducts: allProducts),
    );
  }
}

class CategoryProductsList extends StatelessWidget {
  final List products;
  final List<ProductModel> allProducts;

  const CategoryProductsList(
      {super.key, required this.products, required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      itemBuilder: (_, i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: CustomProductCard(
          product: products[i],
          onTap: () => navigateToProductDetail(
            context,
            product: products[i],
            allProducts: allProducts,
          ),
        ),
      ),
    );
  }
}
