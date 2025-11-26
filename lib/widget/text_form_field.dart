import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;
  final String type;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    required this.text,
    required this.type,
    this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    bool isPassword = widget.type.toLowerCase() == 'password';

    TextInputType keyboardType;
    switch (widget.type.toLowerCase()) {
      case 'email':
        keyboardType = TextInputType.emailAddress;
        break;
      case 'number':
        keyboardType = TextInputType.number;
        break;
      default:
        keyboardType = TextInputType.text;
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: keyboardType,
        obscureText: isPassword ? !_isPasswordVisible : false,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: const TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.5),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.white70,
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          )
              : null,
        ),
      ),
    );
  }
}
