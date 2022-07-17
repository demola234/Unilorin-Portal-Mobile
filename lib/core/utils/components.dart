import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:probitas_app/core/constants/colors.dart';
import 'package:probitas_app/core/utils/config.dart';

class ProbitasButton extends StatelessWidget {
  ProbitasButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.showLoading,
  }) : super(key: key);

  final void Function() onTap;
  final String text;
  final bool? showLoading;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 72,
            width: context.screenWidth(),
            decoration: BoxDecoration(
                color: !isDarkMode ? Color(0xFF045257) : Color(0xFFD8ECEA),
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: showLoading != null && showLoading!
                ? Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                        // size: 30,
                      ),
                    ))
                : Align(
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
    );
  }
}

class ProbitasDeleteButton extends StatelessWidget {
  ProbitasDeleteButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.showLoading,
  }) : super(key: key);

  final void Function() onTap;
  final String text;
  final bool? showLoading;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 72,
            width: context.screenWidth(),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: showLoading != null && showLoading!
                ? Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                        // size: 30,
                      ),
                    ))
                : Align(
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
  final bool? readOnly;
  final void Function()? onTap;

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
      this.readOnly = false,
      this.onTap,
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
      readOnly: readOnly!,
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
      onTap: onTap,
    );
  }
}

class ProbitasDropDown extends StatelessWidget {
  final String? labelText;
  final String? initialValue;
  final Widget? textFieldIcon;
  final bool enableInteractiveSelection;
  final TextAlign textAlign;
  final String? hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextInputType? inputType;
  final String? Function(String? input)? validator;
  final Function(String?)? onChanged;
  final Function(String?)? onSaved;
  final Function()? onEditingComplete;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool enabled;
  final List<String> items;
  final String? value;

  const ProbitasDropDown(
      {Key? key,
      this.labelText,
      this.initialValue,
      this.textFieldIcon,
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
      required this.items,
      required this.value,
      this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DropdownButtonFormField<String>(
        isExpanded: true,
        validator: validator,
        onSaved: onSaved,
        style: Config.b2(context).copyWith(
          color: isDarkMode ? Colors.white : ProbitasColor.ProbitasPrimary,
        ),
        decoration: InputDecoration(
          fillColor: !isDarkMode
              ? ProbitasColor.ProbitasTextPrimary.withOpacity(0.3)
              : ProbitasColor.ProbitasAccent.withOpacity(0.3),
          filled: true,
          prefixIcon: prefixIcon,
          suffixIcon: textFieldIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          hintText: hintText,
          labelText: labelText,
          labelStyle: Config.b2(context).copyWith(),
          hintStyle: Config.b2(context).copyWith(),
        ),
        items: items
            .map((e) => DropdownMenuItem<String>(value: e, child: Text("$e")))
            .toList(),
        onChanged: onChanged,
        value: value);
  }
}
