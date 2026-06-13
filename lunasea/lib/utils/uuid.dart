import 'package:uuid/uuid.dart';

class ArrPilotUUID {
  static const Uuid _generator = Uuid();

  String generate() {
    return _generator.v4();
  }
}
