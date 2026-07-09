import 'package:cached_network_image/cached_network_image.dart';
import 'package:consumer_prices_app/Core/constants/color_constants.dart';
import 'package:consumer_prices_app/Core/utils/styles.dart';
import 'package:consumer_prices_app/Features/home/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../view_model/home_cubit/home_cubit.dart';
import '../category_products_screen.dart';

class CustomCategoryCard extends StatelessWidget {
  final CategoryModel category;
  const CustomCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        final prods =
            context.read<HomeCubit>().getProductsByCategory(category.id);

        if (prods.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'لا توجد منتجات في هذه الفئة',
                style:
                    Styles.textStyle15(context).copyWith(color: kPrimaryColor),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryProductsScreen(category: category),
            ),
          );
        }
      },
      child: AspectRatio(
        aspectRatio: 0.75,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          margin: const EdgeInsets.all(0),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
              side: BorderSide(
                  color: kPrimaryColor.withOpacity(0.18), width: 1.1),
            ),
            gradient: LinearGradient(
              colors: [
                kPrimaryColor.withOpacity(0.10),
                cs.primaryContainer,
                cs.secondaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shadows: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.09),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.secondaryContainer,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.18),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: category.image != null && category.image!.isNotEmpty
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: category.image!,
                            width: 76,
                            height: 76,
                            fit: BoxFit.contain,
                            placeholder: (context, url) {
                              final isDark = Theme.of(context).brightness ==
                                  Brightness.dark;
                              return Shimmer.fromColors(
                                baseColor: isDark
                                    ? Colors.blue[200]!
                                    : Colors.blue[200]!,
                                highlightColor: isDark
                                    ? Colors.blue[200]!
                                    : Colors.blue[100]!,
                                child: Container(
                                  color: isDark
                                      ? Colors.blue[300]!
                                      : Colors.white54,
                                  width: 60,
                                  height: 60,
                                ),
                              );
                            },
                            errorWidget: (_, __, ___) => Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: cs.onSurface.withOpacity(0.6),
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundColor: cs.primaryContainer,
                          child: Icon(
                            Icons.category,
                            size: 28,
                            color: cs.onSurface.withOpacity(0.4),
                          ),
                        ),
                ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    category.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.textStyle14(context).copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: LinearGradient(
                      colors: [
                        cs.primary.withOpacity(0.7),
                        cs.primary.withOpacity(0.0)
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
