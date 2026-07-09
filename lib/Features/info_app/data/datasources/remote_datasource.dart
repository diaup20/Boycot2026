import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../Core/constants/api_constants.dart';
import '../models/app_info_model.dart';

abstract class InfoRemoteDataSource {
  Future<AppInfoModel> fetchInfo();
}

class InfoRemoteDataSourceImpl implements InfoRemoteDataSource {
  final http.Client client;
  InfoRemoteDataSourceImpl(this.client);

  @override
  Future<AppInfoModel> fetchInfo() async {
    print('▶️ [InfoRemoteDataSource] GET ${ApiConstants.baseUrl}/app-info');
    final res = await client.get(Uri.parse('${ApiConstants.baseUrl}/app-info'));
    debugPrint('▶️ [InfoRemoteDataSource] ← status ${res.statusCode}');
    if (res.statusCode == 200) {
      return AppInfoModel.fromJson(json.decode(res.body));
    }
    throw Exception('Failed to load app‑info');
  }
}
