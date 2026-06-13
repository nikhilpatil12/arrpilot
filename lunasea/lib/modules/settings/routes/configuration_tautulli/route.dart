import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';
import 'package:arrpilot/router/routes/settings.dart';

class ConfigurationTautulliRoute extends StatefulWidget {
  const ConfigurationTautulliRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationTautulliRoute> createState() => _State();
}

class _State extends State<ConfigurationTautulliRoute>
    with ArrPilotScrollControllerMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ArrPilotScaffold(
      scaffoldKey: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _appBar() {
    return ArrPilotAppBar(
      title: ArrPilotModule.TAUTULLI.title,
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ArrPilotModule.TAUTULLI.informationBanner(),
        _enabledToggle(),
        _connectionDetailsPage(),
        ArrPilotDivider(),
        _activityRefreshRate(),
        _defaultPagesPage(),
        _defaultTerminationMessage(),
        _statisticsItemCount(),
      ],
    );
  }

  Widget _enabledToggle() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.EnableModule'.tr(args: [ArrPilotModule.TAUTULLI.title]),
        trailing: ArrPilotSwitch(
          value: ArrPilotProfile.current.tautulliEnabled,
          onChanged: (value) {
            ArrPilotProfile.current.tautulliEnabled = value;
            ArrPilotProfile.current.save();
            context.read<TautulliState>().reset();
          },
        ),
      ),
    );
  }

  Widget _connectionDetailsPage() {
    return ArrPilotBlock(
      title: 'settings.ConnectionDetails'.tr(),
      body: [
        TextSpan(
          text: 'settings.ConnectionDetailsDescription'.tr(
            args: [ArrPilotModule.TAUTULLI.title],
          ),
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_TAUTULLI_CONNECTION_DETAILS.go,
    );
  }

  Widget _defaultPagesPage() {
    return ArrPilotBlock(
      title: 'settings.DefaultPages'.tr(),
      body: [TextSpan(text: 'settings.DefaultPagesDescription'.tr())],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: SettingsRoutes.CONFIGURATION_TAUTULLI_DEFAULT_PAGES.go,
    );
  }

  Widget _defaultTerminationMessage() {
    const _db = TautulliDatabase.TERMINATION_MESSAGE;
    return _db.listenableBuilder(
      builder: (context, _) {
        String message = _db.read();
        return ArrPilotBlock(
          title: 'tautulli.DefaultTerminationMessage'.tr(),
          body: [
            TextSpan(text: message.isEmpty ? 'lunasea.NotSet'.tr() : message),
          ],
          trailing: const ArrPilotIconButton(icon: Icons.videocam_off_rounded),
          onTap: () async {
            Tuple2<bool, String> result =
                await TautulliDialogs.setTerminationMessage(context);
            if (result.item1) _db.update(result.item2);
          },
        );
      },
    );
  }

  Widget _activityRefreshRate() {
    const _db = TautulliDatabase.REFRESH_RATE;
    return _db.listenableBuilder(builder: (context, _) {
      String refreshRate = _db.read() == 1
          ? 'lunasea.EverySecond'.tr()
          : 'lunasea.EverySeconds'.tr(args: [_db.read().toString()]);
      return ArrPilotBlock(
        title: 'tautulli.ActivityRefreshRate'.tr(),
        body: [TextSpan(text: refreshRate)],
        trailing: const ArrPilotIconButton(icon: ArrPilotIcons.REFRESH),
        onTap: () async {
          List<dynamic> _values = await TautulliDialogs.setRefreshRate(context);
          if (_values[0]) _db.update(_values[1]);
        },
      );
    });
  }

  Widget _statisticsItemCount() {
    const _db = TautulliDatabase.STATISTICS_STATS_COUNT;
    return _db.listenableBuilder(
      builder: (context, _) {
        String statisticsItems = _db.read() == 1
            ? 'lunasea.OneItem'.tr()
            : 'lunasea.Items'.tr(args: [_db.read().toString()]);
        return ArrPilotBlock(
          title: 'tautulli.StatisticsItemCount'.tr(),
          body: [TextSpan(text: statisticsItems)],
          trailing: const ArrPilotIconButton(icon: Icons.format_list_numbered),
          onTap: () async {
            List<dynamic> _values =
                await TautulliDialogs.setStatisticsItemCount(context);
            if (_values[0]) _db.update(_values[1]);
          },
        );
      },
    );
  }
}
