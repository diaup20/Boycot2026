import 'package:flutter/material.dart';

import '../../../../../Core/constants/color_constants.dart';

class HomeFancyCardRow extends StatelessWidget {
  const HomeFancyCardRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = [
      {
        'title': 'الأصناف',
        'image': 'assets/images/full-shopping-cart.png',
        'route': '/categories',
      },
      {
        'title': 'العلامات ',
        'image': 'assets/images/image-brand1.png',
        'route': '/allBrands',
      },
      {
        'title': 'الشركات ',
        'image': 'assets/images/image-company.png',
        'route': '/allCompanies',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return _ItemCard(
            title: item['title']!,
            imageUrl: item['image']!,
            onTap: () {
              Navigator.pushNamed(context, item['route']!);
            },
          );
        },
      ),
    );
  }
}

class _ItemCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onTap;

  const _ItemCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
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

      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.contain,
                  width: double.infinity,
                  errorBuilder: (ctx, err, st) => Center(
                      child: Icon(Icons.broken_image,
                          size: 40, color: cs.onSurface)),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
