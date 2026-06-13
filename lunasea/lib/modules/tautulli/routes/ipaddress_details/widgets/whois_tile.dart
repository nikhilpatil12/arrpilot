import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/modules/tautulli.dart';

class TautulliIPAddressDetailsWHOISTile extends StatelessWidget {
  final TautulliWHOISInfo whois;

  const TautulliIPAddressDetailsWHOISTile({
    Key? key,
    required this.whois,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotTableCard(
      content: [
        ArrPilotTableContent(title: 'host', body: whois.host ?? ArrPilotUI.TEXT_EMDASH),
        ..._subnets(),
      ],
    );
  }

  List<ArrPilotTableContent> _subnets() {
    if (whois.subnets?.isEmpty ?? true) return [];
    return whois.subnets!.fold<List<ArrPilotTableContent>>([], (list, subnet) {
      list.add(ArrPilotTableContent(
        title: 'isp',
        body: [
          subnet.description ?? ArrPilotUI.TEXT_EMDASH,
          '\n\n${subnet.address ?? ArrPilotUI.TEXT_EMDASH}',
          '\n${subnet.city}, ${subnet.state ?? ArrPilotUI.TEXT_EMDASH}',
          '\n${subnet.postalCode ?? ArrPilotUI.TEXT_EMDASH}',
          '\n${subnet.country ?? ArrPilotUI.TEXT_EMDASH}',
        ].join(),
      ));
      return list;
    });
  }
}
