import 'package:comunidade_digital/shared_components/project_config.dart';
import 'package:comunidade_digital/shared_components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final initialValue;
  final readOnly;
  final backgroundColor;
  final textColor;
  final iconColor;
  final inputFormatters;
  final controller;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.initialValue,
    this.readOnly = false,
    this.backgroundColor = primaryLightColor,
    this.textColor = Colors.white,
    this.iconColor = iconColors,
    this.inputFormatters = null,
    this.controller = null
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: this.controller,
        inputFormatters: this.inputFormatters != null ? [this.inputFormatters] : [],
        onChanged: onChanged,
        initialValue: initialValue,
        readOnly: this.readOnly ? readOnly : false,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: this.iconColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
      backgroundColor: this.backgroundColor,
    );
  }
}