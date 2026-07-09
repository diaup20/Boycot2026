// import 'dart:convert';
// import 'dart:io';
// import 'package:http/http.dart' as http;

// import '../../../../Core/error/exceptions.dart';
// import '../../../../Core/error/failure.dart';
// import '../../../../core/constants/api_constants.dart';

// abstract class SearchRemoteDataSource {
//   Future<List<ProductModel>> fetchAllProducts();
// }

// class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
//   final http.Client client;
//   SearchRemoteDataSourceImpl(this.client);

//   @override
//   Future<List<ProductModel>> fetchAllProducts() async {
//     final uri = Uri.parse('${ApiConstants.baseUrl}/agent');
//     final response = await client.get(uri);
//     if (response.statusCode != 200) {
//       throw ServerException(response.statusCode);
//     }

//     final dynamic decoded = json.decode(response.body);
//     if (decoded is! Map<String, dynamic>) {
//       throw ParsingException();
//     }
//     final dataRaw = decoded['data'];

//     if (dataRaw is! List) {
//       throw ParsingException();
//     }

//     final List<dynamic> allRawProducts = [];
//     for (var agentEntry in dataRaw) {
//       if (agentEntry is Map<String, dynamic> &&
//           agentEntry['products'] is List) {
//         allRawProducts.addAll(agentEntry['products'] as List);
//       }
//     }

//     // print('🔔 [DataSource] total raw products: ${allRawProducts.length}');

//     final models = allRawProducts
//         .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
//         .toList();

//     // for (var i = 0; i < models.length && i < 5; i++) {
//     //   print('   • ${models[i].barcode} ⇒ ${models[i].name}');
//     // }

//     return models;
//   }
// }
