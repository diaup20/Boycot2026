import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

import '../../../../../Core/error/failure.dart';
import '../../../../../Core/services/search_history_storage.dart';
import '../../../../home/data/models/product_model.dart';
import '../../../domain/usecases/search_products.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchProducts usecase;
  final SearchHistoryStorage historyStorage;

  List<ProductModel>? _cache;

  SearchCubit(this.usecase, this.historyStorage) : super(SearchInitial());

  bool get cacheIsEmpty => _cache == null || _cache!.isEmpty;

  Future<void> loadAll() async {
    emit(SearchLoading());
    try {
      final Either<Failure, List<ProductModel>> result =
          await usecase(query: '');
      result.fold(
        (f) => emit(SearchError(f.message)),
        (all) {
          _cache = all;
          emit(SearchIdle());
        },
      );
    } catch (e) {
      emit(SearchError('حدث خطأ غير متوقع: ${e.toString()}'));
    }
  }

  Future<List<ProductModel>> getSearchResults(String query) async {
    final norm = query.replaceAll(RegExp(r'[\s\-]'), '').toLowerCase();
    if (_cache == null) {
      await loadAll();
      if (state is SearchError) return [];
    }

    final byCode = _cache!
        .where((p) =>
            p.barcode?.replaceAll(RegExp(r'[\s\-]'), '').toLowerCase() == norm)
        .toList();
    if (byCode.isNotEmpty) return byCode;

    final byName = _cache!
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return byName;
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      emit(SearchEmptyInput());
      return;
    }
    if (_cache == null) await loadAll();
    if (state is SearchError) return;

    emit(SearchLoading());
    final norm = query.replaceAll(RegExp(r'[\s\-]'), '').toLowerCase();

    ProductModel? byCode = _cache!.firstWhereOrNull((p) =>
        p.barcode?.replaceAll(RegExp(r'[\s\-]'), '').toLowerCase() == norm);

    if (byCode != null) {
      await historyStorage.addEntry(query);
      emit(SearchLoaded(byCode));
      return;
    }

    final matches = _cache!
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (matches.isEmpty) {
      emit(SearchNoResults());
    } else if (matches.length == 1) {
      await historyStorage.addEntry(query);
      emit(SearchLoaded(matches.first));
    } else {
      await historyStorage.addEntry(query);
      emit(SearchLoadedList(matches));
    }
  }
}
