import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../data/models/alternative/alternative_model.dart';
import '../../../data/models/product_hive.dart';
import '../../../data/models/product_model.dart';
import '../../../domain/usecases/get_all_products_use_case.dart';
import '../../../domain/usecases/get_boycott_products_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetAllProductsUseCase _getAllProducts;

  List<ProductModel>? cachedAllProducts;
  List<ProductModel>? cachedBoycottProducts;

  HomeCubit({
    required GetAllProductsUseCase getAllProducts,
    required GetBoycottProductsUseCase getBoycottProducts,
  })  : _getAllProducts = getAllProducts,
        super(HomeInitial());
  Future<void> loadData() async {
    emit(HomeLoading());

    final boxJson = await Hive.openBox<String>('cached_products');
    final raw = boxJson.get('products_json');

    if (raw != null) {
      final list = (json.decode(raw) as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();
      print('✅ Loaded products from JSON cache: ${list.length}');
      print('Start loading products...');

      cachedAllProducts = list;
      cachedBoycottProducts = list.where((p) => p.isBoycott).toList();
      emit(HomeLoaded(cachedAllProducts!));
    } else {
      final boxHive = Hive.box<ProductHive>('boycott_products');
      if (boxHive.isNotEmpty) {
        final cached = boxHive.values.map((h) => h.toModel()).toList();
        print('✅ Loaded products from Hive box: ${cached.length}');
        cachedAllProducts = cached;
        cachedBoycottProducts = cached.where((p) => p.isBoycott).toList();
        emit(HomeLoaded(cachedAllProducts!));
      }
    }

    final allRes = await _getAllProducts();
    allRes.fold(
      (f) {
        print('❌ Network error: ${f.message}');
        if (cachedAllProducts == null || cachedAllProducts!.isEmpty) {
          emit(HomeError(f.message));
        }
      },
      (freshAll) async {
        print('✅ Loaded products from API: ${freshAll.length}');
        cachedAllProducts = freshAll;
        cachedBoycottProducts = freshAll.where((p) => p.isBoycott).toList();
        final encoded = json.encode(freshAll.map((p) => p.toJson()).toList());
        await boxJson.put('products_json', encoded);

        final boxHive = Hive.box<ProductHive>('boycott_products');
        await boxHive.clear();
        await boxHive.addAll(freshAll.map((m) => ProductHive.fromModel(m)));

        emit(HomeLoaded(cachedAllProducts!));
      },
    );
  }

  List<ProductModel> get boycottProducts => cachedBoycottProducts ?? [];

  List<AlternativeModel> get alternativeProducts {
    final raw = boycottProducts.expand((p) => p.alternatives);
    final filtered = raw.where((alt) =>
        !alt.isBoycott &&
        (alt.violationReason == null || alt.violationReason!.isEmpty));
    final map = <int, AlternativeModel>{};
    for (var alt in filtered) {
      map[alt.id] = alt;
    }
    return map.values.toList();
  }

  List<ProductModel> productsByAgent(int agentId) {
    return (cachedAllProducts ?? [])
        .where((p) => p.agent?.id == agentId)
        .toList();
  }

  List<ProductModel> productsByBrand(int brandId) {
    return (cachedAllProducts ?? [])
        .where((p) => p.brand?.id == brandId)
        .toList();
  }

  List<ProductModel> productsByCompany(String companyName) {
    return (cachedAllProducts ?? [])
        .where((p) => p.brand?.companyName == companyName)
        .toList();
  }

  List<ProductModel> getProductsByCategory(int categoryId) {
    final source = cachedAllProducts ?? [];
    return source
        .where((p) => p.category.any((c) => c.id == categoryId))
        .toList();
  }
}
