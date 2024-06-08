import 'package:flutter/material.dart';
import 'package:shoppingcart/utils/extensions/extensions.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/base/motion_button.dart';
import 'package:shoppingcart/widgets/widgets.dart';

class BaseScreen extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final bool isBack;
  final Widget body;
  const BaseScreen({
    this.title,
    this.actions,
    this.isBack = true,
    required this.body,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: ColorName.orange400,
          centerTitle: true,
          title: Text(title ?? '',
              style: AppStyle.medium(20).copyWith(color: Colors.white)),
          leadingWidth: context.appBarHeight,
          leading: !!isBack
              ? Row(
                  children: [
                    MotionButton(
                        onTap: () => context.pop(),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.appPadding),
                          height: 44,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.white,
                              )
                            ],
                          ),
                        )),
                  ],
                )
              : Container(),
          actions: actions),
      body: body,
    );
  }
}
