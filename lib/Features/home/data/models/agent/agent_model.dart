import 'package:hive/hive.dart';

import '../brand_model.dart';
import '../product_model.dart';

part 'agent_model.g.dart';

@HiveType(typeId: 4)
class AgentModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? phone;
  @HiveField(3)
  final String? address;
  @HiveField(4)
  final bool isActive;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final List<BrandModel> brands;
  @HiveField(7)
  final List<ProductModel> products;

  AgentModel({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    required this.isActive,
    this.image,
    required this.brands,
    required this.products,
  });

  factory AgentModel.fromJson(Map<String, dynamic> json) {
    bool parseBool(String? v) => v == 'نعم' || v == '1' || v == 'true';
    return AgentModel(
      id: json['id'] as int,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      isActive: parseBool(json['is_active'] as String?),
      image: json['image'] as String?,
      brands: (json['brands'] as List<dynamic>?)
              ?.map((e) => BrandModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      products: (json['products'] as List<dynamic>?)
              ?.map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'is_active': isActive,
        'image': image,
        'brands': brands.map((e) => e.toJson()).toList(),
        'products': products.map((e) => e.toJson()).toList(),
      };
}

class AgentResponseModel {
  final String? message;
  final List<AgentModel> data;

  AgentResponseModel({
    required this.message,
    required this.data,
  });

  factory AgentResponseModel.fromJson(Map<String, dynamic> json) {
    return AgentResponseModel(
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => AgentModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}