import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arrpilot/core.dart';

// ignore: avoid_classes_with_only_static_members
abstract class ArrPilotDialog {
  static const HEADER_SIZE = ArrPilotUI.FONT_SIZE_H1;
  static const BODY_SIZE = ArrPilotUI.FONT_SIZE_H3;
  static const BUTTON_SIZE = ArrPilotUI.FONT_SIZE_H4;

  static Widget title({
    required String text,
  }) =>
      Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: ArrPilotDialog.HEADER_SIZE,
          fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
        ),
      );

  static TextSpan bolded({
    required String text,
    double fontSize = ArrPilotDialog.BODY_SIZE,
    Color? color,
  }) =>
      TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? ArrPilotColours.accent,
          fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
          fontSize: fontSize,
        ),
      );

  static Widget richText({
    required List<TextSpan>? children,
    TextAlign alignment = TextAlign.start,
  }) =>
      RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: ArrPilotDialog.BODY_SIZE,
          ),
          children: children,
        ),
        textAlign: alignment,
      );

  static Widget button({
    required String text,
    required void Function() onPressed,
    Color? textColor,
  }) =>
      TextButton(
        child: Text(
          text,
          style: TextStyle(
            color: textColor ?? ArrPilotColours.accent,
            fontSize: ArrPilotDialog.BUTTON_SIZE,
          ),
        ),
        onPressed: () async {
          HapticFeedback.lightImpact();
          onPressed();
        },
      );

  static Widget cancel(
    BuildContext context, {
    Color textColor = Colors.white,
    String? text,
  }) =>
      TextButton(
        child: Text(
          text ?? 'arrpilot.Cancel'.tr(),
          style: TextStyle(
            color: textColor,
            fontSize: ArrPilotDialog.BUTTON_SIZE,
          ),
        ),
        onPressed: () {
          HapticFeedback.lightImpact();
          Navigator.of(context).pop();
        },
      );

  static Widget content({
    required List<Widget> children,
  }) =>
      SingleChildScrollView(
        child: ListBody(
          children: children,
        ),
        padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 1.0),
      );

  static Widget textContent({
    required String text,
    TextAlign textAlign = TextAlign.center,
  }) =>
      Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: ArrPilotDialog.BODY_SIZE,
        ),
        textAlign: textAlign,
      );

  static TextSpan textSpanContent({
    required String text,
  }) =>
      TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: ArrPilotDialog.BODY_SIZE,
        ),
      );

  static Widget textInput({
    required TextEditingController controller,
    required void Function(String)? onSubmitted,
    required String title,
  }) =>
      TextField(
        autofocus: true,
        autocorrect: false,
        controller: controller,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(
            color: ArrPilotColours.grey,
            decoration: TextDecoration.none,
            fontSize: ArrPilotDialog.BODY_SIZE,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ArrPilotColours.accent),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: ArrPilotColours.accent.withOpacity(ArrPilotUI.OPACITY_SPLASH)),
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: ArrPilotDialog.BODY_SIZE,
        ),
        cursorColor: ArrPilotColours.accent,
        textInputAction: TextInputAction.done,
        onSubmitted: onSubmitted,
      );

  static Widget textFormInput({
    required TextEditingController controller,
    required String title,
    required ValueChanged<String>? onSubmitted,
    required FormFieldValidator<String>? validator,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) =>
      TextFormField(
        autofocus: true,
        autocorrect: false,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: title,
          labelStyle: const TextStyle(
            color: ArrPilotColours.grey,
            decoration: TextDecoration.none,
            fontSize: ArrPilotDialog.BODY_SIZE,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: ArrPilotColours.accent),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: ArrPilotColours.accent.withOpacity(ArrPilotUI.OPACITY_SPLASH)),
          ),
        ),
        style: const TextStyle(
          color: Colors.white,
          fontSize: ArrPilotDialog.BODY_SIZE,
        ),
        cursorColor: ArrPilotColours.accent,
        textInputAction: TextInputAction.done,
        validator: validator,
        onFieldSubmitted: onSubmitted,
      );

  static Widget tile({
    required IconData? icon,
    Color? iconColor,
    required String text,
    RichText? subtitle,
    Function? onTap,
  }) =>
      ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon ?? Icons.error_outline_rounded,
              color: iconColor ?? ArrPilotColours.accent,
            ),
          ],
        ),
        title: Text(
          text,
          style: const TextStyle(
            fontSize: ArrPilotDialog.BODY_SIZE,
            color: Colors.white,
          ),
        ),
        subtitle: subtitle,
        onTap: onTap == null
            ? null
            : () async {
                HapticFeedback.selectionClick();
                onTap();
              },
        contentPadding: tileContentPadding(),
      );

  static CheckboxListTile checkbox({
    required String title,
    required bool? value,
    required void Function(bool?) onChanged,
  }) =>
      CheckboxListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontSize: BODY_SIZE,
            color: Colors.white,
          ),
        ),
        value: value,
        onChanged: onChanged,
        contentPadding: tileContentPadding(),
      );

  static EdgeInsets tileContentPadding() =>
      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 0.0);
  static EdgeInsets textDialogContentPadding() =>
      const EdgeInsets.fromLTRB(24.0, 32.0, 24.0, 14.0);
  static EdgeInsets listDialogContentPadding() =>
      const EdgeInsets.fromLTRB(0.0, 26.0, 0.0, 0.0);
  static EdgeInsets inputTextDialogContentPadding() =>
      const EdgeInsets.fromLTRB(24.0, 34.0, 24.0, 22.0);
  static EdgeInsets inputDialogContentPadding() =>
      const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 22.0);

  static Future<void> dialog({
    required BuildContext context,
    required String? title,
    required EdgeInsets contentPadding,
    bool showCancelButton = true,
    String? cancelButtonText,
    List<Widget>? buttons,
    List<Widget>? content,
    Widget? customContent,
  }) async {
    if (customContent == null)
      assert(content != null, 'customContent and content both cannot be null');
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: <Widget>[
          if (showCancelButton)
            ArrPilotDialog.cancel(
              context,
              text: cancelButtonText,
              textColor: buttons != null ? Colors.white : ArrPilotColours.accent,
            ),
          if (buttons != null) ...buttons,
        ],
        title: ArrPilotDialog.title(text: title!),
        content: customContent ?? ArrPilotDialog.content(children: content!),
        contentPadding: contentPadding,
        shape: ArrPilotUI.shapeBorder,
      ),
    );
  }
}
