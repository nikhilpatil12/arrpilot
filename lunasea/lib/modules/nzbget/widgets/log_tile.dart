import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/nzbget.dart';

class NZBGetLogTile extends StatelessWidget {
  final NZBGetLogData data;

  const NZBGetLogTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: data.text,
      body: [TextSpan(text: data.timestamp)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async =>
          ArrPilotDialogs().textPreview(context, 'Log Entry', data.text!),
    );
  }
}
