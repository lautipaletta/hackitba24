import 'package:alicia/core/config/style/colors.dart';
import 'package:flutter/material.dart';

class AliciaTextField extends StatefulWidget {
  const AliciaTextField({
    required this.controller,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.autoValidateMode,
    this.labelText,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final String? labelText;
  final AutovalidateMode? autoValidateMode;

  @override
  State<AliciaTextField> createState() => _AliciaTextFieldState();
}

class _AliciaTextFieldState extends State<AliciaTextField> {
  late bool obscureText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      style: Theme.of(context).textTheme.bodyMedium,
      autovalidateMode: widget.autoValidateMode,
      validator: widget.validator,
      cursorColor: AliciaColors.accentPurple,
      decoration: InputDecoration(
        filled: true,
        fillColor: AliciaColors.backgroundWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AliciaColors.darkText.withOpacity(0.4),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AliciaColors.deepPurple.withOpacity(0.8),
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: AliciaColors.red,
            width: 1.5,
          ),
        ),
        hintText: widget.hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: const Color(0xFFA1A4B2),
            ),
      ),
    );
  }
}
