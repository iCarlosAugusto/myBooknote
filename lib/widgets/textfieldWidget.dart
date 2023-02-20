import 'package:flutter/material.dart';

class TextfieldWidget extends StatelessWidget {
  TextfieldWidget({super.key, this.controller, this.hintText, this.labelText, this.margin, this.validator, this.maxLength});

  TextEditingController? controller;
  String? hintText;
  String? labelText;
  EdgeInsets? margin;
  String? Function(String? value)? validator;
  int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: TextFormField(
        maxLength: maxLength,
        maxLines: null,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          labelText: labelText,
        ),
      ),
    );
  }
}
