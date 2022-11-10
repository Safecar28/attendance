part of models;

enum AttendanceType {
  none,
  holiday,
  absent,
  excused,
  present,
}

extension AttendanceTypeExt on AttendanceType {
  String get title {
    switch (this) {
      case AttendanceType.holiday:
        return 'Holiday';
      case AttendanceType.absent:
        return 'Absent';
      case AttendanceType.excused:
        return 'Absent Excused';
      case AttendanceType.present:
        return 'Present';
      default:
        return 'None';
    }
  }

  String get titleVerb {
    switch (this) {
      case AttendanceType.none:
        return 'is not marked';
      case AttendanceType.holiday:
        return 'on $title'.toLowerCase();
      default:
        return 'is $title'.toLowerCase();
    }
  }
}

class Attendance {}
