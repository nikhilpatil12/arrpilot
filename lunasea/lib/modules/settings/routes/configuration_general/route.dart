import 'package:flutter/material.dart';

import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/tables/bios.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/system/network/network.dart';
import 'package:arrpilot/system/platform.dart';

class ConfigurationGeneralRoute extends StatefulWidget {
  const ConfigurationGeneralRoute({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _State();
}

class _State extends State<ConfigurationGeneralRoute>
    with ArrPilotScrollControllerMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
      title: 'settings.General'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        ..._appearance(),
        ..._localization(),
        ..._modules(),
        if (ArrPilotNetwork.isSupported) ..._network(),
        ..._platform(),
      ],
    );
  }

  List<Widget> _appearance() {
    return [
      ArrPilotHeader(text: 'settings.Appearance'.tr()),
      _imageBackgroundOpacity(),
      _amoledTheme(),
      _amoledThemeBorders(),
    ];
  }

  List<Widget> _localization() {
    return [
      ArrPilotHeader(text: 'settings.Localization'.tr()),
      _use24HourTime(),
    ];
  }

  List<Widget> _modules() {
    return [
      ArrPilotHeader(text: 'dashboard.Modules'.tr()),
      _bootModule(),
    ];
  }

  List<Widget> _network() {
    return [
      ArrPilotHeader(text: 'settings.Network'.tr()),
      _useTLSValidation(),
    ];
  }

  List<Widget> _platform() {
    if (ArrPilotPlatform.isAndroid) {
      return [
        ArrPilotHeader(text: 'settings.Platform'.tr()),
        _openDrawerOnBackAction(),
      ];
    }

    return [];
  }

  Widget _openDrawerOnBackAction() {
    const _db = ArrPilotDatabase.ANDROID_BACK_OPENS_DRAWER;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.OpenDrawerOnBackAction'.tr(),
        body: [
          TextSpan(text: 'settings.OpenDrawerOnBackActionDescription'.tr()),
        ],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _amoledTheme() {
    const _db = ArrPilotDatabase.THEME_AMOLED;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.AmoledTheme'.tr(),
        body: [
          TextSpan(text: 'settings.AmoledThemeDescription'.tr()),
        ],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: (value) {
            _db.update(value);
            ArrPilotTheme().initialize();
          },
        ),
      ),
    );
  }

  Widget _amoledThemeBorders() {
    return ArrPilotBox.lunasea.listenableBuilder(
      selectItems: [
        ArrPilotDatabase.THEME_AMOLED_BORDER,
        ArrPilotDatabase.THEME_AMOLED,
      ],
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.AmoledThemeBorders'.tr(),
        body: [
          TextSpan(text: 'settings.AmoledThemeBordersDescription'.tr()),
        ],
        trailing: ArrPilotSwitch(
          value: ArrPilotDatabase.THEME_AMOLED_BORDER.read(),
          onChanged: ArrPilotDatabase.THEME_AMOLED.read()
              ? ArrPilotDatabase.THEME_AMOLED_BORDER.update
              : null,
        ),
      ),
    );
  }

  Widget _imageBackgroundOpacity() {
    const _db = ArrPilotDatabase.THEME_IMAGE_BACKGROUND_OPACITY;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.BackgroundImageOpacity'.tr(),
        body: [
          TextSpan(
            text: _db.read() == 0 ? 'lunasea.Disabled'.tr() : '${_db.read()}%',
          ),
        ],
        trailing: const ArrPilotIconButton.arrow(),
        onTap: () async {
          Tuple2<bool, int> result =
              await SettingsDialogs().changeBackgroundImageOpacity(context);
          if (result.item1) _db.update(result.item2);
        },
      ),
    );
  }

  Widget _useTLSValidation() {
    const _db = ArrPilotDatabase.NETWORKING_TLS_VALIDATION;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.TLSCertificateValidation'.tr(),
        body: [
          TextSpan(text: 'settings.TLSCertificateValidationDescription'.tr()),
        ],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: (data) {
            _db.update(data);
            if (ArrPilotNetwork.isSupported) ArrPilotNetwork().initialize();
          },
        ),
      ),
    );
  }

  Widget _use24HourTime() {
    const _db = ArrPilotDatabase.USE_24_HOUR_TIME;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.Use24HourTime'.tr(),
        body: [TextSpan(text: 'settings.Use24HourTimeDescription'.tr())],
        trailing: ArrPilotSwitch(
          value: _db.read(),
          onChanged: _db.update,
        ),
      ),
    );
  }

  Widget _bootModule() {
    const _db = BIOSDatabase.BOOT_MODULE;
    return _db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.BootModule'.tr(),
        body: [TextSpan(text: _db.read().title)],
        trailing: ArrPilotIconButton(icon: _db.read().icon),
        onTap: () async {
          final result = await SettingsDialogs().selectBootModule();
          if (result.item1) {
            BIOSDatabase.BOOT_MODULE.update(result.item2!);
          }
        },
      ),
    );
  }
}
