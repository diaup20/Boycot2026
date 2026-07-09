// import 'package:boycott_products_app/Features/search/domain/entities/product.dart';
// import 'package:dartz/dartz.dart';

// import '../../../../Core/error/exceptions.dart';
// import '../../../../Core/error/failure.dart';
// import '../../domain/repositories/search_repository.dart';
// import '../datasources/search_remote_data_source.dart';

// class SearchRepositoryImpl implements SearchRepository {
//   final SearchRemoteDataSource remoteDs;
//   SearchRepositoryImpl(this.remoteDs);

//   @override
//   Future<Either<Failure, List<Product>>> fetchAllProducts() async {
//     try {
//       final models = await remoteDs.fetchAllProducts();
//       final products = models.map(Product.fromModel).toList();
//       return Right(products);
//     } on NetworkException {
//       return const Left(NetworkFailure());
//     } on ServerException catch (e) {
//       return Left(ServerFailure(e.hashCode));
//     } on ParsingException {
//       return const Left(ParseFailure());
//     } catch (e) {
//       return Left(UnknownFailure(e.toString()));
//     }
//   }
// }
