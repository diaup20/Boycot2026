import 'package:hive/hive.dart';
import 'agent/agent_model.dart';
part 'brand_model.g.dart';

@HiveType(typeId: 3)
class BrandModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? country;
  @HiveField(3)
  final String? companyName;
  @HiveField(4)
  final AgentModel? agent;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final bool isBoycott;
  @HiveField(7)
  final bool isLocal;
  @HiveField(8)
  final bool isActive;

  BrandModel({
    required this.id,
    required this.name,
    this.country,
    this.companyName,
    this.agent,
    this.image,
    required this.isBoycott,
    required this.isLocal,
    required this.isActive,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    bool parseBool(String? v) => v == 'نعم' || v == '1' || v == 'true';
    return BrandModel(
      id: json['id'] as int,
      name: json['name'] as String,
      country: json['country'] as String?,
      companyName: json['company_name'] as String?,
      agent: json['agent'] != null
          ? AgentModel.fromJson(json['agent'] as Map<String, dynamic>)
          : null,
      image: json['image'] as String?,
      isBoycott: parseBool(json['is_boycott'] as String?),
      isLocal: parseBool(json['is_local'] as String?),
      isActive: parseBool(json['is_active'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'country': country,
        'company_name': companyName,
        'agent': agent?.toJson(),
        'image': image,
        'is_boycott': isBoycott,
        'is_local': isLocal,
        'is_active': isActive,
      };
}
