import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:consumer_prices_app/Core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../Core/constants/api_constants.dart';
import '../models/agent/agent_model.dart';
import '../models/category_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, List<AgentModel>>> fetchAllAgents();
  Future<Either<Failure, List<CategoryModel>>> fetchAllCategories();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final http.Client client;
  HomeRemoteDataSourceImpl(this.client);

  @override
  Future<Either<Failure, List<AgentModel>>> fetchAllAgents() async {

    try {
      final res = await client.get(Uri.parse('${ApiConstants.baseUrl}/agent'));
      print('Agent API status: ${res.statusCode}');
      print('Agent API body: ${res.body}');
      if (res.statusCode != 200) return Left(ServerFailure(res.statusCode));
      if (res.statusCode != 200) {
        return Left(ServerFailure(res.statusCode));
      }

      final Map<String, dynamic> root = json.decode(res.body);
      final response = AgentResponseModel.fromJson(root);

      return Right(response.data);
    } on SocketException catch (e) {
      print('SocketException: $e');
      return const Left(NetworkFailure());
    } catch (e, s) {
      print('Agent API error: $e');
      print('Stack: $s');
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchAllCategories() async {
    
    try {
      print('Start fetching categories...');
      final res = await client.get(Uri.parse('${ApiConstants.baseUrl}/category'));
      print('Response received: ${res.statusCode}');
      print('Category API body: ${res.body}');
      if (res.statusCode != 200) return Left(ServerFailure(res.statusCode));
      final root = json.decode(res.body) as Map<String, dynamic>;
      final raw = root['data'] as List<dynamic>? ?? [];
      print('Category API raw: $raw');
      final cats = raw
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(cats);
    } on SocketException catch (e) {
      print('❌ SocketException: $e');
      return const Left(NetworkFailure());
    } on TimeoutException catch (e) {
      print('❌ TimeoutException: $e');
      return const Left(NetworkFailure());
    } on FormatException catch (e) {
      print('❌ FormatException: $e');
      return const Left(ParseFailure());
    } catch (e, st) {
      print('❌ Unknown error in fetchAllCategories: $e\n$st');
      return Left(UnknownFailure(e.toString()));
    }
  }
}

