import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/home_cubit/home_cubit.dart';
import 'widgets/custom_super_fancy_card.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeState = context.watch<HomeCubit>().state;
    final products = (homeState is HomeLoaded)
        ? homeState.products
        : (context.read<HomeCubit>().cachedAllProducts ?? []);
    final brands =
        products.map((p) => p.brand).where((b) => b != null).toList();

    final uniqueBrands = {for (var b in brands) b?.name: b}.values.toList();

    return Scaffold(
      appBar: AppBar(title: Text('جميع العلامات التجارية'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: uniqueBrands.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (ctx, i) {
            final brand = uniqueBrands[i];
            final logo = brand!.image;
            return CustomSuperFancyCard(
              title: brand.name,
              image: (logo != null && logo.isNotEmpty) ? logo : null,
              icon: (logo == null || logo.isEmpty) ? Icons.loyalty : null,
              gradientColors: const [Color(0xffee9ca7), Color(0xffffdde1)],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/brandProducts',
                  arguments: {
                    'brand': brand,
                    'allProducts': products,
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
