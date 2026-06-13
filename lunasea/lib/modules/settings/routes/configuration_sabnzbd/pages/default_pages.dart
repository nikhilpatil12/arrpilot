import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/tables/sabnzbd.dart';
import 'package:arrpilot/modules/sabnzbd.dart';

class ConfigurationSABnzbdDefaultPagesRoute extends StatefulWidget {
  const ConfigurationSABnzbdDefaultPagesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationSABnzbdDefaultPagesRoute> createState() => _State();
}

class _State extends State<ConfigurationSABnzbdDefaultPagesRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar() as PreferredSizeWidget?,
      body: _body(),
    );
  }

  Widget _appBar() {
    return ArrPilotAppBar(
      title: 'settings.DefaultPages'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        _homePage(),
      ],
    );
  }

  Widget _homePage() {
    const _db = SABnzbdDatabase.NAVIGATION_INDEX;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'lunasea.Home'.tr(),
        body: [TextSpan(text: SABnzbdNavigationBar.titles[_db.read()])],
        trailing: ArrPilotIconButton(icon: SABnzbdNavigationBar.icons[_db.read()]),
        onTap: () async {
          List values = await SABnzbdDialogs.defaultPage(context);
          if (values[0]) _db.update(values[1]);
        },
      ),
    );
  }
}
