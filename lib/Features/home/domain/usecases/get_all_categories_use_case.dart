import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../../../Core/use_case/use_case.dart';
import '../../data/models/category_model.dart';
import '../repositories/home_repository.dart';

class GetAllCategoriesUseCase extends UseCase {
  final HomeRepository homeRepository;
  GetAllCategoriesUseCase(this.homeRepository);
  @override
  Future<Either<Failure, List<CategoryModel>>> call() async =>
    await  homeRepository.getAllCategories();
}