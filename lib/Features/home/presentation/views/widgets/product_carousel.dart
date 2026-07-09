import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:consumer_prices_app/Features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Core/helpers/navigation_helpers.dart';
import 'my_badge_widget.dart';

class ProductCarousel extends StatefulWidget {
  final List<ProductModel> allProducts;

  const ProductCarousel({super.key, required this.allProducts});

  @override
  _ProductCarouselState createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  final CarouselSliderController _controller = CarouselSliderController();
  Timer? _timer;
  int current = 0;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (widget.allProducts.isEmpty) {
      return const SizedBox.shrink();
    }
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: CarouselSlider.builder(
            controller: _controller,
            itemCount: widget.allProducts.length,
            itemBuilder: (context, index, realIdx) {
              final product = widget.allProducts[index];
              return GestureDetector(
                onTap: () => navigateToProductDetail(
                  context,
                  product: product,
                  allProducts: widget.allProducts,
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        decoration: ShapeDecoration(
                          color: cs.primaryContainer,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            side:
                                BorderSide(color: cs.primary.withOpacity(0.3)),
                          ),
                          shadows: [
                            BoxShadow(
                                color: cs.shadow,
                                blurRadius: 15,
                                spreadRadius: 10),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            product.image != null && product.image!.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: product.image!,
                                    placeholder: (context, url) {
                                      final isDark =
                                          Theme.of(context).brightness ==
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
                                        ),
                                      );
                                    },
                                    errorWidget: (_, __, ___) => Icon(
                                      Icons.image_not_supported,
                                      size: 100,
                                      color: cs.onSurface.withOpacity(0.6),
                                    ),
                                  )
                                : const Icon(Icons.image),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 80,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.7),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: SizedBox(
                          height: 28, child: buildBadge(product: product)),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 200,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              enlargeCenterPage: true,
              viewportFraction: 0.7,
              onPageChanged: (index, reason) => setState(() => current = index),
            ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
