import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../Core/error/failure.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';
import '../models/category_model.dart';
import '../models/product_hive.dart';
import '../models/product_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource ds;
  final Box<ProductHive> _productBox =
      Hive.box<ProductHive>('boycott_products');

  HomeRepositoryImpl(this.ds);

  @override
  Future<Either<Failure, List<ProductModel>>> getAllProducts() async {
    final result = await ds.fetchAllAgents();

    return await result.fold(
      (failure) async {
        // print('❌ Network error in getAllProducts: $failure');

        if (_productBox.isNotEmpty) {
          final cached = _productBox.values.map((h) => h.toModel()).toList();
          return Right(cached);
        }
        return Left(failure);
      },
      (agents) async {
        final allModels = agents.expand((a) => a.products).toList();
        // print('✅ All products from agents: ${allModels.length}');

        await _productBox.clear();
        final hives = allModels.map((m) => ProductHive.fromModel(m)).toList();
        await _productBox.addAll(hives);

        return Right(allModels);
      },
    );
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getBoycottProducts() async {
    final result = await ds.fetchAllAgents();

    return await result.fold(
      (failure) async {
        if (_productBox.isNotEmpty) {
          final cached = _productBox.values
              .map((h) => h.toModel())
              .where((p) => p.isBoycott)
              .toList();
          return Right(cached);
        }
        return Left(failure);
      },
      (agents) async {
        try {
          final all = agents.expand((a) => a.products);
          final boycotted = all.where((p) => p.isBoycott).toList();

          await _productBox.clear();
          final hives = all.map((p) => ProductHive.fromModel(p)).toList();
          await _productBox.addAll(hives);

          return Right(boycotted);
        } catch (e) {
          return const Left(ParseFailure());
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> getAllCategories() {
    return ds.fetchAllCategories();
  }
}
