import 'package:flutter/material.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';
import 'package:shoppingcart/widgets/base/base.dart';

class BaseButton extends StatelessWidget {
  final String? title;
  final Function? onSubmit;
  final Color? backgroundColor;
  final double height;
  final double? width;
  final TextStyle? titleStyle;
  final bool isDisable;
  const BaseButton(
      {super.key,
      this.backgroundColor,
      this.title,
      this.onSubmit,
      this.height = 48,
      this.width,
      this.titleStyle,
      this.isDisable = false});

  @override
  Widget build(BuildContext context) {
    return MotionButton(
      scale: 0.9,
      onTap: () {
        if (onSubmit != null && !isDisable) {
          onSubmit!();
        }
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: !isDisable
              ? (backgroundColor ?? ColorName.orange600)
              : ColorName.gray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(title ?? '',
              style:
                  titleStyle ?? AppStyle.bold().copyWith(color: Colors.white)),
        ),
      ),
    );
  }
}
