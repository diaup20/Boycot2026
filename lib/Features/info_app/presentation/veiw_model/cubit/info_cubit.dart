import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/app_info_hive_model.dart';
import '../../../domain/entities/app_info.dart';
import '../../../domain/usecases/get_app_info.dart';

part 'info_state.dart';

class InfoCubit extends Cubit<InfoState> {
  final GetAppInfo usecase;
  InfoCubit(this.usecase) : super(InfoInitial());

  final Box<AppInfoHive> _box = Hive.box<AppInfoHive>('app_info_box');

  Future<void> load() async {
    emit(InfoLoading());
    try {
      final info = await usecase();
      await _box.put('info', AppInfoHive(info: info.info));
      emit(InfoLoaded(info));
    } catch (_) {
      final cached = _box.get('info');
      if (cached != null) {
        emit(InfoLoaded(AppInfo(info: cached.info)));
      } else {
        emit(InfoError());
      }
    }
  }
}
