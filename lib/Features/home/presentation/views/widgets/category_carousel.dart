// // // lib/features/common/widgets/category_carousel.dart

// import 'package:boycott_products_app/Features/home/data/models/category_model.dart';
// import 'package:boycott_products_app/Features/home/presentation/views/category_products_screen.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:shimmer/shimmer.dart';
// import '../../../../../Core/constants/color_constants.dart';
// import '../../../../../Core/utils/styles.dart';

// // typedef OnViewAllTapped = void Function();

// // class CategoryCarousel extends StatelessWidget {
// //   /// قائمة الفئات المأخوذة من ProductModel.category
// //   final List<CategoryModel> categories;

// //   /// مستدعى عند الضغط على "عرض الكل"
// //   final OnViewAllTapped? onViewAll;

// //   const CategoryCarousel({
// //     super.key,
// //     required this.categories,
// //     this.onViewAll,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     if (categories.isEmpty) {
// //       return const SizedBox.shrink();
// //     }

// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text('الفئات', style: Styles.textStyle20(context)),
// //               if (onViewAll != null)
// //                 InkWell(
// //                   onTap: onViewAll,
// //                   borderRadius: BorderRadius.circular(4),
// //                   child: Padding(
// //                     padding:
// //                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
// //                     child: Row(
// //                       children: [
// //                         Text(
// //                           'عرض الكل',
// //                           style: TextStyle(
// //                             fontSize: 16,
// //                             color: kPrimaryColor,
// //                             fontWeight: FontWeight.w600,
// //                             fontFamily: 'Cairo',
// //                           ),
// //                         ),
// //                         const SizedBox(width: 4),
// //                         FaIcon(
// //                           FontAwesomeIcons
// //                               .chevronLeft, // سهم يشير إلى اليسار في واجهات RTL
// //                           size: 14,
// //                           color: kPrimaryColor,
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //             ],
// //           ),
// //         ),

// //         // قارئ القائمة الأفقي
// //         SizedBox(
// //           height: 100,
// //           child: ListView.separated(
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             scrollDirection: Axis.horizontal,
// //             itemCount: 10,
// //             separatorBuilder: (_, __) => const SizedBox(width: 12),
// //             itemBuilder: (ctx, i) {
// //               final cat = categories[i];
// //               return _CategoryItem(cat: cat);
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class _CategoryItem extends StatelessWidget {
// //   final CategoryModel cat;
// //   const _CategoryItem({super.key, required this.cat});

// //   @override
// //   Widget build(BuildContext context) {
// //     final cs = Theme.of(context).colorScheme;
// //     return InkWell(
// //       onTap: () {
// //         Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (_) => CategoryProductsScreen(category: cat),
// //           ),
// //         );
// //       },
// //       child: Column(
// //         children: [
// //           // الدائرة الرمزية
// //           Container(
// //             width: 72,
// //             height: 72,
// //             decoration: BoxDecoration(
// //               shape: BoxShape.circle,
// //               color: Colors.orange.withAlpha(40),
// //             ),
// //             child: ClipOval(
// //               child: cat.image != null && cat.image!.isNotEmpty
// //                   ? CachedNetworkImage(
// //                       imageUrl: cat.image!,
// //                       fit: BoxFit.cover,
// //                       errorWidget: (_, __, ___) => Icon(
// //                           Icons.image_not_supported,
// //                           size: 40,
// //                           color: cs.primary.withOpacity(0.4)),
// //                     )
// //                   : const Icon(Icons.image),
// //             ),
// //           ),
// //           const SizedBox(height: 6),
// //           SizedBox(
// //             width: 80,
// //             child: Text(
// //               cat.name,
// //               textAlign: TextAlign.center,
// //               maxLines: 1,
// //               overflow: TextOverflow.ellipsis,
// //               style: Styles.textStyle14(context),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // category_carousel.dart

// typedef OnViewAllTapped = void Function();

// class CategoryCarousel extends StatelessWidget {
//   final List<CategoryModel> categories;
//   final OnViewAllTapped? onViewAll;

//   const CategoryCarousel({
//     Key? key,
//     required this.categories,
//     this.onViewAll,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (categories.isEmpty) return const SizedBox.shrink();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // رأس القسم
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text('الفئات', style: Styles.textStyle20(context)),
//               if (onViewAll != null)
//                 InkWell(
//                   onTap: onViewAll,
//                   borderRadius: BorderRadius.circular(4),
//                   child: Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                     child: Row(
//                       children: [
//                         Text(
//                           'عرض الكل',
//                           style: TextStyle(
//                             fontSize: 16,
//                             color: kPrimaryColor,
//                             fontWeight: FontWeight.w600,
//                             fontFamily: 'Cairo',
//                           ),
//                         ),
//                         const SizedBox(width: 4),
//                         FaIcon(
//                           FontAwesomeIcons.chevronLeft,
//                           size: 14,
//                           color: kPrimaryColor,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),

//         // قائمة أفقيّة قابلة للطي
//         SizedBox(
//           height: 100,
//           child: ListView.separated(
//             shrinkWrap: true,
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             scrollDirection: Axis.horizontal,
//             itemCount: categories.length > 8 ? 8 : categories.length,
//             separatorBuilder: (_, __) => const SizedBox(width: 12),
//             itemBuilder: (ctx, i) {
//               final cat = categories[i];
//               return _CategoryItem(cat: cat);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _CategoryItem extends StatelessWidget {
//   final CategoryModel cat;
//   const _CategoryItem({Key? key, required this.cat}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isDark = Theme.of(context).brightness == Brightness.dark;

//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (_) => CategoryProductsScreen(category: cat)),
//         );
//       },
//       child: Column(
//         children: [
//           Container(
//             width: 72,
//             height: 72,
//             decoration: ShapeDecoration(
//               color: cs.primaryContainer,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(40),
//                 side: BorderSide(color: cs.primary.withOpacity(0.3)),
//               ),
//               shadows: [
//                 BoxShadow(color: cs.shadow, blurRadius: 15, spreadRadius: 10),
//               ],
//             ),
//             // decoration: BoxDecoration(
//             //   shape: BoxShape.circle,
//             //   color: cs.primary.withOpacity(0.1),
//             // ),
//             child: ClipOval(
//               child: cat.image != null && cat.image!.isNotEmpty
//                   ? CachedNetworkImage(
//                       imageUrl: cat.image!,
//                       fit: BoxFit.cover,
//                       placeholder: (context, url) => Shimmer.fromColors(
//                         baseColor:
//                             isDark ? Color(0xff2F3336) : Color(0xffD0D9DE),
//                         highlightColor:
//                             isDark ? Color(0xff2F3336) : Color(0xffD0D9DE),
//                         child: Container(
//                           color: isDark ? Color(0xff2F3336) : Color(0xffD0D9DE),
//                           width: double.infinity,
//                           height: double.infinity,
//                         ),
//                       ),
//                       errorWidget: (_, __, ___) => Icon(
//                         Icons.image_not_supported,
//                         size: 40,
//                         color: cs.primary.withOpacity(0.4),
//                       ),
//                     )
//                   : Icon(Icons.category, size: 36, color: cs.primary),
//             ),
//           ),
//           const SizedBox(height: 6),
//           SizedBox(
//             width: 80,
//             child: Text(
//               cat.name,
//               textAlign: TextAlign.center,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//               style: Styles.textStyle14(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
