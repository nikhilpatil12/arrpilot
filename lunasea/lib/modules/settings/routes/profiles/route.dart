import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/utils/profile_tools.dart';

class ProfilesRoute extends StatefulWidget {
  const ProfilesRoute({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfilesRoute> createState() => _State();
}

class _State extends State<ProfilesRoute> with ArrPilotScrollControllerMixin {
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
      title: 'settings.Profiles'.tr(),
      scrollControllers: [scrollController],
    );
  }

  Widget _body() {
    return ArrPilotListView(
      controller: scrollController,
      children: [
        SettingsBanners.PROFILES_SUPPORT.banner(),
        _enabledProfile(),
        _addProfile(),
        _renameProfile(),
        _deleteProfile(),
      ],
    );
  }

  Widget _addProfile() {
    return ArrPilotBlock(
      title: 'settings.AddProfile'.tr(),
      body: [TextSpan(text: 'settings.AddProfileDescription'.tr())],
      trailing: const ArrPilotIconButton(icon: ArrPilotIcons.ADD),
      onTap: () async {
        final dialogs = SettingsDialogs();
        final context = ArrPilotState.context;
        final profiles = ArrPilotProfile.list;

        final selected = await dialogs.addProfile(context, profiles);
        if (selected.item1) {
          ArrPilotProfileTools().create(selected.item2);
        }
      },
    );
  }

  Widget _renameProfile() {
    return ArrPilotBlock(
      title: 'settings.RenameProfile'.tr(),
      body: [TextSpan(text: 'settings.RenameProfileDescription'.tr())],
      trailing: const ArrPilotIconButton(icon: ArrPilotIcons.RENAME),
      onTap: () async {
        final dialogs = SettingsDialogs();
        final context = ArrPilotState.context;
        final profiles = ArrPilotProfile.list;

        final selected = await dialogs.renameProfile(context, profiles);
        if (selected.item1) {
          final name = await dialogs.renameProfileSelected(context, profiles);
          if (name.item1) {
            ArrPilotProfileTools().rename(selected.item2, name.item2);
          }
        }
      },
    );
  }

  Widget _deleteProfile() {
    return ArrPilotBlock(
        title: 'settings.DeleteProfile'.tr(),
        body: [TextSpan(text: 'settings.DeleteProfileDescription'.tr())],
        trailing: const ArrPilotIconButton(icon: ArrPilotIcons.DELETE),
        onTap: () async {
          final dialogs = SettingsDialogs();
          final enabledProfile = ArrPilotDatabase.ENABLED_PROFILE.read();
          final context = ArrPilotState.context;
          final profiles = ArrPilotProfile.list;
          profiles.removeWhere((p) => p == enabledProfile);

          if (profiles.isEmpty) {
            showLunaInfoSnackBar(
              title: 'settings.NoProfilesFound'.tr(),
              message: 'settings.NoAdditionalProfilesAdded'.tr(),
            );
            return;
          }

          final selected = await dialogs.deleteProfile(context, profiles);
          if (selected.item1) {
            ArrPilotProfileTools().remove(selected.item2);
          }
        });
  }

  Widget _enabledProfile() {
    const db = ArrPilotDatabase.ENABLED_PROFILE;
    return db.listenableBuilder(
      builder: (context, _) => ArrPilotBlock(
        title: 'settings.EnabledProfile'.tr(),
        body: [TextSpan(text: db.read())],
        trailing: const ArrPilotIconButton(icon: ArrPilotIcons.USER),
        onTap: () async {
          final dialogs = SettingsDialogs();
          final enabledProfile = ArrPilotDatabase.ENABLED_PROFILE.read();
          final context = ArrPilotState.context;
          final profiles = ArrPilotProfile.list;
          profiles.removeWhere((p) => p == enabledProfile);

          if (profiles.isEmpty) {
            showLunaInfoSnackBar(
              title: 'settings.NoProfilesFound'.tr(),
              message: 'settings.NoAdditionalProfilesAdded'.tr(),
            );
            return;
          }

          final selected = await dialogs.enabledProfile(context, profiles);
          if (selected.item1) {
            ArrPilotProfileTools().changeTo(selected.item2);
          }
        },
      ),
    );
  }
}
