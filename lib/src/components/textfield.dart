import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plant_growth/src/components/textstyle.dart';

class CustomTextFieldName extends StatefulWidget {
  final TextEditingController? controller;
  final bool? readOnly;
  final Function()? onTap;
  final String? hinyText;
  final IconData? iconData;
  const CustomTextFieldName({super.key, this.controller, this.hinyText, this.readOnly, this.onTap, this.iconData});

  @override
  State<CustomTextFieldName> createState() => _CustomTextFieldNameState();
}

class _CustomTextFieldNameState extends State<CustomTextFieldName> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: widget.controller,
        autofocus: false,
        readOnly: widget.readOnly ?? true,
        onTap: widget.readOnly == true ? widget.onTap : null,
        style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: Icon(widget.iconData, color: Colors.black54),
          fillColor: Colors.white.withOpacity(0.8),
          filled: true,
          hintStyle: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          hintText: widget.hinyText ?? 'Unknown',
          suffixIconColor: Colors.black54,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                32.0,
              )),
        ),
      );
  }
}