import 'package:flutter/material.dart';

import 'package:quick_actions/quick_actions.dart';
import 'package:arrpilot/core.dart';
import 'package:arrpilot/extensions/string/links.dart';
import 'package:arrpilot/router/router.dart';
import 'package:arrpilot/router/routes.dart';
import 'package:arrpilot/router/routes/settings.dart';
import 'package:arrpilot/modules/search.dart';
import 'package:arrpilot/modules/settings.dart';
import 'package:arrpilot/modules/lidarr.dart';
import 'package:arrpilot/modules/radarr.dart';
import 'package:arrpilot/modules/sonarr.dart';
import 'package:arrpilot/modules/sabnzbd.dart';
import 'package:arrpilot/modules/nzbget.dart';
import 'package:arrpilot/modules/tautulli.dart';
import 'package:arrpilot/modules/dashboard/core/state.dart';
import 'package:arrpilot/api/wake_on_lan/wake_on_lan.dart';

part 'modules.g.dart';

const MODULE_DASHBOARD_KEY = 'dashboard';
const MODULE_EXTERNAL_MODULES_KEY = 'external_modules';
const MODULE_LIDARR_KEY = 'lidarr';
const MODULE_NZBGET_KEY = 'nzbget';
const MODULE_SEERR_KEY = 'seerr';
const MODULE_RADARR_KEY = 'radarr';
const MODULE_SABNZBD_KEY = 'sabnzbd';
const MODULE_SEARCH_KEY = 'search';
const MODULE_SETTINGS_KEY = 'settings';
const MODULE_SONARR_KEY = 'sonarr';
const MODULE_TAUTULLI_KEY = 'tautulli';
const MODULE_WAKE_ON_LAN_KEY = 'wake_on_lan';

@HiveType(typeId: 25, adapterName: 'ArrPilotModuleAdapter')
enum ArrPilotModule {
  @HiveField(0)
  DASHBOARD(MODULE_DASHBOARD_KEY),
  @HiveField(11)
  EXTERNAL_MODULES(MODULE_EXTERNAL_MODULES_KEY),
  @HiveField(1)
  LIDARR(MODULE_LIDARR_KEY),
  @HiveField(2)
  NZBGET(MODULE_NZBGET_KEY),
  @HiveField(3)
  SEERR(MODULE_SEERR_KEY),
  @HiveField(4)
  RADARR(MODULE_RADARR_KEY),
  @HiveField(5)
  SABNZBD(MODULE_SABNZBD_KEY),
  @HiveField(6)
  SEARCH(MODULE_SEARCH_KEY),
  @HiveField(7)
  SETTINGS(MODULE_SETTINGS_KEY),
  @HiveField(8)
  SONARR(MODULE_SONARR_KEY),
  @HiveField(9)
  TAUTULLI(MODULE_TAUTULLI_KEY),
  @HiveField(10)
  WAKE_ON_LAN(MODULE_WAKE_ON_LAN_KEY);

  final String key;
  const ArrPilotModule(this.key);

  static ArrPilotModule? fromKey(String? key) {
    switch (key) {
      case MODULE_DASHBOARD_KEY:
        return ArrPilotModule.DASHBOARD;
      case MODULE_LIDARR_KEY:
        return ArrPilotModule.LIDARR;
      case MODULE_NZBGET_KEY:
        return ArrPilotModule.NZBGET;
      case MODULE_RADARR_KEY:
        return ArrPilotModule.RADARR;
      case MODULE_SABNZBD_KEY:
        return ArrPilotModule.SABNZBD;
      case MODULE_SEARCH_KEY:
        return ArrPilotModule.SEARCH;
      case MODULE_SETTINGS_KEY:
        return ArrPilotModule.SETTINGS;
      case MODULE_SONARR_KEY:
        return ArrPilotModule.SONARR;
      case MODULE_SEERR_KEY:
        return ArrPilotModule.SEERR;
      case MODULE_TAUTULLI_KEY:
        return ArrPilotModule.TAUTULLI;
      case MODULE_WAKE_ON_LAN_KEY:
        return ArrPilotModule.WAKE_ON_LAN;
      case MODULE_EXTERNAL_MODULES_KEY:
        return ArrPilotModule.EXTERNAL_MODULES;
    }
    return null;
  }

  static List<ArrPilotModule> get active {
    return ArrPilotModule.values.filter((m) {
      if (m == ArrPilotModule.DASHBOARD) return false;
      if (m == ArrPilotModule.SETTINGS) return false;
      return m.featureFlag;
    }).toList();
  }
}

extension ArrPilotModuleEnablementExtension on ArrPilotModule {
  bool get featureFlag {
    switch (this) {
      case ArrPilotModule.SEERR:
        return true;
      case ArrPilotModule.WAKE_ON_LAN:
        return ArrPilotWakeOnLAN.isSupported;
      default:
        return true;
    }
  }

  bool get isEnabled {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return true;
      case ArrPilotModule.SETTINGS:
        return true;
      case ArrPilotModule.LIDARR:
        return ArrPilotProfile.current.lidarrEnabled;
      case ArrPilotModule.NZBGET:
        return ArrPilotProfile.current.nzbgetEnabled;
      case ArrPilotModule.SEERR:
        return ArrPilotProfile.current.seerrEnabled;
      case ArrPilotModule.RADARR:
        return ArrPilotProfile.current.radarrEnabled;
      case ArrPilotModule.SABNZBD:
        return ArrPilotProfile.current.sabnzbdEnabled;
      case ArrPilotModule.SEARCH:
        return !ArrPilotBox.indexers.isEmpty;
      case ArrPilotModule.SONARR:
        return ArrPilotProfile.current.sonarrEnabled;
      case ArrPilotModule.TAUTULLI:
        return ArrPilotProfile.current.tautulliEnabled;
      case ArrPilotModule.WAKE_ON_LAN:
        return ArrPilotProfile.current.wakeOnLANEnabled;
      case ArrPilotModule.EXTERNAL_MODULES:
        return !ArrPilotBox.externalModules.isEmpty;
    }
  }
}

extension ArrPilotModuleMetadataExtension on ArrPilotModule {
  String get title {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return 'arrpilot.Dashboard'.tr();
      case ArrPilotModule.LIDARR:
        return 'Lidarr';
      case ArrPilotModule.NZBGET:
        return 'NZBGet';
      case ArrPilotModule.RADARR:
        return 'Radarr';
      case ArrPilotModule.SABNZBD:
        return 'SABnzbd';
      case ArrPilotModule.SEARCH:
        return 'search.Search'.tr();
      case ArrPilotModule.SETTINGS:
        return 'arrpilot.Settings'.tr();
      case ArrPilotModule.SONARR:
        return 'Sonarr';
      case ArrPilotModule.TAUTULLI:
        return 'Tautulli';
      case ArrPilotModule.SEERR:
        return 'Seerr';
      case ArrPilotModule.WAKE_ON_LAN:
        return 'Wake on LAN';
      case ArrPilotModule.EXTERNAL_MODULES:
        return 'arrpilot.ExternalModules'.tr();
    }
  }

  IconData get icon {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return Icons.home_rounded;
      case ArrPilotModule.LIDARR:
        return ArrPilotIcons.LIDARR;
      case ArrPilotModule.NZBGET:
        return ArrPilotIcons.NZBGET;
      case ArrPilotModule.RADARR:
        return ArrPilotIcons.RADARR;
      case ArrPilotModule.SABNZBD:
        return ArrPilotIcons.SABNZBD;
      case ArrPilotModule.SEARCH:
        return Icons.search_rounded;
      case ArrPilotModule.SETTINGS:
        return Icons.settings_rounded;
      case ArrPilotModule.SONARR:
        return ArrPilotIcons.SONARR;
      case ArrPilotModule.TAUTULLI:
        return ArrPilotIcons.TAUTULLI;
      case ArrPilotModule.SEERR:
        return ArrPilotIcons.SEERR;
      case ArrPilotModule.WAKE_ON_LAN:
        return Icons.settings_remote_rounded;
      case ArrPilotModule.EXTERNAL_MODULES:
        return Icons.settings_ethernet_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return ArrPilotColours.accent;
      case ArrPilotModule.LIDARR:
        return const Color(0xFF159552);
      case ArrPilotModule.NZBGET:
        return const Color(0xFF42D535);
      case ArrPilotModule.RADARR:
        return const Color(0xFFFEC333);
      case ArrPilotModule.SABNZBD:
        return const Color(0xFFFECC2B);
      case ArrPilotModule.SEARCH:
        return ArrPilotColours.accent;
      case ArrPilotModule.SETTINGS:
        return ArrPilotColours.accent;
      case ArrPilotModule.SONARR:
        return const Color(0xFF3FC6F4);
      case ArrPilotModule.TAUTULLI:
        return const Color(0xFFDBA23A);
      case ArrPilotModule.SEERR:
        return const Color(0xFF6366F1);
      case ArrPilotModule.WAKE_ON_LAN:
        return ArrPilotColours.accent;
      case ArrPilotModule.EXTERNAL_MODULES:
        return ArrPilotColours.accent;
    }
  }

  String? get website {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return null;
      case ArrPilotModule.LIDARR:
        return 'https://lidarr.audio';
      case ArrPilotModule.NZBGET:
        return 'https://nzbget.net';
      case ArrPilotModule.RADARR:
        return 'https://radarr.video';
      case ArrPilotModule.SABNZBD:
        return 'https://sabnzbd.org';
      case ArrPilotModule.SEARCH:
        return null;
      case ArrPilotModule.SETTINGS:
        return null;
      case ArrPilotModule.SONARR:
        return 'https://sonarr.tv';
      case ArrPilotModule.TAUTULLI:
        return 'https://tautulli.com';
      case ArrPilotModule.SEERR:
        return 'https://seerr.dev';
      case ArrPilotModule.WAKE_ON_LAN:
        return null;
      case ArrPilotModule.EXTERNAL_MODULES:
        return null;
    }
  }

  String? get github {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return null;
      case ArrPilotModule.LIDARR:
        return 'https://github.com/Lidarr/Lidarr';
      case ArrPilotModule.NZBGET:
        return 'https://github.com/nzbget/nzbget';
      case ArrPilotModule.RADARR:
        return 'https://github.com/Radarr/Radarr';
      case ArrPilotModule.SABNZBD:
        return 'https://github.com/sabnzbd/sabnzbd';
      case ArrPilotModule.SEARCH:
        return 'https://github.com/theotherp/nzbhydra2';
      case ArrPilotModule.SETTINGS:
        return null;
      case ArrPilotModule.SONARR:
        return 'https://github.com/Sonarr/Sonarr';
      case ArrPilotModule.TAUTULLI:
        return 'https://github.com/Tautulli/Tautulli';
      case ArrPilotModule.SEERR:
        return 'https://github.com/seerr/seerr';
      case ArrPilotModule.WAKE_ON_LAN:
        return null;
      case ArrPilotModule.EXTERNAL_MODULES:
        return null;
    }
  }

  String get description {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return 'arrpilot.Dashboard'.tr();
      case ArrPilotModule.LIDARR:
        return 'Manage Music';
      case ArrPilotModule.NZBGET:
        return 'Manage Usenet Downloads';
      case ArrPilotModule.RADARR:
        return 'Manage Movies';
      case ArrPilotModule.SABNZBD:
        return 'Manage Usenet Downloads';
      case ArrPilotModule.SEARCH:
        return 'Search Newznab Indexers';
      case ArrPilotModule.SETTINGS:
        return 'Configure ArrPilot';
      case ArrPilotModule.SONARR:
        return 'Manage Television Series';
      case ArrPilotModule.TAUTULLI:
        return 'View Plex Activity';
      case ArrPilotModule.SEERR:
        return 'Manage Media Requests';
      case ArrPilotModule.WAKE_ON_LAN:
        return 'Wake Your Machine';
      case ArrPilotModule.EXTERNAL_MODULES:
        return 'Access External Modules';
    }
  }

  String? get information {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return null;
      case ArrPilotModule.LIDARR:
        return 'Lidarr is a music collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new tracks from your favorite artists and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.';
      case ArrPilotModule.NZBGET:
        return 'NZBGet is a binary downloader, which downloads files from Usenet based on information given in nzb-files.';
      case ArrPilotModule.RADARR:
        return 'Radarr is a movie collection manager for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new movies and will interface with clients and indexers to grab, sort, and rename them. It can also be configured to automatically upgrade the quality of existing files in the library when a better quality format becomes available.';
      case ArrPilotModule.SABNZBD:
        return 'SABnzbd is a multi-platform binary newsgroup downloader. The program works in the background and simplifies the downloading verifying and extracting of files from Usenet.';
      case ArrPilotModule.SEARCH:
        return 'ArrPilot currently supports all indexers that support the newznab protocol, including NZBHydra2.';
      case ArrPilotModule.SETTINGS:
        return null;
      case ArrPilotModule.SONARR:
        return 'Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS feeds for new episodes of your favorite shows and will grab, sort and rename them. It can also be configured to automatically upgrade the quality of files already downloaded when a better quality format becomes available.';
      case ArrPilotModule.TAUTULLI:
        return 'Tautulli is an application that you can run alongside your Plex Media Server to monitor activity and track various statistics. Most importantly, these statistics include what has been watched, who watched it, when and where they watched it, and how it was watched.';
      case ArrPilotModule.SEERR:
        return 'Seerr is a free and open source media request management tool. It integrates with your existing services like Sonarr, Radarr, Plex, Jellyfin, and Emby to streamline content requests from your users.';
      case ArrPilotModule.WAKE_ON_LAN:
        return 'Wake on LAN is an industry standard protocol for waking computers up from a very low power mode remotely by sending a specially constructed packet to the machine.';
      case ArrPilotModule.EXTERNAL_MODULES:
        return 'ArrPilot allows you to add links to additional modules that are not currently supported allowing you to open the module\'s web GUI without having to leave ArrPilot!';
    }
  }
}

extension ArrPilotModuleRoutingExtension on ArrPilotModule {
  String? get homeRoute {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return ArrPilotRoutes.dashboard.root.path;
      case ArrPilotModule.LIDARR:
        return ArrPilotRoutes.lidarr.root.path;
      case ArrPilotModule.NZBGET:
        return ArrPilotRoutes.nzbget.root.path;
      case ArrPilotModule.RADARR:
        return ArrPilotRoutes.radarr.root.path;
      case ArrPilotModule.SABNZBD:
        return ArrPilotRoutes.sabnzbd.root.path;
      case ArrPilotModule.SEARCH:
        return ArrPilotRoutes.search.root.path;
      case ArrPilotModule.SETTINGS:
        return ArrPilotRoutes.settings.root.path;
      case ArrPilotModule.SONARR:
        return ArrPilotRoutes.sonarr.root.path;
      case ArrPilotModule.TAUTULLI:
        return ArrPilotRoutes.tautulli.root.path;
      case ArrPilotModule.SEERR:
        return null; // Will be updated when routes are created
      case ArrPilotModule.WAKE_ON_LAN:
        return null;
      case ArrPilotModule.EXTERNAL_MODULES:
        return ArrPilotRoutes.externalModules.root.path;
    }
  }

  SettingsRoutes? get settingsRoute {
    switch (this) {
      case ArrPilotModule.DASHBOARD:
        return SettingsRoutes.CONFIGURATION_DASHBOARD;
      case ArrPilotModule.LIDARR:
        return SettingsRoutes.CONFIGURATION_LIDARR;
      case ArrPilotModule.NZBGET:
        return SettingsRoutes.CONFIGURATION_NZBGET;
      case ArrPilotModule.SEERR:
        return null; // Will be updated when settings route is created
      case ArrPilotModule.RADARR:
        return SettingsRoutes.CONFIGURATION_RADARR;
      case ArrPilotModule.SABNZBD:
        return SettingsRoutes.CONFIGURATION_SABNZBD;
      case ArrPilotModule.SEARCH:
        return SettingsRoutes.CONFIGURATION_SEARCH;
      case ArrPilotModule.SETTINGS:
        return null;
      case ArrPilotModule.SONARR:
        return SettingsRoutes.CONFIGURATION_SONARR;
      case ArrPilotModule.TAUTULLI:
        return SettingsRoutes.CONFIGURATION_TAUTULLI;
      case ArrPilotModule.WAKE_ON_LAN:
        return SettingsRoutes.CONFIGURATION_WAKE_ON_LAN;
      case ArrPilotModule.EXTERNAL_MODULES:
        return SettingsRoutes.CONFIGURATION_EXTERNAL_MODULES;
    }
  }

  Future<void> launch() async {
    if (homeRoute != null) {
      ArrPilotRouter.router.pushReplacement(homeRoute!);
    }
  }
}

extension ArrPilotModuleWebhookExtension on ArrPilotModule {
  bool get hasWebhooks {
    switch (this) {
      case ArrPilotModule.LIDARR:
        return true;
      case ArrPilotModule.RADARR:
        return true;
      case ArrPilotModule.SONARR:
        return true;
      case ArrPilotModule.SEERR:
        return true;
      case ArrPilotModule.TAUTULLI:
        return true;
      default:
        return false;
    }
  }

  String? get webhookDocs {
    // TODO: Replace with ArrPilot documentation URLs when available
    // Currently referencing LunaSea docs as webhook setup process is identical
    switch (this) {
      case ArrPilotModule.LIDARR:
        return 'https://docs.lunasea.app/lunasea/notifications/lidarr';
      case ArrPilotModule.RADARR:
        return 'https://docs.lunasea.app/lunasea/notifications/radarr';
      case ArrPilotModule.SONARR:
        return 'https://docs.lunasea.app/lunasea/notifications/sonarr';
      case ArrPilotModule.SEERR:
        return 'https://docs.lunasea.app/lunasea/notifications/overseerr'; // TODO: Update when Seerr docs are available
      case ArrPilotModule.TAUTULLI:
        return 'https://docs.lunasea.app/lunasea/notifications/tautulli';
      default:
        return null;
    }
  }

  Future<void> handleWebhook(Map<String, dynamic> data) async {
    switch (this) {
      case ArrPilotModule.LIDARR:
        return LidarrWebhooks().handle(data);
      case ArrPilotModule.RADARR:
        return RadarrWebhooks().handle(data);
      case ArrPilotModule.SONARR:
        return SonarrWebhooks().handle(data);
      case ArrPilotModule.TAUTULLI:
        return TautulliWebhooks().handle(data);
      default:
        return;
    }
  }
}

extension ArrPilotModuleExtension on ArrPilotModule {
  ShortcutItem get shortcutItem {
    if (this == ArrPilotModule.WAKE_ON_LAN) {
      throw Exception('WAKE_ON_LAN does not have a shortcut item');
    }
    return ShortcutItem(type: key, localizedTitle: title);
  }

  ArrPilotModuleState? state(BuildContext context) {
    switch (this) {
      case ArrPilotModule.WAKE_ON_LAN:
        return null;
      case ArrPilotModule.DASHBOARD:
        return context.read<DashboardState>();
      case ArrPilotModule.SETTINGS:
        return context.read<SettingsState>();
      case ArrPilotModule.SEARCH:
        return context.read<SearchState>();
      case ArrPilotModule.LIDARR:
        return context.read<LidarrState>();
      case ArrPilotModule.RADARR:
        return context.read<RadarrState>();
      case ArrPilotModule.SONARR:
        return context.read<SonarrState>();
      case ArrPilotModule.NZBGET:
        return context.read<NZBGetState>();
      case ArrPilotModule.SABNZBD:
        return context.read<SABnzbdState>();
      case ArrPilotModule.SEERR:
        return null; // Will be updated when SeerrState is created
      case ArrPilotModule.TAUTULLI:
        return context.read<TautulliState>();
      case ArrPilotModule.EXTERNAL_MODULES:
        return null;
    }
  }

  Widget informationBanner() {
    String key = 'ARRPILOT_MODULE_INFORMATION_${this.key}';
    void markSeen() => ArrPilotBox.alerts.update(key, false);

    return ArrPilotBox.alerts.listenableBuilder(
      selectKeys: [key],
      builder: (context, _) {
        if (ArrPilotBox.alerts.read(key, fallback: true)) {
          return ArrPilotBanner(
            dismissCallback: markSeen,
            headerText: this.title,
            bodyText: this.information,
            icon: this.icon,
            iconColor: this.color,
            buttons: [
              if (this.github != null)
                ArrPilotButton.text(
                  text: 'GitHub',
                  icon: ArrPilotIcons.GITHUB,
                  onTap: this.github!.openLink,
                ),
              if (this.website != null)
                ArrPilotButton.text(
                  text: 'arrpilot.Website'.tr(),
                  icon: Icons.home_rounded,
                  onTap: this.website!.openLink,
                ),
            ],
          );
        }
        return const SizedBox(height: 0.0, width: double.infinity);
      },
    );
  }
}
