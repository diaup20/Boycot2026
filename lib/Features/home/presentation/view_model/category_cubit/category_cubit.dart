import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/category_model.dart';
import '../../../domain/usecases/get_all_categories_use_case.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final GetAllCategoriesUseCase _usecase;
  List<CategoryModel>? cachedCategories;

  CategoryCubit(this._usecase) : super(const CategoryInitial());

  Future<void> loadCategories() async {
    emit(const CategoryLoading());

    final box = await Hive.openBox<String>('cached_categories');

    try {
      final raw = box.get('categories_json');
      if (raw != null && raw.isNotEmpty) {
        final list = (json.decode(raw) as List<dynamic>)
            .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
            .toList();
        cachedCategories = list;
        emit(CategoryLoaded(list));
      }
    } catch (e, st) {
      print('🔴 [CategoryCubit] cache read error: $e\n$st');
    }

    final res = await _usecase();
    await res.fold(
      (failure) {
        print('❌ Network error (categories): ${failure.message}');
        if (cachedCategories == null || cachedCategories!.isEmpty) {
          emit(CategoryError(failure.message));
        }
      },
      (fresh) async {
        print('✅ Loaded categories from API: ${fresh.length}');
        cachedCategories = fresh;
        emit(CategoryLoaded(fresh));
        try {
          final encoded = json.encode(fresh.map((c) => c.toJson()).toList());
          await box.put('categories_json', encoded);
          print('✅ [CategoryCubit] saved ${fresh.length} categories to cache');
        } catch (e, st) {
          print('🔴 [CategoryCubit] cache write error: $e\n$st');
        }
      },
    );
  }
}
