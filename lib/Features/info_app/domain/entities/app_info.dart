// features/info_app/domain/entities/app_info.dart

import 'package:equatable/equatable.dart';

class AppInfo extends Equatable {
  final String info;
  const AppInfo({required this.info});

  @override
  List<Object?> get props => [info];
}
