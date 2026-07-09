import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../../../Core/use_case/use_case.dart';
import '../../data/models/product_model.dart';
import '../repositories/home_repository.dart';

// class GetAllProductsUseCase {
//   final HomeRepository repo;
//   GetAllProductsUseCase(this.repo);
//   Future<Either<Failure, List<ProductModel>>> call() => repo.getAllProducts();
// }

// class GetBoycottProductsUseCase {
//   final HomeRepository repo;
//   GetBoycottProductsUseCase(this.repo);
//   Future<Either<Failure, List<ProductModel>>> call() =>
//       repo.getBoycottProducts();
// }

// class GetAllCategoriesUseCase {
//   final HomeRepository repo;
//   GetAllCategoriesUseCase(this.repo);
//   Future<Either<Failure, List<CategoryModel>>> call() =>
//       repo.getAllCategories();
// }

class GetBoycottProductsUseCase extends UseCase {
  final HomeRepository homeRepository;
  GetBoycottProductsUseCase(this.homeRepository);
  @override
  Future<Either<Failure, List<ProductModel>>> call() async =>
     await homeRepository.getBoycottProducts();
}
