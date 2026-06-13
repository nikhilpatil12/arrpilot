import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliIPAddressDetailsGeolocationTile extends StatelessWidget {
  final TautulliGeolocationInfo geolocation;

  const TautulliIPAddressDetailsGeolocationTile({
    Key? key,
    required this.geolocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(
            title: 'country', body: geolocation.country ?? ArrPilotUI.TEXT_EMDASH),
        ArrPilotTableContent(
            title: 'region', body: geolocation.region ?? ArrPilotUI.TEXT_EMDASH),
        ArrPilotTableContent(
            title: 'city', body: geolocation.city ?? ArrPilotUI.TEXT_EMDASH),
        ArrPilotTableContent(
            title: 'postal',
            body: geolocation.postalCode ?? ArrPilotUI.TEXT_EMDASH),
        ArrPilotTableContent(
            title: 'timezone',
            body: geolocation.timezone ?? ArrPilotUI.TEXT_EMDASH),
        ArrPilotTableContent(
            title: 'latitude',
            body: '${geolocation.latitude ?? ArrPilotUI.TEXT_EMDASH}'),
        ArrPilotTableContent(
            title: 'longitude',
            body: '${geolocation.longitude ?? ArrPilotUI.TEXT_EMDASH}'),
      ],
    );
  }
}
