import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final void Function()? _onPressedCallBack;
  final String _buttonText;
  final double? _buttonWidth;

  FormButton(
      {required void Function()? onPressedCallBack,
      required String buttonText,
      double? buttonWidth})
      : _onPressedCallBack = onPressedCallBack,
        _buttonText = buttonText,
        _buttonWidth = buttonWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _buttonWidth,
      child: ElevatedButton(
        onPressed: _onPressedCallBack,
        style: ElevatedButton.styleFrom(
            elevation: 3,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              _buttonText,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )),
      ),
    );
  }
}
