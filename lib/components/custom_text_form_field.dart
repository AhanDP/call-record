import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validation;
  final bool? isAutoFocus;
  final TextInputType? keyboardType;
  final Function()? onTap;
  final Function(String)? onChanged;
  final bool? readOnly;
  final IconData? prefixIcon;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.validation,
      this.isAutoFocus,
      this.keyboardType,
      this.onTap,
      this.readOnly,
      this.onChanged,
      this.prefixIcon});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool hasFocus = false;

  @override
  void initState() {
    _focusNode.addListener(() {
      setState(() {
        hasFocus = _focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onTap: widget.onTap,
        onChanged: widget.onChanged,
        readOnly: widget.readOnly ?? false,
        focusNode: _focusNode,
        autofocus: widget.isAutoFocus ?? false,
        keyboardType: widget.keyboardType,
        cursorColor: Colors.blue,
        textAlignVertical: TextAlignVertical.center,
        style: (widget.keyboardType == TextInputType.number)
            ? const TextStyle(
                fontSize: 18,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w500,
                height: 1)
            : const TextStyle(
                fontSize: 18,
                letterSpacing: 0,
                fontWeight: FontWeight.w500,
                height: 1.5),
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
            labelText: widget.hintText,
            filled: true,
            fillColor: hasFocus
                ? Colors.blue.withValues(alpha: 0.1)
                : Colors.grey.shade50,
            isDense: true,
            floatingLabelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: hasFocus
                    ? Colors.blue
                    : Colors.grey.shade500),
            labelStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.grey.shade500),
            counterText: "",
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                  color: hasFocus
                      ? Colors.blue.withValues(alpha: 0.2)
                      : Colors.grey.shade100,
                  width: 2),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide(
                  color: hasFocus
                      ? Colors.blue.withValues(alpha: 0.2)
                      : Colors.grey.shade100,
                  width: 2),
            )),
        validator: widget.validation);
  }
}
