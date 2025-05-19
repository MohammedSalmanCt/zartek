import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zartek_machine/core/common/global_variables.dart';
import 'package:zartek_machine/core/theme/pallete.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? errorText;
  final TextInputType keyboardType;
  final bool? readOnly;
  final bool? obscureText;
  final int maxLines;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingCompleted;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.readOnly,
    this.maxLines = 1,
    this.focusNode,
    this.onChanged,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.errorText,
    this.inputFormatters,
    this.validator,
    this.onFieldSubmitted,
    this.onEditingCompleted,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (focusNode != null) {
      focusNode!.addListener(() {
        if (focusNode!.hasFocus) {
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        }
      });
    }

    return Builder(
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(w * 0.03),
          ),
          height: h * 0.06 * maxLines,
          width: width * (0.9),
          child: TextFormField(
            obscureText: obscureText ?? false,
            focusNode: focusNode,
            controller: controller,
            readOnly: readOnly ?? false,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: keyboardType,
            maxLines: maxLines,
            inputFormatters: inputFormatters,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            onEditingComplete: onEditingCompleted,
            validator: validator,
            decoration: InputDecoration(
              // floatingLabelBehavior: FloatingLabelBehavior.always,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.03),
                borderSide: BorderSide(
                  color: AppColors.blackColour,
                  width: w * 0.001,
                ),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.04),
                borderSide: BorderSide(
                  color: AppColors.blackColour,
                  width: w * 0.001,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.04),
                borderSide: BorderSide(
                  color: AppColors.blackColour,
                  width: w * 0.001,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.04),
                borderSide: BorderSide(
                  color: AppColors.blackColour,
                  width: w * 0.001,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.04),
                borderSide: BorderSide(
                  color: AppColors.blackColour,
                  width: w * 0.001,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.04),
                borderSide: BorderSide(
                  color: AppColors.blackColour,
                  width: w * 0.001,
                ),
              ),
              labelText: labelText,
              errorText: controller.text.isEmpty ? errorText : null,
              alignLabelWithHint: true,
              labelStyle: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: w * 0.04,
                color: AppColors.blackColour,
              ),
            ),
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: w * 0.04,
              color: AppColors.blackColour,
            ),
          ),
        );
      },
    );
  }
}
