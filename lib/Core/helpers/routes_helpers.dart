import 'package:flutter/material.dart';
import '../../Features/home/data/models/agent/agent_model.dart';
import '../../Features/home/data/models/brand_model.dart';
import '../../Features/home/data/models/category_model.dart';
import '../../Features/home/data/models/product_model.dart';
import '../../Features/home/presentation/views/agent_products_screen.dart';
import '../../Features/home/presentation/views/all_brands_view.dart';
import '../../Features/home/presentation/views/all_categories_screen.dart';
import '../../Features/home/presentation/views/all_companies_view.dart';
import '../../Features/home/presentation/views/brand_products_view.dart';
import '../../Features/home/presentation/views/category_products_screen.dart';
import '../../Features/home/presentation/views/company_products_view.dart';
import '../../Features/home/presentation/views/product_detail_screen.dart';
import '../../Features/splash/presentation/views/splash_screen.dart';
import '../utils/layout.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/': (_) => const SplashScreen(),
    '/layout': (_) => const Layout(),
    '/categories': (_) => const AllCategoriesScreen(),
    '/categoryProducts': (context) => CategoryProductsScreen(
          category: ModalRoute.of(context)!.settings.arguments as CategoryModel,
        ),
    '/agentProducts': (context) => AgentProductsScreen(
          agent: ModalRoute.of(context)!.settings.arguments as AgentModel,
        ),
    '/productDetail': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      final product = args['product'] as ProductModel;
      final allProducts = args['allProducts'] as List<ProductModel>;
      return ProductDetailScreen(
        product: product,
        allProducts: allProducts,
      );
    },
    '/allBrands': (_) => AllBrandsScreen(),
    '/allCompanies': (_) => AllCompaniesScreen(),
    '/companyProducts': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      final companyName = args['companyName'] as String;
      final allProducts = args['allProducts'] as List<ProductModel>;
      return CompanyProductsScreen(
        companyName: companyName,
        allProducts: allProducts,
      );
    },
    '/brandProducts': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      final brand = args['brand'] as BrandModel;
      final allProducts = args['allProducts'] as List<ProductModel>;
      return BrandProductsScreen(
        brand: brand,
        allProducts: allProducts,
      );
    },
  };
}
