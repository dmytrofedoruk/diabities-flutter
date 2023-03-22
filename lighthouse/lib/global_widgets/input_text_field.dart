import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  final String? label;
  final Widget? trailingLabel;
  final bool isRequired;
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;
  final InputDecoration? decoration;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? enabled;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final void Function()? onTap;
  const InputTextField({
    Key? key,
    this.label,
    this.trailingLabel,
    this.isRequired = false,
    this.initialValue,
    this.onSaved,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.decoration,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.enabled,
    this.maxLength,
    this.cursorColor,
    this.textInputAction,
    this.textInputFormatter,
    this.onTap,
  }) : super(key: key);

  Widget buildInputLine() {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      initialValue: initialValue,
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: decoration,
      onSaved: onSaved,
      keyboardType: keyboardType,
      maxLines: maxLines,
      minLines: minLines,
      enabled: enabled,
      maxLength: maxLength,
      inputFormatters: textInputFormatter,
      cursorColor: cursorColor,
      textInputAction: textInputAction,
    );
  }

  Widget buildInput() {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        initialValue: initialValue,
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: decoration,
        keyboardType: keyboardType,
        inputFormatters: textInputFormatter,
        enabled: enabled,
        maxLength: maxLength,
        cursorColor: cursorColor,
        textInputAction: textInputAction,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget input = maxLines != null || minLines != null ? buildInputLine() : buildInput();
    if (label?.isNotEmpty == true || trailingLabel != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelInput(title: label ?? '', isRequired: isRequired, trailing: trailingLabel),
          input,
        ],
      );
    }
    return input;
  }
}

class LabelInput extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool isLarge;
  final bool isRequired;

  const LabelInput({
    Key? key,
    required this.title,
    this.trailing,
    this.padding,
    this.isLarge = false,
    this.isRequired = false,
  }) : super(key: key);

  Widget buildContent({
    required String value,
    bool requiredValue = false,
    TextStyle? style,
    required Color colorRequired,
  }) {
    Widget text = RichText(
      text: TextSpan(
        text: value,
        children: [
          if (requiredValue) ...[TextSpan(text: ' *', style: TextStyle(color: colorRequired))]
        ],
        style: style,
      ),
    );
    if (trailing != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Flexible(child: text), const SizedBox(width: 16), trailing ?? Container()],
      );
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    if (isLarge) {
      return Padding(
        padding: padding ?? const EdgeInsets.only(bottom: 10),
        child: buildContent(
          value: title,
          requiredValue: isRequired,
          style: theme.textTheme.subtitle2,
          colorRequired: theme.colorScheme.error,
        ),
      );
    }
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 4),
      child: buildContent(
        value: title,
        requiredValue: isRequired,
        style: theme.textTheme.caption,
        colorRequired: theme.colorScheme.error,
      ),
    );
  }
}

class LabelView extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;
  final bool isLarge;
  final bool isRequired;
  final Widget child;
  const LabelView({
    Key? key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding,
    this.isLarge = true,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelInput(
          title: title,
          trailing: trailing,
          isLarge: isLarge,
          isRequired: isRequired,
          padding: const EdgeInsets.only(bottom: 19),
        ),
        child,
      ],
    );
  }
}
