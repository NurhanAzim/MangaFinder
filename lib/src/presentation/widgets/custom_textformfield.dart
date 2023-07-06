import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.isSuffix,
    required this.icon,
    required this.controller,
    this.hideText,
    this.validator,
    this.onChange,
    this.onSubmit,
    this.keyboardType = TextInputType.text,
  });

  final String hintText;
  final bool isSuffix;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool? hideText;
  final void Function(String)? onChange;
  final void Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textCapitalization: TextCapitalization.sentences,
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(style: BorderStyle.none),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.3.h),
        hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade600,
            ),
        suffixIcon: (isSuffix)
            ? Icon(
                icon,
                size: 20.sp,
                color: Colors.grey.shade400,
              )
            : null,
        prefixIcon: (!isSuffix)
            ? Icon(
                icon,
                size: 20.sp,
                color: Colors.grey.shade400,
              )
            : null,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
    );
  }
}
