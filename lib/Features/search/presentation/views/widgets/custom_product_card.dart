import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Core/utils/styles.dart';
import '../../../../home/data/models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Material(
        clipBehavior: Clip.antiAlias,
        color: cs.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: cs.primary.withOpacity(0.4)),
        ),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Banner(
            message: product.isBoycott ? 'مقاطع' : 'غير مقاطع',
            location: BannerLocation.topEnd,
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  placeholder: (context, url) {
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;
                    return Shimmer.fromColors(
                      baseColor: isDark ? Color(0xff2F3336) : Color(0xffD0D9DE),
                      highlightColor:
                          isDark ? Color(0xff2F3336) : Color(0xffD0D9DE),
                      child: Container(
                        color: isDark ? Color(0xff2F3336) : Color(0xffD0D9DE),
                        width: 56,
                        height: 56,
                      ),
                    );
                  },
                  errorWidget: (_, __, ___) => Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: cs.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
              title: Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle15(context)
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(product.unit!, style: Styles.textStyle13(context)),
              trailing: Text('${product.price} ر.ي',
                  style: Styles.textStyle13(context)),
            ),
          ),
        ),
      ),
    );
  }
}
