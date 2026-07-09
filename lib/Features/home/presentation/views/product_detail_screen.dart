import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../Core/constants/color_constants.dart';
import '../../data/models/product_model.dart';
import 'widgets/my_badge_widget.dart';
import 'widgets/product_detail_sheet.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;
  final List<ProductModel> allProducts;

  const ProductDetailScreen(
      {Key? key, required this.product, required this.allProducts})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _fade;
  late final DraggableScrollableController _dssController;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _ctrl.forward();
    _dssController = DraggableScrollableController();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _dssController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                _dssController.animateTo(
                  0.55,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                );
              },
              child: Container(
                color: Colors.transparent,
              ),
            ),
            Column(
              children: [
                _ProductDetailAppBar(onBack: () => Navigator.pop(context)),
                _ProductImage(
                  product: p,
                  fade: _fade,
                  badge: buildBadge(product: p),
                ),
              ],
            ),
            ProductDetailSheet(
              product: p,
              dssController: _dssController,
              allProducts: widget.allProducts,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProductDetailAppBar extends StatelessWidget {
  final VoidCallback onBack;
  const _ProductDetailAppBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 6)
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios,
                  color: Theme.of(context).colorScheme.primary, size: 20),
              onPressed: onBack,
            ),
          ),

        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final ProductModel product;
  final Widget? badge;

  final Animation<double> fade;

  const _ProductImage({required this.product, required this.fade, this.badge});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return FadeTransition(
      opacity: fade,
      child: Hero(
        tag: product.id,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [kPrimaryColor.withOpacity(0.2), Colors.transparent],
                ),
              ),
            ),
            Container(
              height: 260,
              width: MediaQuery.sizeOf(context).width,
              margin: const EdgeInsets.symmetric(horizontal: 32),
              decoration: ShapeDecoration(
                color: cs.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(24)),
                  side: BorderSide(color: cs.primary.withOpacity(0.3)),
                ),
                shadows: [
                  BoxShadow(color: cs.shadow, blurRadius: 15, spreadRadius: 10),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: product.image != null && product.image!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: product.image!,
                        // fit: BoxFit.contain,
                        placeholder: (context, url) {
                          final isDark =
                              Theme.of(context).brightness == Brightness.dark;
                          return Shimmer.fromColors(
                            baseColor:
                                isDark ? Colors.blue[200]! : Colors.blue[200]!,
                            highlightColor:
                                isDark ? Colors.blue[200]! : Colors.blue[100]!,
                            child: Container(
                              color:
                                  isDark ? Colors.blue[300]! : Colors.white54,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );
                        },
                        errorWidget: (_, __, ___) => Icon(
                          Icons.image_not_supported,
                          size: 80,
                          color: cs.onSurface.withOpacity(0.6),
                        ),
                      )
                    : const Icon(Icons.image_not_supported, size: 80),
              ),
            ),
            Positioned(
              top: 0,
              left: 32,
              child: SizedBox(
                height: 28,
                width: 130,
                child: badge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
