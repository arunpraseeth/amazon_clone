import 'package:flutter/material.dart';

class CustomTextField {
  static Widget customTextField({
    required Size size,
    required TextEditingController controller,
    int? maxLength,
    TextInputType? textInputType,
    String? hintText,
    double? textSpacing,
    String? prefixText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool? readOnly,
    FocusNode? focusnode,
    int? maxlines,
    String? Function(String? value)? validator,
  }) {
    return SizedBox(
      width: size.width / 1.1,
      child: TextFormField(
        focusNode: focusnode,
        readOnly: readOnly ?? false,
        controller: controller,
        maxLength: maxLength,
        maxLines: maxlines,
        validator: validator,
        keyboardType: textInputType,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: textSpacing,
          decoration: TextDecoration.none,
        ),
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Colors.black26,
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          counterText: "",
          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          prefixStyle: const TextStyle(fontSize: 18),
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            // borderSide: const BorderSide(color: strokeColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
