import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/helpers/navigation_helpers.dart';
import '../../../../Core/widgets/custom_circular_progress_indicatorr.dart';
import '../../../home/presentation/view_model/home_cubit/home_cubit.dart';
import '../../../home/presentation/views/widgets/custom_product_card.dart';
import '../view_model/cubit/search_cubit.dart';
import 'barcode_scan_screen.dart';
import 'widgets/custom_empty_state.dart';
import 'widgets/custom_search_text_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.initialQuery}) : super(key: key);

  final String? initialQuery;

  @override
  State<SearchScreen> createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _ctrl = TextEditingController();

  void clearSearchField() {
    _ctrl.clear();
  }

  @override
  void initState() {
    super.initState();
    if (widget.initialQuery != null) {
      _ctrl.text = widget.initialQuery!;
      WidgetsBinding.instance.addPostFrameCallback((_) => _doSearch());
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _doSearch() async {
    final text = _ctrl.text.trim();
    if (text.isEmpty) {
      context.read<SearchCubit>().emit(SearchEmptyInput());
    } else {
      await context.read<SearchCubit>().search(text);
    }
  }

  Future<void> _scanBarcode() async {
    final code = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const ScannerView()),
    );
    if (code != null && code.trim().isNotEmpty) {
      _ctrl.text = code;
      await _doSearch();
    }
  }

  @override
  Widget build(BuildContext context) {
    final allProducts = context.read<HomeCubit>().cachedAllProducts ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('البحث'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomSearchTextField(
              controller: _ctrl,
              onSearch: _doSearch,
              onScan: _scanBarcode,
            ),
          ),
          Expanded(
            child: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const CustomCircularProgressIndicator();
                }
                if (state is SearchEmptyInput) {
                  return const EmptyState(
                    message: 'الرجاء إدخال باركود أو اسم أولاً',
                    icon: Icons.input,
                  );
                }
                if (state is SearchNoResults) {
                  return const EmptyState();
                }
                if (state is SearchError) {
                  return const EmptyState(
                    message: 'لا يوجد اتصال بالانترنت',
                    icon: Icons.error_outline,
                  );
                }
                if (state is SearchLoadedList) {
                  final list = state.products;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 4),
                      child: CustomProductCard(
                        product: list[i],
                        onTap: () {
                          navigateToProductDetail(
                            context,
                            product: list[i],
                            allProducts: allProducts,
                          );

                          _ctrl.clear();
                        },
                      ),
                    ),
                  );
                }

                if (state is SearchLoaded) {
                  final product = state.product;
                  return CustomProductCard(
                    product: product,
                    onTap: () {
                      navigateToProductDetail(
                        context,
                        product: product,
                        allProducts: allProducts,
                      );
                      _ctrl.clear();
                    },
                  );
                }
                return const EmptyState(
                  message: 'ابدأ بالبحث لعرض المنتجات',
                  icon: Icons.search,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
