// ignore: always_use_package_imports
import 'platform/network_stub.dart'
    if (dart.library.io) 'platform/network_io.dart'
    if (dart.library.html) 'platform/network_html.dart';

abstract class ArrPilotNetwork {
  static bool get isSupported => isPlatformSupported();
  factory ArrPilotNetwork() => getNetwork();

  void initialize();
}
