import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/extensions/string/links.dart';

enum _Type {
  CONTENT,
  SPACER,
}

class ArrPilotTableContent extends StatelessWidget {
  final String? title;
  final String? body;
  final String? url;
  final bool bodyIsUrl;
  final int titleFlex;
  final int bodyFlex;
  final double spacerSize;
  final TextAlign titleAlign;
  final TextAlign bodyAlign;
  final _Type type;

  const ArrPilotTableContent._({
    Key? key,
    this.title,
    this.body,
    this.url,
    this.bodyIsUrl = false,
    this.titleAlign = TextAlign.end,
    this.bodyAlign = TextAlign.start,
    this.titleFlex = 5,
    this.bodyFlex = 10,
    this.spacerSize = ArrPilotUI.DEFAULT_MARGIN_SIZE,
    required this.type,
  });

  factory ArrPilotTableContent.spacer({
    Key? key,
    double spacerSize = ArrPilotUI.DEFAULT_MARGIN_SIZE,
  }) =>
      ArrPilotTableContent._(
        key: key,
        type: _Type.SPACER,
        spacerSize: spacerSize,
      );

  factory ArrPilotTableContent({
    Key? key,
    String? title,
    required String? body,
    String? url,
    bool bodyIsUrl = false,
    TextAlign titleAlign = TextAlign.end,
    TextAlign bodyAlign = TextAlign.start,
    int titleFlex = 1,
    int bodyFlex = 2,
  }) =>
      ArrPilotTableContent._(
        key: key,
        title: title,
        body: body,
        url: url,
        bodyIsUrl: bodyIsUrl,
        titleAlign: titleAlign,
        bodyAlign: bodyAlign,
        titleFlex: titleFlex,
        bodyFlex: bodyFlex,
        type: _Type.CONTENT,
      );

  @override
  Widget build(BuildContext context) {
    if (type == _Type.SPACER) return SizedBox(height: spacerSize);
    return Row(
      children: [
        if (title != null) _title(),
        _subtitle(),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  Widget _title() {
    return Expanded(
      child: Padding(
        child: Text(
          title?.toUpperCase() ?? ArrPilotUI.TEXT_EMDASH,
          textAlign: titleAlign,
          style: const TextStyle(
            color: ArrPilotColours.grey,
            fontSize: ArrPilotUI.FONT_SIZE_H3,
          ),
        ),
        padding: const EdgeInsets.only(
          top: ArrPilotUI.DEFAULT_MARGIN_SIZE / 4,
          bottom: ArrPilotUI.DEFAULT_MARGIN_SIZE / 4,
          right: ArrPilotUI.DEFAULT_MARGIN_SIZE / 4,
        ),
      ),
      flex: titleFlex,
    );
  }

  Widget _subtitle() {
    return Expanded(
      child: InkWell(
        child: Padding(
          child: Text(
            body ?? ArrPilotUI.TEXT_EMDASH,
            textAlign: bodyAlign,
            style: const TextStyle(
              color: ArrPilotColours.white,
              fontSize: ArrPilotUI.FONT_SIZE_H3,
            ),
          ),
          padding: const EdgeInsets.only(
            top: ArrPilotUI.DEFAULT_MARGIN_SIZE / 4,
            bottom: ArrPilotUI.DEFAULT_MARGIN_SIZE / 4,
            left: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
          ),
        ),
        borderRadius: BorderRadius.circular(ArrPilotUI.BORDER_RADIUS),
        onTap: _onTap(),
        onLongPress: _onLongPress(),
      ),
      flex: bodyFlex,
    );
  }

  void Function()? _onTap() {
    final sanitizedUrl = url ?? '';
    if (sanitizedUrl.isEmpty && !bodyIsUrl) return null;
    if (sanitizedUrl.isNotEmpty) return sanitizedUrl.openLink;
    return body!.openLink;
  }

  void Function()? _onLongPress() {
    final sanitizedUrl = url ?? '';
    if (sanitizedUrl.isEmpty && !bodyIsUrl) return null;
    if (sanitizedUrl.isNotEmpty) return sanitizedUrl.copyToClipboard;
    return body!.copyToClipboard;
  }
}
