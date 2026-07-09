import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../../../Core/use_case/use_case.dart';
import '../../data/models/product_model.dart';
import '../repositories/home_repository.dart';

class GetAllProductsUseCase extends UseCase {
  final HomeRepository homeRepository;
  GetAllProductsUseCase(this.homeRepository);
  @override
  Future<Either<Failure, List<ProductModel>>> call() async =>
    await  homeRepository.getAllProducts();
}