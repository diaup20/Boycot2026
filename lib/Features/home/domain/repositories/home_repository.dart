import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../data/models/category_model.dart';
import '../../data/models/product_model.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<ProductModel>>> getAllProducts();

  Future<Either<Failure, List<ProductModel>>> getBoycottProducts();
  Future<Either<Failure, List<CategoryModel>>> getAllCategories();
}
