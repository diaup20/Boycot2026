// // lib/features/home/domain/entities/product.dart
// import 'package:equatable/equatable.dart';

// import '../../data/models/agent/agent_model.dart';
// import '../../data/models/alternative/alternative_model.dart';
// import '../../data/models/brand_model.dart';
// import '../../data/models/category_model.dart';
// import '../../data/models/product_model.dart';

// class Product extends Equatable {
//   final int id;
//   final String name, barcode, description, unit, image;
//   final double price;
//   final bool isLocal, isBoycott;

//   Product({
//     required this.id,
//     required this.name,
//     required this.barcode,
//     required this.price,
//     required this.description,
//     required this.unit,
//     required this.image,
//     required this.isLocal,
//     required this.isBoycott,
//   });

//   @override
//   List<Object?> get props => [id, name, barcode, price, isLocal, isBoycott];
// }

// class Product extends Equatable {
//   final int id;
//   final String name;
//   final String? barcode;
//   final double? price;
//   final AgentModel? agent;
//   final BrandModel? brand;
//   final List<CategoryModel> category;
//   final bool isLocal;
//   final String? weight;
//   final String? description;
//   final String? violationReason;
//   final bool isBoycott;
//   final bool isActive;
//   final bool isFav;
//   final bool isViolent;
//   final String? unit;
//   final String? image;
//   final List<AlternativeModel> alternatives;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   const Product({
//     required this.id,
//     required this.name,
//     this.barcode,
//     this.price,
//     this.agent,
//     this.brand,
//     this.category = const [],
//     this.isLocal = false,
//     this.weight,
//     this.description,
//     this.violationReason,
//     this.isBoycott = false,
//     this.isActive = false,
//     this.isFav = false,
//     this.isViolent = false,
//     this.unit,
//     this.image,
//     this.alternatives = const [],
//     this.createdAt,
//     this.updatedAt,
//   });

//   @override
//   List<Object?> get props => [
//         id,
//         name,
//         barcode,
//         price,
//         agent,
//         brand,
//         category,
//         isLocal,
//         weight,
//         description,
//         violationReason,
//         isBoycott,
//         isActive,
//         isFav,
//         isViolent,
//         unit,
//         image,
//         alternatives,
//         createdAt,
//         updatedAt,
//       ];
// }
