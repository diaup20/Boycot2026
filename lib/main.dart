import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Core/helpers/routes_helpers.dart';
import 'Core/services/search_history_storage.dart';
import 'Core/services/theme_service.dart';
import 'Core/theme/cubit_theme/theme_cubit.dart';
import 'Core/theme/theme.dart';
import 'Features/home/data/datasources/home_remote_data_source.dart';
import 'Features/home/data/models/agent/agent_model.dart';
import 'Features/home/data/models/alternative/alternative_model.dart';
import 'Features/home/data/models/brand_model.dart';
import 'Features/home/data/models/category_model.dart';
import 'Features/home/data/models/product_hive.dart';
import 'Features/home/data/repositories/home_repository_impl.dart';
import 'Features/home/domain/usecases/get_all_categories_use_case.dart';
import 'Features/home/domain/usecases/get_all_products_use_case.dart';
import 'Features/home/domain/usecases/get_boycott_products_use_case.dart';
import 'Features/home/presentation/view_model/category_cubit/category_cubit.dart';
import 'Features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'Features/info_app/data/datasources/remote_datasource.dart';
import 'Features/info_app/data/models/app_info_hive_model.dart';
import 'Features/info_app/data/repositories/app_info_repository_impl.dart';
import 'Features/info_app/domain/usecases/get_app_info.dart';
import 'Features/info_app/presentation/veiw_model/cubit/info_cubit.dart';
import 'Features/search/domain/usecases/search_products.dart';
import 'Features/search/presentation/view_model/cubit/search_cubit.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductHiveAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(AlternativeModelAdapter());
  Hive.registerAdapter(BrandModelAdapter());
  Hive.registerAdapter(AgentModelAdapter());
  Hive.registerAdapter(AppInfoHiveAdapter());
  await Hive.openBox<String>('cached_products');
  await Hive.openBox<String>('cached_categories');
  await Hive.openBox<ProductHive>('boycott_products');
  await Hive.openBox<AppInfoHive>('app_info_box');

  final storageService = SecureStorageService();

  runApp(BlocProvider(
    create: (_) => ThemeCubit(storageService),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final client = http.Client();
    final infoDs = InfoRemoteDataSourceImpl(client);
    final infoRepo = AppInfoRepositoryImpl(infoDs);
    final infoUc = GetAppInfo(infoRepo);
    final ds = HomeRemoteDataSourceImpl(client);
    final homeRepo = HomeRepositoryImpl(ds);
    final getCats = GetAllCategoriesUseCase(homeRepo);
    final getAll = GetAllProductsUseCase(homeRepo);
    final getBoycot = GetBoycottProductsUseCase(homeRepo);

    final usecase = SearchProducts(homeRepo);

    SearchHistoryStorage historyStorage = SearchHistoryStorage();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => HomeCubit(
                getAllProducts: getAll, getBoycottProducts: getBoycot)),
        BlocProvider(create: (_) => CategoryCubit(getCats)),
        BlocProvider(create: (_) => InfoCubit(infoUc)),
        BlocProvider(create: (_) => SearchCubit(usecase, historyStorage)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            initialRoute: '/',
            routes: buildAppRoutes(),
            title: 'E-Commerce ',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
            debugShowCheckedModeBanner: false,
            locale: const Locale('ar'),
            supportedLocales: const [
              Locale('ar'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
          );
        },
      ),
    );
  }
}
