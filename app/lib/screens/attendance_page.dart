part of '../main.dart';

final currentAttendance = StateProvider<Attendance>((ref) {
  return Attendance(date: ref.watch(currentDate), status: AttendanceType.none);
});

final currentStudent = StateProvider<Student>((ref) {
  return Student();
});

class AttendancePage extends ConsumerWidget {
  const AttendancePage({
    Key? key,
    required this.students,
  }) : super(key: key);

  final List<Student> students;

  @override
  Widget build(context, ref) {
    final student = ref.watch(currentStudent);
    final state = ref.watch(currentAttendance);
    final choices = AttendanceType.values.map((e) => AttendanceRadio(kind: e));
    return Scaffold(
      appBar: AppBar(title: Text(student.name())),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CurrentDate(),
            ...choices,
            if (state.status == AttendanceType.excused) const ExcusedReason(),
            const Divider(),
            AttendanceDisplay(student: student, att: state),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                navButton('Previous', student, ref),
                navButton('Next', student, ref),
              ],
            )
          ],
        ),
      ),
    );
  }

  ElevatedButton navButton(String text, Student s, WidgetRef ref) {
    final move = text == 'Next' ? 1 : -1;
    final color = text == 'Next' ? Colors.green : Colors.red;
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: color, minimumSize: const Size(100, 40)),
        onPressed: () {
          final idx = students.indexOf(s) + move;
          if (idx >= 0 && idx < students.length) {
            ref.read(currentStudent.notifier).update((state) => students[idx]);
          }
        },
        child: Text(text));
  }
}

class AttendanceRadio extends ConsumerWidget {
  const AttendanceRadio({
    Key? key,
    required this.kind,
  }) : super(key: key);

  final AttendanceType kind;

  @override
  Widget build(context, ref) {
    var s = ref.watch(currentStudent);
    var att = ref.watch(currentAttendance);
    final notify = ref.read(currentAttendance.notifier);
    return ListTile(
      title: Text(kind.title),
      onTap: () => notify.update((_) => Attendance(
          date: att.date, status: kind, reason: att.reason, studentId: s.id)),
      leading: Radio<AttendanceType>(
        value: kind,
        groupValue: att.status,
        onChanged: (_) => {},
      ),
    );
  }
}

class ExcusedReason extends ConsumerWidget {
  const ExcusedReason({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(context, ref) {
    var state = ref.watch(currentAttendance);
    final notify = ref.read(currentAttendance.notifier);
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(7),
          child: TextFormField(
            maxLength: 100,
            initialValue: state.reason,
            onChanged: (value) =>
                notify.update((state) => state..reason = value),
            decoration:
                const InputDecoration.collapsed(hintText: 'Excused for?'),
          ),
        )
      ],
    );
  }
}

class AttendanceDisplay extends ConsumerWidget {
  const AttendanceDisplay({
    Key? key,
    required this.student,
    required this.att,
  }) : super(key: key);

  final Student student;
  final Attendance att;

  @override
  Widget build(context, ref) {
    final date = DateFormat.Md().format(ref.watch(currentDate));
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        '${student.firstName} ${att.status?.display} on $date',
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
    );
  }
}
