import 'package:flutter/material.dart';

import 'package:arrpilot/core.dart';
import 'package:arrpilot/database/config.dart';
import 'package:arrpilot/system/filesystem/file.dart';
import 'package:arrpilot/system/filesystem/filesystem.dart';

class SettingsSystemBackupRestoreRestoreTile extends StatelessWidget {
  const SettingsSystemBackupRestoreRestoreTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ArrPilotBlock(
      title: 'settings.RestoreFromDevice'.tr(),
      body: [TextSpan(text: 'settings.RestoreFromDeviceDescription'.tr())],
      trailing: const ArrPilotIconButton(icon: Icons.download_rounded),
      onTap: () async => _restore(context),
    );
  }

  Future<void> _restore(BuildContext context) async {
    try {
      ArrPilotFile? file = await ArrPilotFileSystem().read(context, ['lunasea']);
      if (file != null) await _decryptBackup(context, file);
    } catch (error, stack) {
      ArrPilotLogger().error('Failed to restore device backup', error, stack);
      showLunaErrorSnackBar(
        title: 'settings.RestoreFromCloudFailure'.tr(),
        error: error,
      );
    }
  }

  Future<void> _decryptBackup(
    BuildContext context,
    ArrPilotFile file,
  ) async {
    String encrypted = String.fromCharCodes(file.data);
    try {
      await ArrPilotConfig().import(context, encrypted);
      showLunaSuccessSnackBar(
        title: 'settings.RestoreFromCloudSuccess'.tr(),
        message: 'settings.RestoreFromCloudSuccessMessage'.tr(),
      );
    } catch (_) {
      showLunaErrorSnackBar(
        title: 'settings.RestoreFromCloudFailure'.tr(),
        message: 'lunasea.IncorrectEncryptionKey'.tr(),
        showButton: true,
        buttonText: 'lunasea.Retry'.tr(),
        buttonOnPressed: () async => _decryptBackup(context, file),
      );
    }
  }
}
