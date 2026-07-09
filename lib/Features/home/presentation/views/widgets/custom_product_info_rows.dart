import 'package:flutter/material.dart';

import '../../../../../Core/constants/color_constants.dart';
import '../../../../../Core/utils/styles.dart';
import '../../../data/models/product_model.dart';

class CustomProductInfoRows extends StatelessWidget {
  final ProductModel product;
  final List<ProductModel> allProducts;

  final DraggableScrollableController dssController;
  const CustomProductInfoRows(
      {required this.product,
      required this.dssController,
      required this.allProducts});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CustomInfoRow(
            icon: Icons.attach_money,
            label: 'السعر',
            isClickable: false,
            value: '${product.price} ر.ي'),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/brandProducts',
              arguments: {
                'brand': product.brand,
                'allProducts': allProducts,
              },
            );
          },
          child: _CustomInfoRow(
              icon: Icons.branding_watermark,
              label: 'العلامة التجارية',
              isClickable: true,
              decoration: TextDecoration.underline,
              value: product.brand!.name),
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/companyProducts',
              arguments: {
                'companyName': product.brand?.companyName,
                'allProducts': allProducts,
              },
            );
          },
          child: _CustomInfoRow(
              icon: Icons.business,
              label: 'الشركة',
              isClickable: true,
              decoration: TextDecoration.underline,
              value: product.brand?.companyName),
        ),
        InkWell(
          onTap: () {
            dssController.animateTo(
              dssController.pixelsToSize(55),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
            Navigator.pushNamed(
              context,
              '/agentProducts',
              arguments: product.agent,
            );
          },
          child: _CustomInfoRow(
            icon: Icons.store,
            label: 'الوكيل',
            value: product.agent?.name ?? '-',
            decoration: product.agent != null ? TextDecoration.underline : null,
            isClickable: product.agent != null,
          ),
        ),
        _CustomInfoRow(
            icon: Icons.public,
            label: 'بلد المنشأ',
            isClickable: false,
            value: product.brand?.country),
        _CustomInfoRow(icon: Icons.inbox, label: 'الوحدة', value: product.unit),
        _CustomInfoRow(
            icon: Icons.cancel,
            label: 'سبب المقاطعة',
            isClickable: false,
            value: product.violationReason),
        if (product.category.isNotEmpty)
          ...product.category.map((cat) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/categoryProducts',
                    arguments: cat,
                  );
                },
                child: _CustomInfoRow(
                  icon: Icons.category,
                  label: 'الفئة',
                  value: cat.name,
                  decoration: TextDecoration.underline,
                  isClickable: true,
                ),
              )),
      ],
    );
  }
}


class _CustomInfoRow extends StatelessWidget {
  const _CustomInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.decoration,
    this.isClickable = false,
  });

  final IconData icon;
  final String label;
  final TextDecoration? decoration;
  final String? value;
  final bool isClickable;

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
              radius: 14,
              backgroundColor: kPrimaryColor.withOpacity(0.4),
              child:
                  Icon(icon, color: Colors.white70.withOpacity(0.8), size: 18)),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: Styles.textStyle18(context).copyWith(
              decoration: decoration,
            ),
          ),
          Expanded(
              child: Text(value!,
                  style: TextStyle(
                    color: isClickable ? kPrimaryColor : null,
                    fontWeight:
                        isClickable ? FontWeight.bold : FontWeight.normal,
                    decoration: decoration,
                    shadows: isClickable
                        ? [Shadow(color: Colors.black12, blurRadius: 2)]
                        : null,
                  ))),
        ],
      ),
    );
  }
}
