import 'package:consumer_prices_app/Features/home/presentation/view_model/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Function/limited_title.dart';
import '../../../../Core/utils/styles.dart';
import '../../data/models/agent/agent_model.dart';
import 'widgets/agent_products_list_view.dart';

class AgentProductsScreen extends StatelessWidget {
  final AgentModel agent;

  const AgentProductsScreen({super.key, required this.agent});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (ctx, state) {
        final cubit = ctx.read<HomeCubit>();
        final products = cubit.productsByAgent(agent.id);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              limitedTitle(agent.name, 3),
              overflow: TextOverflow.ellipsis,
            ),
            centerTitle: true,
          ),
          body: products.isEmpty
              ? Center(
                  child: Text(
                    'لا توجد منتجات لهذا الوكيل',
                    style: Styles.textStyle18(context),
                  ),
                )
              : AgentProductsListView(
                  products: products,
                  allProducts: cubit.cachedAllProducts ?? []),
        );
      },
    );
  }
}

