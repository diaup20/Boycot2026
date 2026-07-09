class AppInfoModel {
  final String info;

  AppInfoModel({required this.info});

  factory AppInfoModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>? ?? {};
    return AppInfoModel(
      info: data['info']?.toString() ?? '',
    );
  }
}
