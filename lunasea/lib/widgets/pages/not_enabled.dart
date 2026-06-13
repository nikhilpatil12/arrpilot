import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class NotEnabledPage extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final String module;

  NotEnabledPage({
    Key? key,
    required this.module,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: ArrPilotAppBar(title: module),
      body: ArrPilotMessage.moduleNotEnabled(
        context: context,
        module: module,
      ),
    );
  }
}
