import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotTableCard extends StatelessWidget {
  final String? title;
  final List<ArrPilotTableContent>? content;
  final List<ArrPilotButton>? buttons;

  const ArrPilotTableCard({
    Key? key,
    this.content,
    this.buttons,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotCard(
      context: context,
      child: Padding(
        child: _body(),
        padding: EdgeInsets.only(
          left: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
          right: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
          top: ArrPilotUI.DEFAULT_MARGIN_SIZE - ArrPilotUI.DEFAULT_MARGIN_SIZE / 4,
          bottom: buttons?.isEmpty ?? true
              ? ArrPilotUI.DEFAULT_MARGIN_SIZE - ArrPilotUI.DEFAULT_MARGIN_SIZE / 4
              : 0,
        ),
      ),
    );
  }

  Widget _body() {
    return Column(
      children: [
        if (title?.isNotEmpty ?? false) _title(),
        ..._content(),
        _buttons(),
      ],
    );
  }

  Widget _title() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: ArrPilotUI.DEFAULT_MARGIN_SIZE),
          child: ArrPilotText.title(text: title!),
        ),
      ],
    );
  }

  List<Widget> _content() {
    return content!
        .map((child) => Padding(
              child: child,
              padding: const EdgeInsets.symmetric(
                horizontal: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
              ),
            ))
        .toList();
  }

  Widget _buttons() {
    if (buttons == null) return Container(height: 0.0);
    return Padding(
      child: Row(
        children:
            buttons!.map<Widget>((button) => Expanded(child: button)).toList(),
      ),
      padding: const EdgeInsets.only(
        top: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2 - ArrPilotUI.DEFAULT_MARGIN_SIZE / 4,
        bottom: ArrPilotUI.DEFAULT_MARGIN_SIZE / 2,
      ),
    );
  }
}
