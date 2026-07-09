import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/constants/color_constants.dart';
import '../view_model/home_cubit/home_cubit.dart';
import 'widgets/custom_super_fancy_card.dart';

class AllCompaniesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final homeState = context.watch<HomeCubit>().state;
    final products = (homeState is HomeLoaded)
        ? homeState.products
        : (context.read<HomeCubit>().cachedBoycottProducts ?? []);
    final companies = products
        .map((p) => p.brand?.companyName)
        .where((c) => c != null)
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('جميع الشركات المنتجة'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: companies.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (ctx, i) {
            final companyName = companies[i];
            return CustomSuperFancyCard(
              title: '$companyName',
              icon: Icons.business,
              gradientColors: [
                cs.primary.withOpacity(0.3),
                kPrimaryColor.withOpacity(0.3)
              ],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/companyProducts',
                  arguments: {
                    'companyName': companyName,
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
