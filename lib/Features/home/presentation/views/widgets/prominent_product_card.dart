import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Core/constants/color_constants.dart';
import '../../../../../Core/utils/styles.dart';

class ProminentProductCard extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final String? price;
  final Widget? badge;
  final VoidCallback? onTap;
  final double imageSize;
  final double height;
  final double width;
  final double borderRadius;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? priceStyle;

  const ProminentProductCard({
    Key? key,
    required this.title,
    this.imageUrl,
    this.price,
    this.badge,
    this.onTap,
    this.imageSize = 120,
    this.height = 190,
    this.borderRadius = 22,
    this.backgroundColor,
    this.titleStyle,
    this.priceStyle,
    this.width = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color:
              backgroundColor ?? Theme.of(context).colorScheme.primaryContainer,
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor.withOpacity(0.10),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(
            color: kPrimaryColor.withOpacity(0.18),
            width: 1.1,
          ),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius - 6),
                  child: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? CachedNetworkImage(
                          imageUrl: imageUrl!,
                          height: imageSize,
                          width: imageSize,
                          fit: BoxFit.contain,
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor:
                                isDark ? Colors.blue[200]! : Colors.blue[200]!,
                            highlightColor:
                                isDark ? Colors.blue[200]! : Colors.blue[100]!,
                            child: Container(
                              color:
                                  isDark ? Colors.blue[300]! : Colors.white54,
                            ),
                          ),
                          errorWidget: (_, __, ___) => Center(
                            child: Icon(
                              Icons.image_not_supported,
                              size: imageSize * 0.5,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.4),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[200],
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.13),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(imageSize * 0.18),
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            color: Colors.grey[500],
                            size: imageSize * 0.45,
                          ),
                        ),
                ),
              ),
            ),
            if (badge != null)
              Positioned(
                top: 0,
                left: 0,
                child: SizedBox(
                  height: 28,
                  child: badge,
                ),
              ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(borderRadius),
                    bottomRight: Radius.circular(borderRadius),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: titleStyle ?? Styles.textStyle15(context),
                    ),
                    if (price != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          price!,
                          style: priceStyle ??
                              Styles.textStyle13(context).copyWith(
                                color: kPrimaryColor,
                              ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
