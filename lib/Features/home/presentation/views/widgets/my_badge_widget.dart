import 'package:consumer_prices_app/Features/home/data/models/product_model.dart';
import 'package:flutter/material.dart';

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


Widget buildBadge({required  ProductModel product}) {
  
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