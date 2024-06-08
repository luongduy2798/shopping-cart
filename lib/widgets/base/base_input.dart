import 'package:flutter/material.dart';
import 'package:shoppingcart/utils/gen/gen.dart';
import 'package:shoppingcart/utils/styles/styles.dart';

class BaseInput extends StatelessWidget {
  const BaseInput(
      {super.key,
      this.controller,
      this.onChanged,
      this.focusNode,
      this.keyboardType = TextInputType.text,
      this.validator});

  final TextEditingController? controller;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        focusNode: focusNode,
        onChanged: onChanged,
        style: AppStyle.bold(),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: ColorName.orange600),
          ),
        ),
        cursorColor: ColorName.orange600,
        validator: validator);
  }
}
