import 'package:flutter/material.dart';
import 'package:arrpilot/modules.dart';
import 'package:arrpilot/router/router.dart';
import 'package:arrpilot/router/routes/dashboard.dart';
import 'package:arrpilot/vendor.dart';
import 'package:arrpilot/widgets/ui.dart';

class ArrPilotMessage extends StatelessWidget {
  final String text;
  final Color textColor;
  final String? buttonText;
  final Function? onTap;
  final bool useSafeArea;

  const ArrPilotMessage({
    Key? key,
    required this.text,
    this.textColor = Colors.white,
    this.buttonText,
    this.onTap,
    this.useSafeArea = true,
  }) : super(key: key);

  /// Return a message that is meant to be shown within a [ListView].
  factory ArrPilotMessage.inList({
    Key? key,
    required String text,
    bool useSafeArea = false,
  }) {
    return ArrPilotMessage(
      key: key,
      text: text,
      useSafeArea: useSafeArea,
    );
  }

  /// Returns a centered message with a simple message, with a button to pop out of the route.
  factory ArrPilotMessage.goBack({
    Key? key,
    required String text,
    required BuildContext context,
    bool useSafeArea = true,
  }) {
    return ArrPilotMessage(
      key: key,
      text: text,
      buttonText: 'lunasea.GoBack'.tr(),
      onTap: () {
        if (ArrPilotRouter.router.canPop()) {
          ArrPilotRouter.router.pop();
        } else {
          ArrPilotRouter.router.pushReplacement(DashboardRoutes.HOME.path);
        }
      },
      useSafeArea: useSafeArea,
    );
  }

  /// Return a pre-structured "An Error Has Occurred" message, with a "Try Again" button shown.
  factory ArrPilotMessage.error({
    Key? key,
    required Function onTap,
    bool useSafeArea = true,
  }) {
    return ArrPilotMessage(
      key: key,
      text: 'lunasea.AnErrorHasOccurred'.tr(),
      buttonText: 'lunasea.TryAgain'.tr(),
      onTap: onTap,
      useSafeArea: useSafeArea,
    );
  }

  /// Return a pre-structured "<module> Is Not Enabled" message, with a "Return to Dashboard" button shown.
  factory ArrPilotMessage.moduleNotEnabled({
    Key? key,
    required BuildContext context,
    required String module,
    bool useSafeArea = true,
  }) {
    return ArrPilotMessage(
      key: key,
      text: 'lunasea.ModuleIsNotEnabled'.tr(args: [module]),
      buttonText: 'lunasea.ReturnToDashboard'.tr(),
      onTap: ArrPilotModule.DASHBOARD.launch,
      useSafeArea: useSafeArea,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: useSafeArea,
      left: useSafeArea,
      right: useSafeArea,
      bottom: useSafeArea,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Card(
            margin: ArrPilotUI.MARGIN_H_DEFAULT_V_HALF,
            elevation: ArrPilotUI.ELEVATION,
            shape: ArrPilotUI.shapeBorder,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: ArrPilotUI.FONT_WEIGHT_BOLD,
                        fontSize: ArrPilotUI.FONT_SIZE_MESSAGES,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 24.0, horizontal: 12.0),
                  ),
                ),
              ],
            ),
          ),
          if (buttonText != null)
            ArrPilotButtonContainer(
              children: [
                ArrPilotButton.text(
                  text: buttonText!,
                  icon: null,
                  onTap: onTap,
                  color: Colors.white,
                  backgroundColor: ArrPilotColours.accent,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
