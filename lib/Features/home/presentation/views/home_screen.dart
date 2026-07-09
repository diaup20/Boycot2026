import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Core/helpers/navigation_helpers.dart';
import '../view_model/category_cubit/category_cubit.dart';
import '../view_model/home_cubit/home_cubit.dart';
import 'widgets/custom_toggle_button.dart';
import 'widgets/home_fancy_card_row.dart';
import 'widgets/my_badge_widget.dart';
import 'widgets/product_carousel.dart';
import 'widgets/prominent_product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showBoycott = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الرئيسية'), centerTitle: true),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (ctx, state) {
          if (state is HomeLoaded) {
            final allProducts = state.products;

            final allAlternatives = allProducts
                .expand((p) => p.alternatives)
                .where((alt) => alt.isBoycott == false)
                .toList();

            final uniqueAlternatives =
                {for (var alt in allAlternatives) alt.id: alt}.values.toList();
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      if (allProducts.isNotEmpty)
                        ProductCarousel(
                          allProducts: allProducts,
                         
                        ),
                      const SizedBox(height: 24),
                      BlocBuilder<CategoryCubit, CategoryState>(
                        builder: (ctx2, catState) {
                          final cats = (catState is CategoryLoaded)
                              ? catState.categories
                              : ctx2.read<CategoryCubit>().cachedCategories ??
                                  [];
                          return cats.isEmpty
                              ? const SizedBox.shrink()
                              : const HomeFancyCardRow();
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomToggleButton(
                            context: context,
                            label: 'المنتجات المقاطعة',
                            image: 'assets/images/image-boycott1.png',
                            icon: Icons.block,
                            active: showBoycott,
                            onTap: () => setState(() => showBoycott = true),
                            activeColors: [
                              const Color(0xfff857a6).withOpacity(0.6),
                              const Color(0xffff5858).withOpacity(0.7),
                            ],
                            inactiveColor: Colors.pinkAccent,
                          ),
                          const SizedBox(width: 8),
                          CustomToggleButton(
                            context: context,
                            label: 'بدائل المقاطعة',
                            image: 'assets/images/image-category.png',
                            icon: Icons.emoji_emotions,
                            active: !showBoycott,
                            onTap: () => setState(() => showBoycott = false),
                            activeColors: [
                              const Color(0xff43cea2).withOpacity(0.6),
                              const Color(0xff185a9d).withOpacity(0.7),
                            ],
                            inactiveColor: Colors.teal,
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                    ],
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (ctx, i) {
                        if (showBoycott) {
                          final products =
                              allProducts.where((p) => p.isBoycott).toList()[i];
                          return ProminentProductCard(
                            imageUrl: products.image,
                            title: products.name,
                            badge: buildBadge(product: products),
                            onTap: () => navigateToProductDetail(
                              context,
                              product: products,
                              allProducts: allProducts,
                            ),
                          );
                        } else {
                          final alt = uniqueAlternatives[i];
                          final parent = allProducts.firstWhere(
                            (p) => (p.alternatives).any((a) => a.id == alt.id),
                            orElse: () => allProducts.first,
                          );
                          final productsFull =
                              alt.toProductModelFromParent(parent);
                          return ProminentProductCard(
                            imageUrl: productsFull.image,
                            title: productsFull.name,
                            price: productsFull.price != null
                                ? '${productsFull.price} ر.ي'
                                : null,
                            badge: buildBadge(product: productsFull),
                            onTap: () => navigateToProductDetail(
                              context,
                              product: productsFull,
                              allProducts: allProducts,
                            ),
                          );
                        }
                      },
                      childCount: showBoycott
                          ? allProducts.where((p) => p.isBoycott).length
                          : uniqueAlternatives.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 70)),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
