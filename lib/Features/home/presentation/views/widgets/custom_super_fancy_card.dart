import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../Core/constants/color_constants.dart';
import '../../../../../Core/utils/styles.dart';

class CustomSuperFancyCard extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? image;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const CustomSuperFancyCard({
    super.key,
    required this.title,
    this.icon,
    this.image,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      margin: const EdgeInsets.all(5),
   
   decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        
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
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: onTap,
          splashColor: Colors.white.withOpacity(0.13),
          highlightColor: Colors.white.withOpacity(0.07),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                  child: image != null && image!.isNotEmpty
                      ? ClipOval(
                          child: Container(
                            width: 76,
                            height: 76,
                            child: Builder(
                              builder: (context) {
                                Brightness.dark;
                                final cs = Theme.of(context).colorScheme;
                                return CachedNetworkImage(
                                  imageUrl: image!,
                                  width: 76,
                                  height: 76,
                                  fit: BoxFit.cover,
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
                                        width: 76,
                                        height: 76,
                                      ),
                                    );
                                  },
                                  errorWidget: (_, __, ___) => Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                    color: cs.onSurface.withOpacity(0.6),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : CircleAvatar(
                          radius: 38,
                          backgroundColor: cs.secondaryContainer,
                          child: Icon(icon, size: 38, color: cs.onSurface),
                        ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Styles.textStyle17(context),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Container(
                  width: 36,
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
