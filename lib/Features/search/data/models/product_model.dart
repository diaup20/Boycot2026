// class ProductModel {
//   final int id;
//   final String name;
//   final String barcode;
//   final double price;
//   final String description;
//   final String unit;
//   final String image;
//   final bool isLocal;
//   final bool isBoycott;

//   ProductModel({
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

//   factory ProductModel.fromJson(Map<String, dynamic> json) {
//     final id = json['id'] is int
//         ? json['id'] as int
//         : int.tryParse('${json['id']}') ?? 0;
//     final name = (json['name'] ?? '').toString();
//     final barcode = (json['barcode'] ?? '').toString();
//     final price = double.tryParse('${json['price']}') ?? 0.0;
//     final description = (json['description'] ?? '').toString();
//     final unit = (json['unit'] ?? '').toString();
//     final image = (json['image'] ?? '').toString();

//     final isLocalRaw = json['is_local']?.toString().toLowerCase() ?? 'لا';
//     final isLocal = (isLocalRaw == 'نعم' || isLocalRaw == '1');

//     final isBoycottRaw =
//         json['is_boycott']?.toString().toLowerCase() ?? 'غير مقاطع';
//     final isBoycott = (isBoycottRaw == 'مقاطع' || isBoycottRaw == '1');

//     return ProductModel(
//       id: id,
//       name: name,
//       barcode: barcode,
//       price: price,
//       description: description,
//       unit: unit,
//       image: image,
//       isLocal: isLocal,
//       isBoycott: isBoycott,
//     );
//   }
// }
