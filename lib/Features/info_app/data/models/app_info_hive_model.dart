import 'package:hive/hive.dart';

part 'app_info_hive_model.g.dart';

@HiveType(typeId: 100)
class AppInfoHive extends HiveObject {
  @HiveField(0)
  final String info;

  AppInfoHive({required this.info});
}
