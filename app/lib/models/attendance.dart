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
      case AttendanceType.excused:
        return 'Absent Excused';
      default:
        return toBeginningOfSentenceCase(name)!;
    }
  }

  String get display {
    switch (this) {
      case AttendanceType.none:
        return 'is not marked';
      case AttendanceType.holiday:
        return 'is on $name';
      default:
        return 'is $name';
    }
  }
}

class Attendance {
  Attendance({required this.date, this.studentId, this.status, this.reason});

  DateTime date;
  String? studentId;
  AttendanceType? status;
  String? reason;
}
