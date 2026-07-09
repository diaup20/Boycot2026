import '../../domain/entities/app_info.dart';
import '../../domain/repositories/app_info_repository.dart';
import '../datasources/remote_datasource.dart';

class AppInfoRepositoryImpl implements AppInfoRepository {
  final InfoRemoteDataSource ds;
  AppInfoRepositoryImpl(this.ds);

  @override
  Future<AppInfo> getInfo() async {
    final m = await ds.fetchInfo();
    return AppInfo(info: m.info);
  }
}
