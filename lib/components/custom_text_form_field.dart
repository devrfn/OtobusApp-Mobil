import 'package:flutter/material.dart';
import 'package:otobus_app/tools/validation/validation_rule.dart';
import 'package:otobus_app/tools/validation/validator.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  List<ValidationRule>? _validationRules = [];
  TextEditingController _controller;
  TextInputType? _textInputType;
  String? _labelText;
  bool _obscureText;
  void Function(String)? _onChanged;

  CustomTextFormField(
      {required TextEditingController controller,
      TextInputType? keyboardTye,
      String? labelText,
      List<ValidationRule>? validationRules,
      void Function(String)? onChanged,
      bool obscureText = false})
      : _controller = controller,
        _textInputType = keyboardTye,
        _labelText = labelText,
        _validationRules = validationRules,
        _obscureText = obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (String value) {
        if(_onChanged != null) {
          _onChanged!(value);
        }
      },
      controller: _controller,
      keyboardType: _textInputType,
      obscureText: _obscureText,
      decoration: InputDecoration(
          labelText: _labelText,
          filled: true,
          fillColor: Colors.white30,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
      validator: (String? input) {
        return Validator.run(input, _validationRules);
      },
    );
  }
}
