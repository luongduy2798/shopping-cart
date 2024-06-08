import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';

class BasePullRefresh extends StatefulWidget {
  final Function()? onRefresh;
  final Function()? onLoading;
  final Widget child;
  final RefreshController controller;
  const BasePullRefresh(
      {super.key,
      this.onRefresh,
      this.onLoading,
      required this.child,
      required this.controller});

  @override
  State<BasePullRefresh> createState() => _BasePullRefreshState();
}

class _BasePullRefreshState extends State<BasePullRefresh> {
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
        controller: widget.controller,
        onRefresh: widget.onRefresh,
        onLoading: widget.onLoading,
        header: CustomHeader(
          builder: (BuildContext context, RefreshStatus? mode) {
            return Container();
          },
        ),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus? mode) {
            return mode == LoadStatus.loading
                ? Center(
                    child: LoadingAnimationWidget.prograssiveDots(
                      color: ColorName.orange600,
                      size: 50,
                    ),
                  )
                : Container();
          },
        ),
        enablePullDown: true,
        enablePullUp: true,
        child: widget.child);
  }
}
