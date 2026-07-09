import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../../../Core/constants/color_constants.dart';
import '../../../home/data/models/product_hive.dart';
import '../../../home/presentation/view_model/category_cubit/category_cubit.dart';
import '../../../home/presentation/view_model/home_cubit/home_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _noInternet = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<bool> _checkInternet() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void _loadInitialData() async {
    setState(() {
      _loading = true;
      _noInternet = false;
    });

    final homeCubit = context.read<HomeCubit>();
    final catCubit = context.read<CategoryCubit>();

    final boxProducts = Hive.box<ProductHive>('boycott_products');
    final boxCategories = Hive.box<String>('cached_categories');
    final hasProducts = boxProducts.isNotEmpty;
    final hasCategories = boxCategories.isNotEmpty;

    if (hasProducts && hasCategories) {
      await Future.wait([
        homeCubit.loadData(),
        catCubit.loadCategories(),
      ]);
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/layout');
      }
    } else {
      final connected = await _checkInternet();
      if (!connected) {
        setState(() {
          _noInternet = true;
          _loading = false;
        });
        return;
      }
      await Future.wait([
        homeCubit.loadData(),
        catCubit.loadCategories(),
      ]);
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/layout');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: _loading
            ? const Text(
                'أسعار المستهلك',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )
            : _noInternet
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, color: Colors.white, size: 60),
                      const SizedBox(height: 16),
                      const Text(
                        'لا يتوفر اتصال بالإنترنت',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: kPrimaryColor,
                        ),
                        onPressed: _loadInitialData,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  )
                : const SizedBox(),
      ),
    );
  }
}
