import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/models/models.dart';
import 'package:shoppingcart/pages/home/blocs/home_bloc.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/widgets.dart';

class HotProductList extends StatefulWidget {
  const HotProductList({super.key});

  @override
  State<HotProductList> createState() => _HotProductListState();
}

class _HotProductListState extends State<HotProductList> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          int takeCount = (state.products ?? []).length > 10
              ? 10
              : (state.products ?? []).length;
          return SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(context.appPadding),
                  child: Row(
                    children: [
                      Text(
                        'HOT Products',
                        style: AppStyle.bold(20)
                            .copyWith(color: ColorName.orange800),
                      ),
                      const SizedBox(width: 4),
                      Assets.icons.icFire.image(width: 16)
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeightItem(context),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: takeCount,
                    itemBuilder: (context, index) {
                      return Container(
                        key: ValueKey((state.products ?? [])[index].id),
                        width: getWidthItem(context),
                        margin: const EdgeInsets.only(left: 16),
                        child: ProductItem(
                            isHot: true,
                            product: (state.products ?? [])[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  getWidthItem(BuildContext context) {
    if (context.width < 600) {
      return (context.width - 48) / 2.5;
    } else {
      return 600 / 2.5;
    }
  }

  getHeightItem(BuildContext context) {
    return getWidthItem(context) / 0.8;
  }
}
