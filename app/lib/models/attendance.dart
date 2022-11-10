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

  String get str {
    switch (this) {
      case AttendanceType.absent:
        return 'absent';
      case AttendanceType.excused:
        return 'excused';
      case AttendanceType.holiday:
        return 'holiday';
      case AttendanceType.present:
        return 'present';
      case AttendanceType.none:
        return 'none';
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
  const Attendance(
      {required this.id, this.status = AttendanceType.none, this.reason = ''});

  factory Attendance.empty() {
    return Attendance(id: attendanceId());
  }

  final String id;
  final AttendanceType? status;
  final String? reason;

  Attendance from({AttendanceType? status, String? reason}) {
    return Attendance(
      id: id,
      status: status ?? this.status,
      reason: reason ?? this.reason,
    );
  }

  Future<void> upsert(Student s, DateTime date) {
    final dateId = DateFormat('yyyy-MM-dd').format(date);
    final data = {'status': status!.str, 'reason': reason};
    if (status != AttendanceType.excused) data.remove('reason');
    return FirebaseDatabase.instance
        .ref('attendances/$dateId/${s.id}')
        .update(data);
  }
}

String attendanceId() {
  return 'att-${customAlphabet(nanoIdChars, 12)}';
}

class AttendanceNotifier extends StateNotifier<Attendance> {
  AttendanceNotifier(Attendance a) : super(a);

  void update({DateTime? date, AttendanceType? status, String? reason}) {
    state = state.from(status: status, reason: reason);
  }
}
