import 'package:hive/hive.dart';
part 'category_model.g.dart';

@HiveType(typeId: 1)
class CategoryModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? image;
  @HiveField(3)
  final int? parentId;

  CategoryModel({
    required this.id,
    required this.name,
    this.image,
    this.parentId,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      image: json['image'] as String?,
      parentId: json['parent_id'] != null
          ? int.tryParse(json['parent_id'].toString())
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'parent_id': parentId,
      };
}
