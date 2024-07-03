import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JustPlayTextForm extends StatelessWidget {
  const JustPlayTextForm({
    super.key,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.inputFormatters,
    this.validator,
    this.errorText,
    this.onChanged,
    this.autovalidateMode,
    this.obscureText = false,
  });
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? errorText;
  final Function(String?)? onChanged;
  final bool obscureText;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(7).copyWith(left: 30),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30)),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        obscureText: obscureText,
        keyboardType: keyboardType,
        controller: controller,
        onChanged: onChanged,
        inputFormatters: inputFormatters,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          errorStyle: const TextStyle(fontSize: 9, height: 0.3),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
          errorText: errorText,
        ),
      ),
    );
  }
}
