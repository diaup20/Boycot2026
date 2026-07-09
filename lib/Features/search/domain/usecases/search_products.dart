import 'package:dartz/dartz.dart';

import '../../../../Core/error/failure.dart';
import '../../../home/data/models/product_model.dart';
import '../../../home/domain/repositories/home_repository.dart';

class SearchProducts {
  final HomeRepository repository;
  SearchProducts(this.repository);

  Future<Either<Failure, List<ProductModel>>> call({
    required String query,
    bool Function(ProductModel)? filterOverride,
  }) async {
    final eitherAll = await repository.getAllProducts();
    return eitherAll.fold(
      (failure) => Left(failure),
      (all) {
        final q = query.toLowerCase();
        final filtered = all.where((p) {
          if (filterOverride != null) return filterOverride(p);
          return p.barcode?.toLowerCase() == q ||
              p.name.toLowerCase().contains(q);
        }).toList();
        return Right(filtered);
      },
    );
  }
}
