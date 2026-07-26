import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.hintWidget,
    required this.isObsecure,
    required this.validator,
    required this.controller,
    this.prefixIcon,
  });
  final Widget hintWidget;
  final bool isObsecure;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final Widget? prefixIcon;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        hint: widget.hintWidget,
        suffixIcon: widget.isObsecure
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
              )
            : null,
      ),
      obscureText: widget.isObsecure ? _obscureText : false,
      validator: widget.validator,
    );
  }
}
