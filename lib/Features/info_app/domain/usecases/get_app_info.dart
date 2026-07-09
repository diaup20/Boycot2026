import '../entities/app_info.dart';
import '../repositories/app_info_repository.dart';

class GetAppInfo {
  final AppInfoRepository repo;
  GetAppInfo(this.repo);
  Future<AppInfo> call() => repo.getInfo();
}
