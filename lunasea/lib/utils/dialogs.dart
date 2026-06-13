import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arrpilot/core.dart';

class ArrPilotDialogs {
  /// Show an an edit text prompt.
  ///
  /// Can pass in [prefill] String to prefill the [TextFormField]. Can also pass in a list of [TextSpan] tp show text above the field.
  ///
  /// Returns list containing:
  /// - 0: Flag (true if they hit save, false if they cancelled the prompt)
  /// - 1: Value from the [TextEditingController].
  Future<Tuple2<bool, String>> editText(
      BuildContext context, String dialogTitle,
      {String prefill = '', List<TextSpan>? extraText}) async {
    bool _flag = false;
    final _formKey = GlobalKey<FormState>();
    final _textController = TextEditingController()..text = prefill;

    void _setValues(bool flag) {
      if (_formKey.currentState?.validate() ?? false) {
        _flag = flag;
        Navigator.of(context, rootNavigator: true).pop();
      }
    }

    await ArrPilotDialog.dialog(
      context: context,
      title: dialogTitle,
      buttons: [
        ArrPilotDialog.button(
          text: 'Save',
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        if (extraText?.isNotEmpty ?? false)
          ArrPilotDialog.richText(children: extraText),
        Form(
          key: _formKey,
          child: ArrPilotDialog.textFormInput(
            controller: _textController,
            title: dialogTitle,
            onSubmitted: (_) => _setValues(true),
            validator: (_) => null,
          ),
        ),
      ],
      contentPadding: (extraText?.length ?? 0) == 0
          ? ArrPilotDialog.inputDialogContentPadding()
          : ArrPilotDialog.inputTextDialogContentPadding(),
    );
    return Tuple2(_flag, _textController.text);
  }

  /// Show a text preview dialog.
  ///
  /// Can pass in boolean [alignLeft] to left align the text in the dialog (useful for bulleted lists)
  Future<void> textPreview(
      BuildContext context, String? dialogTitle, String text,
      {bool alignLeft = false}) async {
    await ArrPilotDialog.dialog(
      context: context,
      title: dialogTitle,
      cancelButtonText: 'Close',
      buttons: [
        ArrPilotDialog.button(
            text: 'Copy',
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: text));
              showLunaSuccessSnackBar(
                  title: 'Copied Content',
                  message: 'Copied text to the clipboard');
              Navigator.of(context, rootNavigator: true).pop();
            }),
      ],
      content: [
        ArrPilotDialog.textContent(text: text),
      ],
      contentPadding: ArrPilotDialog.textDialogContentPadding(),
    );
  }

  Future<void> showRejections(
      BuildContext context, List<String> rejections) async {
    if (rejections.isEmpty)
      return textPreview(
        context,
        'Rejection Reasons',
        'No rejections found',
      );

    await ArrPilotDialog.dialog(
      context: context,
      title: 'Rejection Reasons',
      cancelButtonText: 'Close',
      content: List.generate(
        rejections.length,
        (index) => ArrPilotDialog.tile(
          text: rejections[index],
          icon: Icons.report_outlined,
          iconColor: ArrPilotColours.red,
        ),
      ),
      contentPadding: ArrPilotDialog.listDialogContentPadding(),
    );
  }

  Future<void> showMessages(BuildContext context, List<String> messages) async {
    if (messages.isEmpty) {
      return textPreview(context, 'Messages', 'No messages found');
    }
    await ArrPilotDialog.dialog(
      context: context,
      title: 'Messages',
      cancelButtonText: 'Close',
      content: List.generate(
        messages.length,
        (index) => ArrPilotDialog.tile(
          text: messages[index],
          icon: Icons.info_outline_rounded,
          iconColor: ArrPilotColours.accent,
        ),
      ),
      contentPadding: ArrPilotDialog.listDialogContentPadding(),
    );
  }

  /// **Will be removed in future**
  ///
  /// Show a delete catalogue with all files warning dialog.
  Future<List<dynamic>> deleteCatalogueWithFiles(
      BuildContext context, String moduleTitle) async {
    bool _flag = false;

    void _setValues(bool flag) {
      _flag = flag;
      Navigator.of(context, rootNavigator: true).pop();
    }

    await ArrPilotDialog.dialog(
      context: context,
      title: 'Delete All Files',
      buttons: [
        ArrPilotDialog.button(
          text: 'Delete',
          textColor: ArrPilotColours.red,
          onPressed: () => _setValues(true),
        ),
      ],
      content: [
        ArrPilotDialog.textContent(
            text:
                'Are you sure you want to delete all the files and folders for $moduleTitle?'),
      ],
      contentPadding: ArrPilotDialog.textDialogContentPadding(),
    );
    return [_flag];
  }

  Future<ArrPilotModule?> selectDownloadClient() async {
    final profile = ArrPilotProfile.current;
    final context = ArrPilotState.context;
    ArrPilotModule? module;

    await ArrPilotDialog.dialog(
      context: context,
      title: 'lunasea.DownloadClient'.tr(),
      content: [
        if (profile.nzbgetEnabled)
          ArrPilotDialog.tile(
            text: ArrPilotModule.NZBGET.title,
            icon: ArrPilotModule.NZBGET.icon,
            iconColor: ArrPilotModule.NZBGET.color,
            onTap: () {
              module = ArrPilotModule.NZBGET;
              Navigator.of(context).pop();
            },
          ),
        if (profile.sabnzbdEnabled)
          ArrPilotDialog.tile(
            text: ArrPilotModule.SABNZBD.title,
            icon: ArrPilotModule.SABNZBD.icon,
            iconColor: ArrPilotModule.SABNZBD.color,
            onTap: () {
              module = ArrPilotModule.SABNZBD;
              Navigator.of(context).pop();
            },
          ),
      ],
      contentPadding: ArrPilotDialog.listDialogContentPadding(),
    );

    return module;
  }
}
