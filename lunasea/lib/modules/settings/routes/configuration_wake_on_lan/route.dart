import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/settings.dart';

class ConfigurationWakeOnLANRoute extends StatefulWidget {
  const ConfigurationWakeOnLANRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ConfigurationWakeOnLANRoute> createState() => _State();
}

class _State extends State<ConfigurationWakeOnLANRoute>
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
      scrollControllers: [scrollController],
      title: ArrPilotModule.WAKE_ON_LAN.title,
    );
  }

  Widget _body() {
    return ArrPilotBox.profiles.listenableBuilder(
      builder: (context, _) => ArrPilotListView(
        controller: scrollController,
        children: [
          ArrPilotModule.WAKE_ON_LAN.informationBanner(),
          _enabledToggle(),
          _broadcastAddress(),
          _macAddress(),
        ],
      ),
    );
  }

  Widget _enabledToggle() {
    return ArrPilotBlock(
      title: 'settings.EnableModule'.tr(args: [ArrPilotModule.WAKE_ON_LAN.title]),
      trailing: ArrPilotSwitch(
        value: ArrPilotProfile.current.wakeOnLANEnabled,
        onChanged: (value) {
          ArrPilotProfile.current.wakeOnLANEnabled = value;
          ArrPilotProfile.current.save();
        },
      ),
    );
  }

  Widget _broadcastAddress() {
    String? broadcastAddress = ArrPilotProfile.current.wakeOnLANBroadcastAddress;
    return ArrPilotBlock(
      title: 'settings.BroadcastAddress'.tr(),
      body: [
        TextSpan(
          text:
              broadcastAddress == '' ? 'arrpilot.NotSet'.tr() : broadcastAddress,
        ),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values =
            await SettingsDialogs().editBroadcastAddress(
          context,
          broadcastAddress,
        );
        if (_values.item1) {
          ArrPilotProfile.current.wakeOnLANBroadcastAddress = _values.item2;
          ArrPilotProfile.current.save();
        }
      },
    );
  }

  Widget _macAddress() {
    String? macAddress = ArrPilotProfile.current.wakeOnLANMACAddress;
    return ArrPilotBlock(
      title: 'settings.MACAddress'.tr(),
      body: [
        TextSpan(text: macAddress == '' ? 'arrpilot.NotSet'.tr() : macAddress),
      ],
      trailing: const ArrPilotIconButton.arrow(),
      onTap: () async {
        Tuple2<bool, String> _values = await SettingsDialogs().editMACAddress(
          context,
          macAddress,
        );
        if (_values.item1) {
          ArrPilotProfile.current.wakeOnLANMACAddress = _values.item2;
          ArrPilotProfile.current.save();
        }
      },
    );
  }
}
