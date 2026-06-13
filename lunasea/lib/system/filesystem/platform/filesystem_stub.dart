// ignore: always_use_package_imports
import '../filesystem.dart';

bool isPlatformSupported() => false;
ArrPilotFileSystem getFileSystem() =>
    throw UnsupportedError('ArrPilotFileSystem unsupported');
