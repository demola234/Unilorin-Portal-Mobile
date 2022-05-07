import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';

class ProbitasButton extends StatelessWidget {
  const ProbitasButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final void Function() onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60.0),
        child: Container(
          child: InkWell(
            onTap: onTap,
            child: Container(
              height: 72,
              width: context.screenWidth(),
              decoration: BoxDecoration(
                  color: !isDarkMode ? Color(0xFF045257) : Color(0xFFD8ECEA),
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: Config.h3(context).copyWith(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                      color:
                          !isDarkMode ? Color(0xFFE3D6C5) : Color(0xFF1A1A2A),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class ProbitasTextFormField extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final Widget? suffixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String input)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final bool enabled;
  

  const ProbitasTextFormField(
      {Key? key,
      this.labelText,
      this.initialValue,
      this.suffixIcon,
      this.inputType,
      this.onChanged,
      this.onEditingComplete,
      this.onSaved,
      this.validator,
      this.inputFormatters,
      this.maxLines = 1,
      this.focusNode,
      this.textAlign = TextAlign.start,
      this.obscureText = false,
      this.enableInteractiveSelection = true,
      this.hintText,
      this.prefixIcon,
      this.controller,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      onEditingComplete: onEditingComplete,
      obscureText: obscureText!,
      enableInteractiveSelection: enableInteractiveSelection,
      maxLines: maxLines,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      initialValue: initialValue,
      keyboardType: inputType,
      textAlign: textAlign,
      enabled: enabled,
      decoration: InputDecoration(
          fillColor: !isDarkMode
              ? ProbitasColor.ProbitasTextPrimary.withOpacity(0.3)
              : ProbitasColor.ProbitasAccent.withOpacity(0.3),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: labelText,
          hintText: hintText,
          hintStyle: Config.b2(context).copyWith()),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
