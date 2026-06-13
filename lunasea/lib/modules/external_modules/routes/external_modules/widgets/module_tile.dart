import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/models/external_module.dart';
import 'package:arrpilot/extensions/string/links.dart';

class ExternalModulesModuleTile extends StatelessWidget {
  final ArrPilotExternalModule? module;

  const ExternalModulesModuleTile({
    Key? key,
    required this.module,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: module!.displayName,
      body: [TextSpan(text: module!.host)],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: module!.host.openLink,
    );
  }
}
