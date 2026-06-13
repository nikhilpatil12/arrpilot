import 'package:flutter/material.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/int/bytes.dart';
import 'package:arrpilot/extensions/string/string.dart';
import 'package:arrpilot/modules/search.dart';

class SearchResultTile extends StatelessWidget {
  final NewznabResultData data;

  const SearchResultTile({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotExpandableListTile(
      title: data.title,
      collapsedSubtitles: [
        _subtitle1(),
        _subtitle2(),
      ],
      expandedTableContent: _tableContent(),
      collapsedTrailing: _trailing(context),
      expandedTableButtons: _tableButtons(context),
    );
  }

  TextSpan _subtitle1() {
    return TextSpan(children: [
      TextSpan(text: data.size.asBytes()),
      TextSpan(text: ArrPilotUI.TEXT_BULLET.pad()),
      TextSpan(text: data.category),
    ]);
  }

  TextSpan _subtitle2() {
    return TextSpan(text: data.age);
  }

  List<ArrPilotTableContent> _tableContent() {
    return [
      ArrPilotTableContent(title: 'search.Age'.tr(), body: data.age),
      ArrPilotTableContent(title: 'search.Size'.tr(), body: data.size.asBytes()),
      ArrPilotTableContent(title: 'search.Category'.tr(), body: data.category),
      if (SearchDatabase.SHOW_LINKS.read())
        ArrPilotTableContent(title: '', body: ''),
      if (SearchDatabase.SHOW_LINKS.read())
        ArrPilotTableContent(
            title: 'search.Comments'.tr(),
            body: data.linkComments,
            bodyIsUrl: true),
      if (SearchDatabase.SHOW_LINKS.read())
        ArrPilotTableContent(
            title: 'search.Download'.tr(),
            body: data.linkDownload,
            bodyIsUrl: true),
    ];
  }

  List<ArrPilotButton> _tableButtons(BuildContext context) {
    return [
      ArrPilotButton.text(
        icon: Icons.download_rounded,
        text: 'search.Download'.tr(),
        onTap: () async => _sendToClient(context),
      ),
    ];
  }

  ArrPilotIconButton _trailing(BuildContext context) {
    return ArrPilotIconButton(
      icon: Icons.download_rounded,
      onPressed: () => _sendToClient(context),
    );
  }

  Future<void> _sendToClient(BuildContext context) async {
    Tuple2<bool, SearchDownloadType?> result =
        await SearchDialogs().downloadResult(context);
    if (result.item1) result.item2!.execute(context, data);
  }
}
