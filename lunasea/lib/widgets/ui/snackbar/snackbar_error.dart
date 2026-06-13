import 'package:arrpilot/core.dart';

Future<void> showLunaErrorSnackBar({
  required String title,
  dynamic error,
  String? message,
  bool showButton = false,
  String buttonText = 'view',
  Function? buttonOnPressed,
}) async =>
    showLunaSnackBar(
      title: title,
      message: message ?? ArrPilotLogger.checkLogsMessage,
      type: ArrPilotSnackbarType.ERROR,
      showButton: error != null || showButton,
      buttonText: buttonText,
      buttonOnPressed: () async {
        if (error != null) {
          ArrPilotDialogs().textPreview(
            ArrPilotState.context,
            'Error',
            error.toString(),
          );
        } else if (buttonOnPressed != null) {
          buttonOnPressed();
        }
      },
    );
