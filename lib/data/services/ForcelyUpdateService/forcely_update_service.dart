import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

class ForceUpdateService {
  static const bool debugMode = false;
  static const Duration durationUntilAlertAgain = Duration(days: 3);
  static const bool canDismissDialog = false;

  static Widget wrapApp({
    required Widget child,
    bool? debugMode,
    bool? canDismiss,
    bool? showIgnoreButton,
    bool? showLaterButton,
    bool? showNotes,
    Duration? alertDuration,
  }) {
    final upgrader = Upgrader(
      debugDisplayAlways: debugMode ?? ForceUpdateService.debugMode,
      debugDisplayOnce: debugMode ?? ForceUpdateService.debugMode,
      debugLogging: true,
      durationUntilAlertAgain: alertDuration ?? durationUntilAlertAgain,
      messages: CustomUpgraderMessages(),
      willDisplayUpgrade:
          ({
            required bool display,
            String? installedVersion,
            UpgraderVersionInfo? versionInfo,
          }) {
            log('Display Upgrade: $display');
            log('Installed Version: $installedVersion');
            log('App Store Version: ${versionInfo?.appStoreVersion}');
            log('Min App Version: ${versionInfo?.minAppVersion}');
          },
    );

    return UpgradeAlert(
      upgrader: upgrader,
      barrierDismissible: canDismiss ?? canDismissDialog,
      shouldPopScope: () => canDismiss ?? canDismissDialog,
      dialogStyle: UpgradeDialogStyle.cupertino,
      showIgnore: showIgnoreButton ?? false,
      showLater: showLaterButton ?? false,
      showReleaseNotes: showNotes ?? true,
      onUpdate: () {
        log('User tapped UPDATE button');
        return true;
      },
      onIgnore: () {
        log('User tapped IGNORE button');
        return true;
      },
      onLater: () {
        log('User tapped LATER button');
        return true;
      },
      child: child,
    );
  }

  static Widget wrapAppCupertino({
    required Widget child,
    bool? debugMode,
    bool? canDismiss,
    bool? showIgnoreButton,
    bool? showLaterButton,
    bool? showNotes,
  }) {
    final upgrader = Upgrader(
      debugDisplayAlways: debugMode ?? ForceUpdateService.debugMode,
      debugDisplayOnce: debugMode ?? ForceUpdateService.debugMode,
      debugLogging: true,
      durationUntilAlertAgain: durationUntilAlertAgain,
      messages: CustomUpgraderMessages(),
      willDisplayUpgrade:
          ({
            required bool display,
            String? installedVersion,
            UpgraderVersionInfo? versionInfo,
          }) {
            log('Display Upgrade: $display');
            log('Installed Version: $installedVersion');
            log('App Store Version: ${versionInfo?.appStoreVersion}');
          },
    );

    return UpgradeAlert(
      upgrader: upgrader,
      barrierDismissible: canDismiss ?? canDismissDialog,
      shouldPopScope: () => canDismiss ?? canDismissDialog,
      dialogStyle: UpgradeDialogStyle.cupertino,
      showIgnore: showIgnoreButton ?? false,
      showLater: showLaterButton ?? false,
      showReleaseNotes: showNotes ?? true,
      onUpdate: () {
        log('User tapped UPDATE button');
        return true;
      },
      onIgnore: () {
        log('User tapped IGNORE button');
        return true;
      },
      onLater: () {
        log('User tapped LATER button');
        return true;
      },

      child: child,
    );
  }

  static Future<void> checkForUpdate(BuildContext context) async {
    final upgrader = Upgrader(
      debugDisplayAlways: debugMode,
      debugLogging: true,
      messages: CustomUpgraderMessages(),
    );

    await upgrader.initialize();

    if (context.mounted) {
      final shouldDisplay = await upgrader.shouldDisplayUpgrade();

      if (shouldDisplay) {
        log('Update available - showing dialog');
      } else {
        log('App is up to date');
      }
    }
  }

  static Future<void> clearSavedSettings() async {
    await Upgrader.clearSavedSettings();
    log('Upgrader settings cleared');
  }
}

class CustomUpgraderMessages extends UpgraderMessages {
  CustomUpgraderMessages({String? languageCode})
    : super(code: languageCode ?? 'en');

  @override
  String get title => 'Update Required ⚠️';

  @override
  String get body =>
      'This version of {{appName}} is no longer supported. '
      'Please update to version {{appStoreVersion}} to continue using the app. '
      'Your current version is {{currentInstalledVersion}}.';

  @override
  String get buttonTitleUpdate => 'Update Now';

  @override
  String get buttonTitleIgnore => 'Ignore';

  @override
  String get buttonTitleLater => 'Later';

  @override
  String get prompt =>
      'You must update to the latest version to continue. '
      'The app will not work without this update.';

  @override
  String get releaseNotes => "What's New";
}
