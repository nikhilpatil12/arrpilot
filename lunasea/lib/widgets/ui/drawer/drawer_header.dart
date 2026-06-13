import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';

class ArrPilotDrawerHeader extends StatelessWidget {
  final String page;

  const ArrPilotDrawerHeader({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotDatabase.ENABLED_PROFILE.listenableBuilder(
      builder: (context, _) => Container(
        child: ArrPilotAppBar.dropdown(
          backgroundColor: Colors.transparent,
          hideLeading: true,
          useDrawer: false,
          title: ArrPilotBox.profiles.keys.length == 1
              ? 'ArrPilot'
              : ArrPilotDatabase.ENABLED_PROFILE.read(),
          profiles: ArrPilotBox.profiles.keys.cast<String>().toList(),
          actions: [
            ArrPilotIconButton(
              icon: ArrPilotIcons.SETTINGS,
              onPressed: page == ArrPilotModule.SETTINGS.key
                  ? Navigator.of(context).pop
                  : ArrPilotModule.SETTINGS.launch,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: ArrPilotColours.accent,
          image: DecorationImage(
            image: const AssetImage(ArrPilotAssets.brandingLogo),
            colorFilter: ColorFilter.mode(
              ArrPilotColours.primary.withOpacity(0.15),
              BlendMode.dstATop,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
