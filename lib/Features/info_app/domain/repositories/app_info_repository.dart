
import '../entities/app_info.dart';

abstract class AppInfoRepository {
  Future<AppInfo> getInfo();
}
