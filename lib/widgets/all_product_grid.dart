import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/injection/di.dart';
import 'package:shoppingcart/pages/home/blocs/home_bloc.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/widgets.dart';

class AllProductGrid extends StatefulWidget {
  const AllProductGrid({super.key});
  @override
  State<AllProductGrid> createState() => _AllProductGridState();
}

class _AllProductGridState extends State<AllProductGrid> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = getIt<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: EdgeInsets.all(context.appPadding),
                  child: Text(
                    'All Products',
                    style:
                        AppStyle.bold(20).copyWith(color: ColorName.orange800),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.appPadding),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _calculateCrossAxisCount(context.width),
                        mainAxisSpacing: 12.0,
                        crossAxisSpacing: 16.0,
                        childAspectRatio: 0.8),
                    itemCount: (state.products ?? []).length,
                    itemBuilder: (context, index) {
                      return ProductItem(
                          key: ValueKey((state.products ?? [])[index].id),
                          product: (state.products ?? [])[index]);
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  static int _calculateCrossAxisCount(double width) {
    if (width < 600) {
      return 2;
    } else {
      return (width / 300).round();
    }
  }
}
