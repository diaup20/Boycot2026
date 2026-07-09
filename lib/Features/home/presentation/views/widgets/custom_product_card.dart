import 'package:cached_network_image/cached_network_image.dart';
import 'package:consumer_prices_app/Features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../Core/constants/color_constants.dart';
import '../../../../../Core/utils/styles.dart';

class CustomProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const CustomProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  Widget _buildBadge() {
    if (product.isBoycott == true) {
      return _buildBadgeContainer(
        color1: Colors.red.shade700,
        color2: Colors.red.shade400,
        icon: Icons.block,
        text: 'منتج مقاطع',
      );
    } else if (product.isLocal == true) {
      return _buildBadgeContainer(
        color1: Colors.green.shade700,
        color2: Colors.green.shade400,
        icon: Icons.verified,
        text: 'ادعم منتج بلدك',
      );
    } else {
      return _buildBadgeContainer(
        color1: Colors.blue.shade700,
        color2: Colors.blue.shade400,
        icon: Icons.check_circle,
        text: 'منتج غير مقاطع',
      );
    }
  }

  Widget _buildBadgeContainer({
    required Color color1,
    required Color color2,
    required IconData icon,
    required String text,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomRight: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 17),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 0.2,
              shadows: [
                Shadow(color: Colors.black26, blurRadius: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
        height: 100,
        width: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: cs.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.blueAccent.withOpacity(0.13),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: product.image != null && product.image!.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: product.image!,
                  fit: BoxFit.contain,
                  placeholder: (context, url) {
                    final isDark =
                        Theme.of(context).brightness == Brightness.dark;
                    return Shimmer.fromColors(
                      baseColor: isDark ? Colors.blue[200]! : Colors.blue[200]!,
                      highlightColor:
                          isDark ? Colors.blue[200]! : Colors.blue[100]!,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: isDark ? Colors.blue[300]! : Colors.white54,
                        ),
                        width: 66,
                        height: 66,
                      ),
                    );
                  },
                  errorWidget: (_, __, ___) => Icon(
                    Icons.image_not_supported,
                    size: 55,
                    color: cs.onSurface.withOpacity(0.6),
                  ),
                ),
              )
            : const Icon(Icons.image));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [
            kPrimaryColor.withOpacity(0.10),
            cs.primaryContainer,
            cs.secondaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.09),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: kPrimaryColor.withOpacity(0.18),
          width: 1.1,
        ),
      ),
      child: Stack(
        children: [
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            onTap: onTap,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            leading: _buildProductImage(context),
            title: Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Text(
                product.name,
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: Styles.textStyle14(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  shadows: [
                    Shadow(
                        color: Colors.blueAccent.withOpacity(0.08),
                        blurRadius: 4),
                  ],
                ),
              ),
            ),
            subtitle: Text(
              product.unit ?? '',
              style: Styles.textStyle13(context).copyWith(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
            trailing: null,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: _buildBadge(),
          ),
        ],
      ),
    );
  }
}
