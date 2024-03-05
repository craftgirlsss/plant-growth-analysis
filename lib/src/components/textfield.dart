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

class CustomTextFieldNameBlack extends StatefulWidget {
  final TextEditingController? controller;
  final bool? readOnly;
  final Function()? onTap;
  final String? hinyText;
  final IconData? iconData;
  const CustomTextFieldNameBlack({super.key, this.controller, this.hinyText, this.readOnly, this.onTap, this.iconData});

  @override
  State<CustomTextFieldNameBlack> createState() => _CustomTextFieldNameBlackState();
}

class _CustomTextFieldNameBlackState extends State<CustomTextFieldNameBlack> {
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
          fillColor: Colors.black.withOpacity(0.1),
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

class CustomTextFieldNameBlackForDescription extends StatefulWidget {
  final TextEditingController? controller;
  final bool? readOnly;
  final Function()? onTap;
  final String? hinyText;
  final IconData? iconData;
  const CustomTextFieldNameBlackForDescription({super.key, this.controller, this.hinyText, this.readOnly, this.onTap, this.iconData});

  @override
  State<CustomTextFieldNameBlackForDescription> createState() => _CustomTextFieldNameBlackForDescriptionState();
}

class _CustomTextFieldNameBlackForDescriptionState extends State<CustomTextFieldNameBlackForDescription> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: TextFormField(
          controller: widget.controller,
          autofocus: false,
          readOnly: widget.readOnly ?? true,
          onTap: widget.readOnly == true ? widget.onTap : null,
          style: kDefaultTextStyle(color: Colors.black87, fontSize: 15),
          decoration: InputDecoration(
            hintMaxLines: 10,
            prefixIcon: Icon(widget.iconData, color: Colors.black54),
            fillColor: Colors.black.withOpacity(0.1),
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
        ),
    );
  }
}